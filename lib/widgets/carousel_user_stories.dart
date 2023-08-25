import 'package:carousel_slider/carousel_slider.dart';
import 'package:devine_kerala_journey/screens/screen_user_story_details.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class CarouselUserStories extends StatefulWidget {
  List<String> imagesList;
  CarouselUserStories({super.key, required this.imagesList});

  @override
  State<CarouselUserStories> createState() => _CarouselUserStoriesState();
}

class _CarouselUserStoriesState extends State<CarouselUserStories> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final imageSliders = widget.imagesList
        .map((item) => Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.grey[300],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage(item), fit: BoxFit.cover),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.25,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3.25,
                              height: MediaQuery.of(context).size.height / 9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ))
        .toList();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ScreenUserStoryDetails(),
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
            children: widget.imagesList.map(
              (url) {
                int index = widget.imagesList.indexOf(url);
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