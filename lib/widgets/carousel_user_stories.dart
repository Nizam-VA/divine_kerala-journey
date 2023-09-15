import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:devine_kerala_journey/database/stories_database_helper.dart';
import 'package:devine_kerala_journey/model/user_story.dart';
import 'package:devine_kerala_journey/screens/screen_storeis_view_all.dart';
import 'package:devine_kerala_journey/screens/screen_user_story_details.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class CarouselUserStories extends StatefulWidget {
  List<UserStory> userStories;

  CarouselUserStories({super.key, required this.userStories});

  @override
  State<CarouselUserStories> createState() => _CarouselUserStoriesState();
}

class _CarouselUserStoriesState extends State<CarouselUserStories> {
  final UserDatabaseHelper databaseHelper = UserDatabaseHelper();
  int _currentIndex = 0;
  List<UserStory> userStories = [];

  Future<void> _refreshUserStories() async {
    final userStoriesList = await databaseHelper.getStories();
    setState(() {
      userStories = userStoriesList;
    });
  }

  @override
  void initState() {
    _refreshUserStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageSliders = widget.userStories
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
                            image: FileImage(File(item.images)),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
    return InkWell(
      onTap: () async {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (ctx) => ScreenUserStoryDetails(
                  userStory: userStories[_currentIndex],
                ),
              ),
            )
            .then((value) => _refreshUserStories());
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.userStories.map(
                  (url) {
                    int index = widget.userStories.indexOf(url);
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
              const SizedBox(width: 30),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ScreenStoriesViewAll(),
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
