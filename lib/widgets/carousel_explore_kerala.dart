import 'package:carousel_slider/carousel_slider.dart';
import 'package:devine_kerala_journey/screens/user/pilgrim_details/screen_pilgrimes_details.dart';
import 'package:flutter/material.dart';

import '../model/pilgrimages_data.dart';
import '../styles/app_colors.dart';

class CarouselExploreKerala extends StatefulWidget {
  List<PilgrimagesData> pilgrims;
  CarouselExploreKerala({super.key, required this.pilgrims});

  @override
  State<CarouselExploreKerala> createState() => _CarouselExploreKeralaState();
}

class _CarouselExploreKeralaState extends State<CarouselExploreKerala> {
  int _currentIndex = 0;
  List<String?> images = [];
  @override
  Widget build(BuildContext context) {
    images = widget.pilgrims.map((pilgrim) {
      if (pilgrim.category == 'Others') {
        return pilgrim.imageURL[0];
      }
    }).toList();
    List<int?> indices = widget.pilgrims.map((pilgrim) {
      if (pilgrim.category == 'Others') {
        return widget.pilgrims.indexOf(pilgrim);
      }
    }).toList();
    images = images.where((element) {
      return element != null;
    }).toList();
    indices = indices.where((element) {
      return element != null;
    }).toList();
    final imageSliders = images
        .map((item) => Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.network(
                        item!,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            // Image is fully loaded
                            return child;
                          } else {
                            // Display a loading indicator while the image is loading
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 12),
                      child: Text(
                        widget.pilgrims[_currentIndex].place,
                        style: const TextStyle(
                            color: AppColors.notFavorite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) =>
                ScreenPilgrimesDetails(pilgrim: widget.pilgrims[_currentIndex]),
          ),
        );
      },
      child: Column(
        children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                enlargeCenterPage: false,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = indices[index]!;
                  });
                }),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.map(
              (url) {
                int index = images.indexOf(url);
                return Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? AppColors.primary
                        : Colors.grey[600],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
