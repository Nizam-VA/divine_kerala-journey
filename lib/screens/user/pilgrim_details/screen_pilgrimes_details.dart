import 'package:devine_kerala_journey/database/favorites_database.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/screens/user/pilgrim_details/widgets/comments_form.dart';
import 'package:devine_kerala_journey/screens/user/pilgrim_details/widgets/favorite_icon.dart';
import 'package:devine_kerala_journey/screens/user/pilgrim_details/widgets/image_container.dart';
import 'package:devine_kerala_journey/screens/user/pilgrim_details/widgets/tabbar_container.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ScreenPilgrimesDetails extends StatefulWidget {
  PilgrimagesData pilgrim;

  ScreenPilgrimesDetails({super.key, required this.pilgrim});

  @override
  State<ScreenPilgrimesDetails> createState() => _ScreenPilgrimesDetailsState();
}

class _ScreenPilgrimesDetailsState extends State<ScreenPilgrimesDetails> {
  DatabaseFavorites databaseFavorites = DatabaseFavorites();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.pilgrim.place,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          FavoriteIcon(pilgrim: widget.pilgrim),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.comment),
          onPressed: () {
            _showCommentsPanel();
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  ImageContainer(widget: widget),
                  TabbarContainer(widget: widget),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCommentsPanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: CommentsForm(pilgrimId: widget.pilgrim.id),
            ),
          );
        });
  }
}
