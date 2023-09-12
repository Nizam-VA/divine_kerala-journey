import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devine_kerala_journey/database/stories_database_helper.dart';
import 'package:devine_kerala_journey/model/user_story.dart';
import 'package:devine_kerala_journey/screens/screen_about.dart';
import 'package:devine_kerala_journey/screens/screen_login.dart';
import 'package:devine_kerala_journey/screens/screen_settings.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/shared/constants.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/carousel_explore_kerala.dart';
import 'package:devine_kerala_journey/widgets/carousel_top_pilgrimes.dart';
import 'package:devine_kerala_journey/widgets/carousel_user_stories.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/pilgrimages_data.dart';

final AuthServices _auth = AuthServices();

class ScreenUserHome extends StatefulWidget {
  ScreenUserHome({super.key});

  @override
  State<ScreenUserHome> createState() => _ScreenUserHomeState();
}

class _ScreenUserHomeState extends State<ScreenUserHome> {
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
    final _uname = _auth.firebaseAuth.currentUser?.displayName;
    final _uemail = _auth.firebaseAuth.currentUser?.email;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('pilgrims').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final pilgrims = snapshot.data!.docs
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
              .toList();
          allPilgrims.value = pilgrims;
          getAllImages();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              centerTitle: true,
              // leading: IconButton(
              //   onPressed: () {
              //     Scaffold.of(context).openDrawer();
              //   },
              //   tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              //   icon: Image.asset(
              //     'assets/icons/menu.png',
              //     height: 24,
              //   ),
              // ),
              title: Image.asset(
                'assets/icons/divine-kerala-journey-logo.webp',
                color: Colors.white,
                height: 24,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            drawer: openDrawer(context),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Top Pilgrims',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CarouselTopPilgrimes(pilgrims: pilgrims),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Text(
                        'Explore Kerala',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CarouselExploreKerala(pilgrims: pilgrims),
                  const SizedBox(
                    height: 12,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Text(
                        'Kerala Stories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CarouselUserStories(
                    userStories: userStories,
                  ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          );
        });
  }
}

Widget? openDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage:
                NetworkImage('${_auth.firebaseAuth.currentUser?.photoURL}'),
          ),
          accountName: Text(
            '${_auth.firebaseAuth.currentUser?.displayName}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          accountEmail: Text(
            '${_auth.firebaseAuth.currentUser?.email}',
          ),
          decoration: const BoxDecoration(color: AppColors.primary),
        ),
        ListTile(
          leading: const Icon(Icons.video_camera_back_outlined,
              color: AppColors.primary),
          title: const Text('Videos'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.photo, color: AppColors.primary),
          title: const Text('Photos'),
          onTap: () {
            Navigator.pushNamed(context, 'first');
          },
        ),
        ListTile(
          leading:
              const Icon(Icons.info_outline_rounded, color: AppColors.primary),
          title: const Text('About Us'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const ScreenAbout(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings, color: AppColors.primary),
          title: const Text('Settings'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ScreenSettings(),
              ),
            );
          },
        ),
        ListTile(
          leading:
              const Icon(Icons.power_settings_new, color: AppColors.primary),
          title: const Text('Logout'),
          onTap: () async {
            final _pref = await SharedPreferences.getInstance();
            await _pref.clear();
            await _auth.signOutOfGoogle(context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => ScreenLogin()),
                (route) => false);
          },
        ),
      ],
    ),
  );
}
