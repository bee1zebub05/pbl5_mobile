import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:pbl5_mobile/src/module/vision_feed/model/mjpeg_viewer.dart';

class VlcStreamViewer extends StatefulWidget {
  final String url;
  final Widget? loadingWidget;

  const VlcStreamViewer({
    super.key,
    required this.url,
    this.loadingWidget,
  });

  @override
  State<VlcStreamViewer> createState() => _VlcStreamViewerState();
}

class _VlcStreamViewerState extends State<VlcStreamViewer> {
  late VlcPlayerController _controller;
  Timer? _fallbackTimer;
  bool _isInitialized = false;
  bool _useMjpegFallback = false;

  @override
  void initState() {
    super.initState();
    _createController();
    _startFallbackTimer();
  }

  void _createController() {
    _controller = VlcPlayerController.network(
      widget.url,
      autoPlay: true,
      autoInitialize: true,
      hwAcc: HwAcc.full,
    );
    _controller.addListener(_onControllerChanged);
  }

  void _startFallbackTimer() {
    _fallbackTimer?.cancel();
    _fallbackTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted || _isInitialized || _useMjpegFallback) return;
      setState(() {
        _useMjpegFallback = true;
      });
    });
  }

  void _onControllerChanged() {
    if (!mounted) return;

    if (_controller.value.isInitialized && !_isInitialized) {
      _isInitialized = true;
      _fallbackTimer?.cancel();
    }

    if (_controller.value.hasError) {
      setState(() {
        _useMjpegFallback = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant VlcStreamViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url == widget.url) return;

    final old = _controller;
    old.removeListener(_onControllerChanged);

    _useMjpegFallback = false;
    _isInitialized = false;
    _createController();
    _startFallbackTimer();
    old.dispose();
    setState(() {});
  }

  @override
  void dispose() {
    _fallbackTimer?.cancel();
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_useMjpegFallback) {
      return MjpegViewer(url: widget.url);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final ratio = (width > 0 && height > 0) ? (width / height) : 1.0;

        return VlcPlayer(
          controller: _controller,
          aspectRatio: ratio,
          placeholder: widget.loadingWidget ??
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
