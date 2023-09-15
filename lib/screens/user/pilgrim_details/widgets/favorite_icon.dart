import 'package:devine_kerala_journey/database/favorites_database.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:flutter/material.dart';

class FavoriteIcon extends StatefulWidget {
  PilgrimagesData pilgrim;
  FavoriteIcon({super.key, required this.pilgrim});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: favoriteNotifier,
        builder: (context, favorite, _) {
          return IconButton(
              onPressed: favToggler,
              icon: Icon(
                Icons.favorite,
                color: favorite.contains(widget.pilgrim.id)
                    ? Colors.red
                    : Colors.white,
              ));
        });
  }

  favToggler() async {
    favoriteNotifier.value.contains(widget.pilgrim.id)
        ? await DatabaseFavorites().deleteFavorite(widget.pilgrim.id)
        : await DatabaseFavorites().insertFavorites(widget.pilgrim);
  }
}
