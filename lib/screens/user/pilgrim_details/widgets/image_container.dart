import 'package:flutter/material.dart';

import '../screen_pilgrimes_details.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.widget,
  });

  final ScreenPilgrimesDetails widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.pilgrim.imageURL[0]),
              fit: BoxFit.cover)),
    );
  }
}
