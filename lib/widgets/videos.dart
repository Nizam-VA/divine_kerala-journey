import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  final _url = [
    'https://youtu.be/8wltPLL7DWA',
    'https://youtu.be/cNR5lrAwN5g',
    'https://youtu.be/871Q9Tf_BwI'
  ];
  late YoutubePlayerController _controller;
  String? videoId;
  @override
  void initState() {
    videoId = YoutubePlayer.convertUrlToId(_url[0]);
    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      for (int i = 0; i < _url.length; i++) {
        videoId = YoutubePlayer.convertUrlToId(_url[i]);
      }
    });

    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: List.generate(3, (index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 1.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: YoutubePlayer(
                thumbnail: Text(
                  '',
                ),
                controller: _controller,
                showVideoProgressIndicator: true,
                progressColors: ProgressBarColors(
                  handleColor: Colors.indigo,
                  playedColor: Colors.indigo,
                  bufferedColor: Colors.grey,
                ),
                onReady: () => debugPrint(
                  'Ready',
                ),
              ),
            ),
          );
        }),
      ),
    ));
  }
}
