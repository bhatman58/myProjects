import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' as io;
import 'package:chewie/chewie.dart';

class videoPlay extends StatefulWidget {
  String vidPath;
  videoPlay({this.vidPath});
  @override
  _videoPlayState createState() => _videoPlayState();
}

class _videoPlayState extends State<videoPlay> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = VideoPlayerController.file(io.File(widget.vidPath))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          // // _controller.play();
          // print("DURATION IS : \n");
          // print(_controller.value.duration.inSeconds);
        });
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: _controller.value.aspectRatio,
        allowedScreenSleep: false,
        fullScreenByDefault: true,
        showControls: true,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: wi,
            height: he,
            child: Stack(
              children: <Widget>[
                Chewie(
                  controller: _chewieController,
                )
              ],
            )),
      ),
    );
  }
}
