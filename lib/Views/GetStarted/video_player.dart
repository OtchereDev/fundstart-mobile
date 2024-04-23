import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://videos.pexels.com/video-files/6799742/6799742-sd_540_960_30fps.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
           _controller.play();
           _controller.setLooping(true);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : Container(),
        ),
       
      );
    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}