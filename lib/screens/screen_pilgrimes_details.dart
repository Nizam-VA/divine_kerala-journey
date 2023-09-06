import 'dart:io';

import 'package:devine_kerala_journey/database/favorites_database.dart';
import 'package:devine_kerala_journey/model/favorites.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/tabbar_pilgrimage_details.dart';
import 'package:flutter/material.dart';

class ScreenPilgrimesDetails extends StatelessWidget {
  DatabaseFavorites databaseFavorites = DatabaseFavorites();
  PilgrimagesData pilgrim;
  ScreenPilgrimesDetails({super.key, required this.pilgrim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Image.asset('assets/icons/divine-kerala-journey-logo.webp',
            height: 24, color: Colors.white),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              final favorite = Favorites(id: 0, pilgrim: pilgrim);
              databaseFavorites.insertFavorites(favorite);
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        child: const Icon(Icons.comment),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(pilgrim.imageURL[0])),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    top: (MediaQuery.of(context).size.height / 3) - 20,
                    right: 12,
                    left: 12,
                    child: Container(
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          border: Border.all(
                            color: AppColors.primary,
                            width: .3,
                          ),
                        ),
                        child: TabBarPilgrimageDetails(pilgrim: pilgrim)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
