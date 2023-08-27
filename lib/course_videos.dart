import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosCoursesView extends StatefulWidget {
  const VideosCoursesView({super.key});
  _VideosCoursesViewState createState() => _VideosCoursesViewState();
}

class _VideosCoursesViewState extends State<VideosCoursesView> {
  YoutubePlayerController _ytcontrol =
      YoutubePlayerController(initialVideoId: 'hP25aVmxkP8');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff102C57),
        iconTheme: IconThemeData(color: Colors.white, size: 35.0),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _ytcontrol,
        ),
      ),
    );
  }
}
