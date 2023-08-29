import 'dart:io';

import 'package:devine_kerala_journey/database/stories_database_helper.dart';
import 'package:devine_kerala_journey/model/user_story.dart';
import 'package:devine_kerala_journey/screens/screen_user_story_details.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ScreenStoriesViewAll extends StatefulWidget {
  ScreenStoriesViewAll({super.key});

  @override
  State<ScreenStoriesViewAll> createState() => _ScreenStoriesViewAllState();
}

class _ScreenStoriesViewAllState extends State<ScreenStoriesViewAll> {
  UserDatabaseHelper databaseHelper = UserDatabaseHelper();

  List<UserStory> userStories = [];

  Future<void> _refresshUserStories() async {
    final userStoriesList = await databaseHelper.getStories();
    setState(() {
      userStories = userStoriesList;
    });
  }

  @override
  void initState() {
    _refresshUserStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/icons/divine-kerala-journey-logo.webp',
          color: Colors.white,
          height: 24,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: List.generate(userStories.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenUserStoryDetails(
                              userStory: userStories[index]),
                        ),
                      )
                      .then((value) => _refresshUserStories());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  height: h / 4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                    // boxShadow: [
                    //   BoxShadow(
                    //     blurRadius: 1,
                    //     spreadRadius: -1,
                    //   ),
                    // ],
                    color: Colors.black,
                    image: DecorationImage(
                      image: FileImage(File(userStories[index].images)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 14,
                          left: 12,
                        ),
                        child: Text(
                          userStories[index].place,
                          style: TextStyle(
                            color: AppColors.notFavorite,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: AppColors.favorite,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
