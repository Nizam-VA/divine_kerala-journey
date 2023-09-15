import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final NetworkImage image;
  ImageDialog({required this.image});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
            image: DecorationImage(image: image, fit: BoxFit.cover)),
      ),
    );
  }
}
