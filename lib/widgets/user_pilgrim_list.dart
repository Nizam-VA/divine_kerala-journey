import 'dart:io';

import 'package:devine_kerala_journey/model/favorites.dart';
import 'package:devine_kerala_journey/screens/screen_pilgrimes_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pilgrimages_data.dart';
import '../styles/app_colors.dart';

class UserPilgrimList extends StatefulWidget {
  const UserPilgrimList({super.key});

  @override
  State<UserPilgrimList> createState() => _UserPilgrimListState();
}

class _UserPilgrimListState extends State<UserPilgrimList> {
  List<Favorites> favorites = [];
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    var favorite;
    final pilgrims = Provider.of<List<PilgrimagesData>>(context);
    return ListView.builder(
      itemCount: pilgrims.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ScreenPilgrimesDetails(
                        pilgrim: pilgrims[index],
                      )));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(File(pilgrims[index].imageURL[0])),
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
                      pilgrims[index].place,
                      style: const TextStyle(color: AppColors.notFavorite),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  insertFavorite(Favorites favorite) {
    if (clicked) {
      favorites.add(favorite);
    } else {
      favorites.remove(favorite);
    }
  }
}
