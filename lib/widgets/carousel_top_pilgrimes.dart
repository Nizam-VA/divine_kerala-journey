import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:devine_kerala_journey/screens/all_pilgrims/screen_user_view_all_pilgrims.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pilgrimages_data.dart';
import '../screens/screen_pilgrimes_details.dart';

class CarouselTopPilgrimes extends StatefulWidget {
  CarouselTopPilgrimes({super.key});

  @override
  State<CarouselTopPilgrimes> createState() => _CarouselTopPilgrimesState();
}

class _CarouselTopPilgrimesState extends State<CarouselTopPilgrimes> {
  int _currentIndex = 0;
  List<String> images = [];

  @override
  Widget build(BuildContext context) {
    final pilgrims = Provider.of<List<PilgrimagesData>>(context);
    images = [
      pilgrims[0].imageURL[0],
      pilgrims[1].imageURL[0],
    ];

    final imageSliders = images
        .map((item) => Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.grey[300],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                        image: DecorationImage(
                            image: FileImage(File(item)), fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 12),
                      child: Text(
                        pilgrims[_currentIndex].place,
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
            builder: (ctx) => ScreenPilgrimesDetails(
              pilgrim: pilgrims[_currentIndex],
            ),
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(
                width: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const ScreenUserViewAllPilgrims(),
                    ),
                  );
                },
                child: Text(
                  'View all',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
