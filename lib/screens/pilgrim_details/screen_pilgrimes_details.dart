import 'package:devine_kerala_journey/database/favorites_database.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/screens/pilgrim_details/widgets/comments_form.dart';
import 'package:devine_kerala_journey/screens/pilgrim_details/widgets/favorite_icon.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/tabbar_pilgrimage_details.dart';
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
        title: Image.asset('assets/icons/divine-kerala-journey-logo.webp',
            height: 24, color: Colors.white),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
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
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.pilgrim.imageURL[0]),
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
