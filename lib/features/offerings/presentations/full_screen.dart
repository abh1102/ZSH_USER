import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:zanadu/core/constants.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final double rotation;
  final VideoPlayerController controller;

  const FullScreenVideoPlayer({
    Key? key,
    required this.controller,
    required this.rotation,
  }) : super(key: key);

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late bool _controlsVisible;
  late Timer _controlsTimer;

  @override
  void initState() {
    super.initState();
    _controlsVisible = true;
    _controlsTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _controlsVisible = false;
        });
      }
    });

    // Hide controls initially
    _hideControlsAfterDelay();
  }

  void _hideControlsAfterDelay() {
    _controlsTimer.cancel();
    _controlsTimer = Timer(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _controlsVisible = false;
        });
      }
    });
  }

  void _toggleControlsVisibility() {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });

    _hideControlsAfterDelay();
  }

  @override
  void dispose() {
    _controlsTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return GestureDetector(
      onTap: _toggleControlsVisibility,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Transform.rotate(
                angle: widget.rotation * (3.14 / 180),
                child: AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: VideoPlayer(widget.controller),
                ),
              ),
            ),
            if (_controlsVisible) _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.black.withOpacity(0.7),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.pause();
                      } else {
                        widget.controller.play();
                      }
                      _toggleControlsVisibility();
                    },
                    icon: Icon(
                      widget.controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  width(9),
                  ValueListenableBuilder(
                    valueListenable: widget.controller,
                    builder: (context, VideoPlayerValue value, child) {
                      return Text(
                        '${_formatDuration(value.position)} / ${_formatDuration(value.duration)}',
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  width(9),
                  IconButton(
                    onPressed: () {
                      SystemChrome.setEnabledSystemUIMode(
                          SystemUiMode.edgeToEdge);
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.fullscreen_exit,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              GestureDetector(
                onTapDown: (details) {
                  _seekToTapPosition(details);
                },
                onTapUp: (_) {
                  // Resume playback after seeking to the desired position
                  widget.controller.play();
                },
                child: SizedBox(
                  height: 12,
                  child: VideoProgressIndicator(
                    widget.controller,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Colors.red,
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _seekToTapPosition(TapDownDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    final tapPercentage = localPosition.dx / box.size.width;
    final seekToPosition =
        tapPercentage * widget.controller.value.duration.inMilliseconds;

    // Pause playback while seeking
    widget.controller.pause();

    widget.controller.seekTo(Duration(milliseconds: seekToPosition.toInt()));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
