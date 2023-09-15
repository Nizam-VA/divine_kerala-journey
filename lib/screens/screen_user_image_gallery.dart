import 'package:devine_kerala_journey/shared/constants.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/image_dialogue.dart';
import 'package:flutter/material.dart';

class ScreenUserImageGallery extends StatelessWidget {
  const ScreenUserImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Image Gallery',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ValueListenableBuilder(
            valueListenable: allImages,
            builder: (context, images, _) {
              return GridView.builder(
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      Future.delayed(const Duration(seconds: 1));
                      await showDialog(
                        context: context,
                        builder: (_) => ImageDialog(
                          image: NetworkImage(images[index]),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: .5,
                          ),
                          image: DecorationImage(
                              image: NetworkImage(images[index]),
                              fit: BoxFit.cover)),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
