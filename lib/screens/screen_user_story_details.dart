import 'dart:io';

import 'package:devine_kerala_journey/database/stories_database_helper.dart';
import 'package:devine_kerala_journey/screens/screen_user.dart';
import 'package:devine_kerala_journey/screens/screen_user_update_story.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

import '../model/user_story.dart';

class ScreenUserStoryDetails extends StatefulWidget {
  UserDatabaseHelper databaseHelper = UserDatabaseHelper();
  UserStory userStory;
  ScreenUserStoryDetails({super.key, required this.userStory});

  @override
  State<ScreenUserStoryDetails> createState() => _ScreenUserStoryDetailsState();
}

class _ScreenUserStoryDetailsState extends State<ScreenUserStoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Image.asset(
          'assets/icons/divine-kerala-journey-logo.webp',
          height: 24,
          color: Colors.white,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'edit') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        ScreenUserUpdateStory(userStory: widget.userStory),
                  ),
                );
              }
              if (value == 'delete') {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Story'),
                    content: const Text(
                        'Are you sure you want to delete this story?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                      ),
                      TextButton(
                        child: const Text('Delete'),
                        onPressed: () async {
                          await widget.databaseHelper
                              .deleteStory(widget.userStory.id)
                              .then((id) {
                            if (id > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Story deleted successfully')),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Failed to delete story')),
                              );
                            }
                          });
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (ctx) => ScreenUser()),
                              (route) => false);
                        },
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Edit'),
                value: 'edit',
              ),
              PopupMenuItem(
                child: Text('Delete'),
                value: 'delete',
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[300],
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      image: FileImage(
                        File(widget.userStory.images),
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: Text(
                        widget.userStory.place,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: Text(
                        widget.userStory.description,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteStory(BuildContext ctx, int id) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Story'),
        content: const Text('Are you sure you want to delete this story?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(ctx);
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              widget.databaseHelper.deleteStory(id);
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }
}
