import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MjpegViewer extends StatefulWidget {
  final String url;
  final BoxFit fit;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const MjpegViewer({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  State<MjpegViewer> createState() => _MjpegViewerState();
}

class _MjpegViewerState extends State<MjpegViewer> {
  Uint8List? _frame;
  StreamSubscription? _sub;
  http.Client? _client;
  Timer? _reconnectTimer;
  Timer? _staleWatchdog;
  bool _isStarting = false;
  bool _isDisposed = false;
  DateTime _lastFrameAt = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _lastChunkAt = DateTime.fromMillisecondsSinceEpoch(0);

  static const Duration _minFrameInterval = Duration(milliseconds: 66);
  static const int _maxBufferBytes = 2 * 1024 * 1024;
  static const Duration _staleThreshold = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _staleWatchdog = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isDisposed || _isStarting) return;
      if (_lastChunkAt.millisecondsSinceEpoch == 0) return;

      if (DateTime.now().difference(_lastChunkAt) > _staleThreshold) {
        _start();
      }
    });
    _start();
  }

  Future<void> _start() async {
    if (_isDisposed || _isStarting) return;
    _isStarting = true;

    try {
      await _sub?.cancel();
      _client?.close();

      _client = http.Client();
      final req = http.Request('GET', Uri.parse(widget.url));
        req.headers['Cache-Control'] = 'no-cache';
        req.headers['Pragma'] = 'no-cache';
        final res = await _client!
          .send(req)
          .timeout(const Duration(seconds: 8));
        _lastChunkAt = DateTime.now();

      List<int> buffer = [];

      _sub = res.stream.listen(
        (chunk) {
          _lastChunkAt = DateTime.now();
          buffer.addAll(chunk);

          if (buffer.length > _maxBufferBytes) {
            // Guard against unbounded growth when stream is malformed.
            buffer = buffer.sublist(buffer.length - (_maxBufferBytes ~/ 2));
          }

          Uint8List? newestFrame;

          while (true) {
            final start = _findMarker(buffer, [0xFF, 0xD8]);
            if (start == -1) {
              break;
            }

            final end = _findMarker(buffer, [0xFF, 0xD9], start + 2);

            if (start != -1 && end != -1 && end > start) {
              final frame = Uint8List.fromList(buffer.sublist(start, end + 2));
              buffer = buffer.sublist(end + 2);
              newestFrame = frame;
            } else {
              break;
            }
          }

          if (newestFrame == null || !mounted) {
            return;
          }

          final now = DateTime.now();
          if (now.difference(_lastFrameAt) < _minFrameInterval) {
            return;
          }

          _lastFrameAt = now;
          setState(() {
            _frame = newestFrame;
          });
        },
        onError: (e) {
          debugPrint('MJPEG error: $e');
          _scheduleReconnect();
        },
        onDone: _scheduleReconnect,
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint('MJPEG start failed: $e');
      _scheduleReconnect();
    } finally {
      _isStarting = false;
    }
  }

  void _scheduleReconnect() {
    if (_isDisposed) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 1), _start);
  }

  int _findMarker(List<int> data, List<int> marker, [int from = 0]) {
    for (int i = from; i <= data.length - marker.length; i++) {
      bool match = true;
      for (int j = 0; j < marker.length; j++) {
        if (data[i + j] != marker[j]) {
          match = false;
          break;
        }
      }
      if (match) return i;
    }
    return -1;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _reconnectTimer?.cancel();
    _staleWatchdog?.cancel();
    _sub?.cancel();
    _client?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_frame == null) {
      return widget.loadingWidget ??
          const Center(child: CircularProgressIndicator());
    }

    return Image.memory(
      _frame!,
      fit: widget.fit,
      gaplessPlayback: true,
      filterQuality: FilterQuality.low,
      isAntiAlias: false,
    );
  }
}