import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/offerings/data/repository/offering_repository.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/likes_converter.dart';

class KeyMyVideosDetailScreen extends StatefulWidget {
  final String coachId;
  final MyVideos videos;
  const KeyMyVideosDetailScreen(
      {super.key, required this.videos, required this.coachId});

  @override
  State<KeyMyVideosDetailScreen> createState() =>
      _KeyMyVideosDetailScreenState();
}

class _KeyMyVideosDetailScreenState extends State<KeyMyVideosDetailScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  OfferingRepository offeringRepository = OfferingRepository();
  bool isLiked = false;
  int likeCount = 0;
  bool alreadyLiked = false;
  bool isLoading = true;
  bool showControls = true;
  Timer? _controlsTimer;
  bool _isPlaying = false;
  bool _isBuffering = false;

  @override
  void initState() {
    super.initState();
    _fetchProfileTemplateUrl();
    if (widget.videos.likes?.contains(myUser?.userInfo?.userId) ?? false) {
      alreadyLiked = true;
      isLiked = true;
    }
    likeCount = widget.videos.likes?.length ?? 0;
  }

  String? url;

  void _startHideControlsTimer() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _controller.value.isPlaying) {
        setState(() {
          showControls = false;
        });
      }
    });
  }

  Future<void> _fetchProfileTemplateUrl() async {
    try {
      // Call the getSignedUrl function from the LoginCubit

      // Initialize VideoPlayerController and ChewieController only when url is available
      log("here chec");
      print(widget.videos.file);
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.videos.file ?? ""))
            ..initialize().then((_) {
              setState(() {
                isLoading = false;
              }); // Ensure the widget is rebuilt after initialization
              _controller.play(); // Start playing automatically
            });

      if (Platform.isIOS) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: true,
          autoInitialize: true,
        );
      }
      // _controller.addListener(() {
      //   if (_controller.value.isPlaying) {
      //     setState(() {
      //       _isPlaying = true;
      //     });
      //   } else {
      //     setState(() {
      //       _isPlaying = false;
      //     });
      //   }
      // });
      _controller.addListener(() {
        final isPlaying = _controller.value.isPlaying;
        final isBuffering = _controller.value.isBuffering;

        if (_isPlaying != isPlaying || _isBuffering != isBuffering) {
          setState(() {
            _isPlaying = isPlaying;
            _isBuffering = isBuffering;
          });

          if (isPlaying) {
            _startHideControlsTimer();
          }
        }
      });
    } catch (e) {
      showSnackBar(e.toString());
      print("Error fetching signed URL: $e");
    }
  }

  void likeVideo() async {
    if (alreadyLiked != isLiked) {
      try {
        await offeringRepository.likeVideo(
            widget.coachId, widget.videos.sId ?? "");
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  void dispose() {
    likeVideo();
    _controller.dispose();

    if (Platform.isIOS) {
      _chewieController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "Video", secondText: "Details"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height(20),
              ClipRRect(
                //  borderRadius: BorderRadius.circular(15),
                child: buildVideoPlayer(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 28.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLiked = !isLiked;
                              if (isLiked) {
                                likeCount++; // Increment like count
                              } else {
                                likeCount--; // Decrement like count
                              } // Toggle like status
                            });
                          },
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                        ),
                        width(8),
                        Flexible(
                          child: simpleText(
                            formatLikesCount(likeCount),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    height(16),
                    simpleText(
                      widget.videos.title ?? "",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    height(16),
                    simpleText(
                      "Description",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    height(8),
                    simpleText(
                      widget.videos.description ?? "",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVideoPlayer() {
    double appBarHeight = AppBar().preferredSize.height;
    double bottomNavigationBarHeight = kBottomNavigationBarHeight;
    double rotationCorrection =
        double.parse(_controller.value.rotationCorrection.toString());

    Widget videoPlayer = AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );

    // Apply rotation if the rotationCorrection value is not 0
    if (rotationCorrection != 0) {
      videoPlayer = Transform.rotate(
        angle: rotationCorrection * (3.14 / 180),
        child: videoPlayer,
      );
    }

    // Use different video players based on the platform
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      // Use Chewie for iOS
      return AspectRatio(
        aspectRatio: (MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height -
                appBarHeight -
                bottomNavigationBarHeight -
                20.h)),
        child: Stack(
          children: [
            Chewie(
              controller: _chewieController,
            ),
            if (_isBuffering)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
      );
    } else {
      // Use VideoPlayer for Android
      return OrientationBuilder(builder: (context, orientation) {
        return Center(
          child: AspectRatio(
            aspectRatio: orientation == Orientation.portrait
                ? _controller.value.aspectRatio
                : 16 / 9, // Adjust this ratio as needed

            child: _controller.value.isInitialized == false
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.textDark)),
                      width: 30,
                      height: 30,
                      child: const Center(
                          child: CircularProgressIndicator.adaptive()),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        showControls = !showControls; // toggle visibility
                      });
                      if (_controller.value.isPlaying && showControls) {
                        _startHideControlsTimer();
                      }
                    },
                    child: Stack(
                      children: [
                        videoPlayer,
                        if (_isBuffering)
                          Container(
                            color: Colors.black.withOpacity(0.3),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (showControls)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black
                                    .withOpacity(0.5), // Light black background
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (_isPlaying) {
                                            _controller.pause();
                                          } else {
                                            _controller.play();
                                          }
                                        },
                                        icon: Icon(
                                          _isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                      ),
                                      width(4),
                                      Text(
                                        '${formatDuration(_controller.value.position)} / ${formatDuration(_controller.value.duration)}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _openFullScreen();
                                    },
                                    icon: const Icon(
                                      Icons.fullscreen,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (showControls)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 6),
                              child: SizedBox(
                                width: deviceWidth - 20,
                                child: Center(
                                  child: GestureDetector(
                                    onTapUp: (details) async {
                                      // Remember the playing status
                                      bool wasPlaying =
                                          _controller.value.isPlaying;

                                      // Calculate the seek position based on the tap position
                                      double tapPositionInBar =
                                          details.globalPosition.dx - 28.w;
                                      double seekPercentage = tapPositionInBar /
                                          (MediaQuery.of(context).size.width -
                                              200);
                                      Duration seekTo =
                                          _controller.value.duration *
                                              seekPercentage;

                                      // Seek to the desired position
                                      await _controller.seekTo(seekTo);

                                      // Resume playback if it was playing before seeking
                                      if (wasPlaying) {
                                        _controller.play();
                                      }
                                    },
                                    child: Center(
                                      child: VideoProgressIndicator(
                                        _controller,
                                        allowScrubbing: true,
                                        colors: const VideoProgressColors(
                                          playedColor: Colors.red,
                                          bufferedColor: Colors.grey,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
          ),
        );
      });
    }
  }

  void _openFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPlayer(
            controller: _controller,
            rotation:
                double.parse(_controller.value.rotationCorrection.toString())),
      ),
    ).then((value) {
      // Delay resetting the orientation settings
      Future.delayed(Duration(milliseconds: 500), () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      });
    });
  }

  void _toggleFullScreen() {
    if (_controller.value.isPlaying) {
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    }
  }
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '$twoDigitMinutes:$twoDigitSeconds';
}

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
        _hideSystemOverlays();
      }
    });

    // Hide controls and system overlays initially
    _hideControlsAndSystemOverlaysAfterDelay();
  }

  void _hideControlsAndSystemOverlaysAfterDelay() {
    _controlsTimer.cancel();
    _controlsTimer = Timer(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _controlsVisible = false;
        });
        _hideSystemOverlays();
      }
    });
  }

  void _toggleControlsVisibility() {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });

    _hideControlsAndSystemOverlaysAfterDelay();
  }

  @override
  void dispose() {
    _controlsTimer.cancel();
    _controlsTimer.cancel();
    super.dispose();
  }

  void _toggleSystemOverlaysVisibility() {
    if (_controlsVisible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
          overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
          overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    }
  }

  void _hideSystemOverlays() {
    if (!_controlsVisible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
          overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleControlsVisibility();
        _toggleSystemOverlaysVisibility();
      },
      child: Scaffold(
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: Stack(
            children: [
              Center(
                child: Transform.rotate(
                  angle: widget.rotation * (3.14 / 180),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: widget.controller.value.size.width,
                      height: widget.controller.value.size.height,
                      child: VideoPlayer(widget.controller),
                    ),
                  ),
                ),
              ),
              if (_controlsVisible) _buildControls(),
            ],
          ),
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
