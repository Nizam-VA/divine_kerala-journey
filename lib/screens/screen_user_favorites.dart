import 'dart:io';

import 'package:devine_kerala_journey/database/favorites_database.dart';
import 'package:devine_kerala_journey/model/favorites.dart';
import 'package:devine_kerala_journey/screens/screen_login.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenUserFavorites extends StatefulWidget {
  ScreenUserFavorites({super.key});

  @override
  State<ScreenUserFavorites> createState() => _ScreenUserFavoritesState();
}

class _ScreenUserFavoritesState extends State<ScreenUserFavorites> {
  final AuthServices _auth = AuthServices();
  final DatabasePilgrim pilgrim = DatabasePilgrim();

  // List<String> _topPligrimes = [
  DatabaseFavorites databaseFavorites = DatabaseFavorites();

  Set<Favorites> favorites = {};
  List<String> images = [];

  @override
  void initState() {
    _getFavorites();
    super.initState();
  }

  Future<void> _getFavorites() async {
    final favoritesList = await databaseFavorites.getFavorites();
    setState(() {
      favorites = favoritesList.toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final _pref = await SharedPreferences.getInstance();
              await _pref.clear();
              await _auth.signOutOfGoogle(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => ScreenLogin()),
                  (route) => false);
            },
            icon: const Icon(Icons.power_settings_new),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: List.generate(favorites.length, (index) {
                return InkWell(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (ctx) => ScreenPilgrimesDetails(),
                    //   ),
                    // );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    height: MediaQuery.of(context).size.height / 4,
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
                        image:
                            FileImage(File(favorites.elementAt(index).image)),
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
                            favorites.elementAt(index).place,
                            style: TextStyle(
                              color: AppColors.notFavorite,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await databaseFavorites
                                .deleteFavorite(favorites.elementAt(index).id)
                                .then((value) => _getFavorites());
                          },
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
        );
      }),
    );
  }
}
