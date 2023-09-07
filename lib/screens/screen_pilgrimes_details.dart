import 'dart:io';

import 'package:devine_kerala_journey/database/favorites_database.dart';
import 'package:devine_kerala_journey/model/favorites.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/shared/constants.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/tabbar_pilgrimage_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenPilgrimesDetails extends StatefulWidget {
  PilgrimagesData pilgrim;

  ScreenPilgrimesDetails({super.key, required this.pilgrim});

  @override
  State<ScreenPilgrimesDetails> createState() => _ScreenPilgrimesDetailsState();
}

class _ScreenPilgrimesDetailsState extends State<ScreenPilgrimesDetails> {
  DatabaseFavorites databaseFavorites = DatabaseFavorites();

  List<Favorites> favorites = [];

  bool isFavorite = false;
  int _currentId = 0;

  Future<void> _getFavorites() async {
    final favoritesList = await databaseFavorites.getFavorites();
    setState(() {
      favorites = favoritesList;
    });
  }

  @override
  void initState() {
    _getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Image.asset('assets/icons/divine-kerala-journey-logo.webp',
            height: 24, color: Colors.white),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isFavorite = !isFavorite;
              });
              final favorite = Favorites(
                  id: 0,
                  place: widget.pilgrim.place,
                  image: widget.pilgrim.imageURL[0]);
              if (isFavorite) {
                databaseFavorites.insertFavorites(favorite).then((id) {
                  _currentId = id;
                });
              } else {
                databaseFavorites.deleteFavorite(_currentId);
              }
            },
            icon: Icon(
              Icons.favorite,
              color: isFavorite ? Colors.red : Colors.white,
            ),
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
                            image: FileImage(File(widget.pilgrim.imageURL[0])),
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
                        child:
                            TabBarPilgrimageDetails(pilgrim: widget.pilgrim)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkPilgrimFavorite() async {
    final _pref = await SharedPreferences.getInstance();
    final _isFavorite = _pref.getBool(IS_FAVORITE);
    if (_isFavorite == null || _isFavorite == false) {
      setState(() {
        isFavorite = false;
      });
    } else {
      setState(() {
        isFavorite = true;
      });
    }
  }
}
