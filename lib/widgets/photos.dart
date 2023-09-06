import 'dart:io';

import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:flutter/material.dart';

class Photos extends StatelessWidget {
  PilgrimagesData pilgrim;
  Photos({super.key, required this.pilgrim});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: pilgrim.imageURL.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: .5,
                ),
                image: DecorationImage(
                    image: FileImage(File(pilgrim.imageURL[index])),
                    fit: BoxFit.cover)),
          );
        },
      ),
    );
  }
}
