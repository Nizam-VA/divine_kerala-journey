import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devine_kerala_journey/database/favorites_database.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/screens/user/pilgrim_details/screen_pilgrimes_details.dart';
import 'package:devine_kerala_journey/screens/user/pilgrim_details/widgets/favorite_icon.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Favorites', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('pilgrims')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final favoritePilgrims = snapshot.data!.docs
                      .map((doc) => PilgrimagesData(
                          id: doc['id'],
                          place: doc['place_name'],
                          location: doc['location'],
                          description: doc['description'],
                          district: doc['district'],
                          category: doc['category'],
                          popular: doc['popular'],
                          road: doc['road'],
                          rail: doc['rail'],
                          air: doc['air'],
                          latitude: doc['latitude'],
                          longitude: doc['longitude'],
                          imageURL: List.from(doc['images']),
                          linkURL: List.from(doc['links'])))
                      .where((pilgrim) =>
                          favoriteNotifier.value.contains(pilgrim.id))
                      .toList();
                  pilgrimNotifier.value = favoritePilgrims;
                  return ValueListenableBuilder(
                      valueListenable: pilgrimNotifier,
                      builder: (context, value, _) {
                        return pilgrimNotifier.value.isEmpty
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child:
                                    const Center(child: Text('No favorites')))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: pilgrimNotifier.value.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  ScreenPilgrimesDetails(
                                                      pilgrim: pilgrimNotifier
                                                          .value[index])));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              value[index].imageURL[0]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 14,
                                              left: 12,
                                            ),
                                            child: Text(
                                              value[index].place,
                                              style: const TextStyle(
                                                color: AppColors.notFavorite,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          FavoriteIcon(
                                            pilgrim: value[index],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                      });
                }),
          ),
        );
      }),
    );
  }

  refresh() {
    setState(() {});
  }
}
