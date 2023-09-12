import 'package:carousel_slider/carousel_slider.dart';
import 'package:devine_kerala_journey/screens/pilgrim_details/screen_pilgrimes_details.dart';
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
  List<String> images = [];
  @override
  Widget build(BuildContext context) {
    images = [
      widget.pilgrims[0].imageURL[0],
      widget.pilgrims[1].imageURL[0],
    ];
    final imageSliders = images
        .map((item) => Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.grey[300],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: NetworkImage(item), fit: BoxFit.cover),
                  ),
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
                    _currentIndex = index;
                  });
                }),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.map(
              (url) {
                int index = images.indexOf(url);
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(horizontal: 2),
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
