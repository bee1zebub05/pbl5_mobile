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

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    try {
      _client = http.Client();
      final req = http.Request('GET', Uri.parse(widget.url));
      final res = await _client!.send(req);

      List<int> buffer = [];

      _sub = res.stream.listen(
        (chunk) {
          buffer.addAll(chunk);

          while (true) {
            final start = _findMarker(buffer, [0xFF, 0xD8]);
            final end = _findMarker(buffer, [0xFF, 0xD9]);

            if (start != -1 && end != -1 && end > start) {
              final frame = buffer.sublist(start, end + 2);
              buffer = buffer.sublist(end + 2);

              if (!mounted) return;

              setState(() {
                _frame = Uint8List.fromList(frame);
              });
            } else {
              break;
            }
          }
        },
        onError: (e) {
          debugPrint('MJPEG error: $e');
        },
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint('MJPEG start failed: $e');
    }
  }

  int _findMarker(List<int> data, List<int> marker) {
    for (int i = 0; i < data.length - marker.length; i++) {
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
    );
  }
}