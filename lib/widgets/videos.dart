import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videos extends StatefulWidget {
  PilgrimagesData pilgrim;
  Videos({super.key, required this.pilgrim});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  final _urls = [
    'https://youtu.be/8wltPLL7DWA',
    'https://youtu.be/cNR5lrAwN5g',
    'https://youtu.be/871Q9Tf_BwI'
  ];
  late List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = _urls.map((url) {
      final videoId = YoutubePlayer.convertUrlToId(url);
      return YoutubePlayerController(
          initialVideoId: videoId!,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ));
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: List.generate(_urls.length, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 1.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: YoutubePlayer(
                thumbnail: const Text(''),
                controller: _controllers[index],
                showVideoProgressIndicator: true,
                progressColors: const ProgressBarColors(
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
