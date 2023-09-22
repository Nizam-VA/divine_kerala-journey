import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/constants.dart';
import '../../../styles/app_colors.dart';
import '../../../widgets/image_dialogue.dart';

class ScreenUserImageGallery extends StatefulWidget {
  const ScreenUserImageGallery({super.key});

  @override
  State<ScreenUserImageGallery> createState() => _ScreenUserImageGalleryState();
}

class _ScreenUserImageGalleryState extends State<ScreenUserImageGallery> {
  bool showShimmer = true;

  @override
  void initState() {
    super.initState();

    // Start a timer to stop shimmer after a certain duration (e.g., 3 seconds)
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showShimmer = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Image Gallery',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ValueListenableBuilder(
          valueListenable: allImages,
          builder: (context, images, _) {
            if (images.isEmpty) {
              return Center(
                child: const Text('No images available'),
              );
            } else {
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
                    child: showShimmer
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: .5,
                                ),
                                color: Colors
                                    .grey, // Use a fallback color while shimmering
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: .5,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(images[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
