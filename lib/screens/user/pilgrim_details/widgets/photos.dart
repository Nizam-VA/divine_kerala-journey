import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/widgets/image_dialogue.dart';
import 'package:flutter/material.dart';

class Photos extends StatelessWidget {
  PilgrimagesData pilgrim;
  Photos({super.key, required this.pilgrim});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pilgrim.imageURL.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            Future.delayed(const Duration(seconds: 1));
            await await showDialog(
              context: context,
              builder: (_) => ImageDialog(
                image: NetworkImage(pilgrim.imageURL[index]),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: .5,
                ),
                image: DecorationImage(
                    image: NetworkImage(pilgrim.imageURL[index]),
                    fit: BoxFit.cover)),
          ),
        );
      },
    );
  }
}
