import 'package:devine_kerala_journey/shared/constants.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
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
        leading: Image.asset(
          'assets/icons/divine-kerala-journey-logo.webp',
          color: Colors.white,
        ),
        title: Text(
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: .5,
                        ),
                        image: DecorationImage(
                            image: NetworkImage(images[index]),
                            fit: BoxFit.cover)),
                  );
                },
              );
            }),
      ),
    );
  }
}
