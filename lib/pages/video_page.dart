import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:video_player/video_player.dart';

import 'package:minimize_with_overlay/provider_models/app_state_model.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    Key? key,
    required this.videoUrl,
    required this.videoName,
  }) : super(key: key);
  final String videoUrl;
  final String videoName;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? _videoController;
  initVideoPlayer() async {
    _videoController = VideoPlayerController.network(widget.videoUrl,
        formatHint: VideoFormat.hls);
    await _videoController?.initialize().then((value) => setState(() {
          _videoController?.play();
        }));
  }

  @override
  void initState() {
    super.initState();
    initVideoPlayer();
  }

  @override
  void didUpdateWidget(covariant VideoPage oldWidget) {
    if (widget.videoUrl != oldWidget.videoUrl) {
      _videoController?.dispose();
      initVideoPlayer();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        duration: const Duration(milliseconds: 250),
        crossFadeState: context.watch<AppStateModel>().isVideoMinimized
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        firstChild: FullSizeVideoPage(
          videoPlayerController: _videoController,
          videoName: widget.videoName,
        ),
        secondChild: MinimizeVideoWidget(
          videoPlayerController: _videoController,
          videoName: widget.videoName,
        ));
  }
}

class MinimizeVideoWidget extends StatefulWidget {
  const MinimizeVideoWidget(
      {Key? key, this.videoPlayerController, required this.videoName})
      : super(key: key);
  final VideoPlayerController? videoPlayerController;
  final String videoName;

  @override
  State<MinimizeVideoWidget> createState() => _MinimizeVideoWidgetState();
}

class _MinimizeVideoWidgetState extends State<MinimizeVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AppStateModel>().setIsVideoMinimized(false);
      },
      child: Material(
        child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 30,
                  child: Container(
                    color: Colors.black54,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio:
                            widget.videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(widget.videoPlayerController!),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.videoName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                    flex: 30,
                    child: Row(children: [
                      CupertinoButton(
                          child: Icon(
                              widget.videoPlayerController!.value.isPlaying
                                  ? CupertinoIcons.pause
                                  : CupertinoIcons.play),
                          onPressed: () {
                            if (widget.videoPlayerController!.value.isPlaying) {
                              widget.videoPlayerController?.pause();
                            } else {
                              widget.videoPlayerController?.play();
                            }
                            setState(() {});
                          }),
                      CupertinoButton(
                          child: const Icon(CupertinoIcons.xmark),
                          onPressed: () {
                            context
                                .read<AppStateModel>()
                                .setIsVideoStarted(flag: false);
                          })
                    ]))
              ],
            )),
      ),
    );
  }
}

class FullSizeVideoPage extends StatelessWidget {
  const FullSizeVideoPage(
      {Key? key, this.videoPlayerController, required this.videoName})
      : super(key: key);
  final VideoPlayerController? videoPlayerController;
  final String videoName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Platform.isIOS
          ? CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                leading: CupertinoButton(
                    onPressed: () {
                      context.read<AppStateModel>().setIsVideoMinimized(true);
                    },
                    child: const Icon(CupertinoIcons.chevron_down)),
              ),
              child: getFullPageUI(context),
            )
          : Scaffold(
              appBar: AppBar(
                leading: ElevatedButton(
                    onPressed: () {
                      context.read<AppStateModel>().setIsVideoMinimized(true);
                    },
                    child: const Icon(CupertinoIcons.chevron_down)),
              ),
              body: getFullPageUI(context),
            ),
    );
  }

  SingleChildScrollView getFullPageUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(builder: (context) {
            if (videoPlayerController!.value.isInitialized) {
              return Container(
                // padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: videoPlayerController!.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(videoPlayerController!),
                      ControlsVideoPlayer(
                          videoPlayerController: videoPlayerController),
                      VideoProgressIndicator(videoPlayerController!,
                          allowScrubbing: true)
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                height: 300,
                color: Colors.black,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
          }),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              videoName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "Dummy description Dummy description Dummy description Dummy description Dummy description Dummy description Dummy description Dummy description Dummy description Dummy description Dummy description Dummy description Dummy description Dummy description"),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 12, 8, 0),
            child: Text("Other section 1"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 12, 8, 0),
            child: Text("Other section 2"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 12, 8, 0),
            child: Text("Other section 3"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom)
        ],
      ),
    );
  }
}

class ControlsVideoPlayer extends StatefulWidget {
  const ControlsVideoPlayer({
    Key? key,
    required this.videoPlayerController,
  }) : super(key: key);

  final VideoPlayerController? videoPlayerController;

  @override
  State<ControlsVideoPlayer> createState() => _ControlsVideoPlayerState();
}

class _ControlsVideoPlayerState extends State<ControlsVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: widget.videoPlayerController!.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            widget.videoPlayerController!.value.isPlaying
                ? widget.videoPlayerController?.pause()
                : widget.videoPlayerController?.play();
            setState(() {});
          },
        ),
      ],
    );
  }
}
