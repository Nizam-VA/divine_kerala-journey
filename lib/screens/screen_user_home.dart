import 'package:devine_kerala_journey/database/stories_database_helper.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/model/user_story.dart';
import 'package:devine_kerala_journey/screens/screen_about.dart';
import 'package:devine_kerala_journey/screens/screen_login.dart';
import 'package:devine_kerala_journey/screens/screen_settings.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/carousel_explore_kerala.dart';
import 'package:devine_kerala_journey/widgets/carousel_top_pilgrimes.dart';
import 'package:devine_kerala_journey/widgets/carousel_user_stories.dart';
import 'package:devine_kerala_journey/widgets/drop_down.dart';
import 'package:devine_kerala_journey/widgets/dropdown_select_district.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<String> _topPligrimes = [
    'assets/images/mkc-overview.jpg',
    'assets/images/koodal-manikyam - Copy.jpg',
    'assets/images/malayattoor.jpg',
    'assets/images/beemapalli.jpg'
  ];

  @override
  void initState() {
    _refresshUserStories();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _refresshUserStories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _uname = _auth.firebaseAuth.currentUser?.displayName;
    final _uemail = _auth.firebaseAuth.currentUser?.email;
    return StreamProvider<List<PilgrimagesData>>.value(
      value: DatabasePilgrim().pilgrims,
      initialData: [],
      child: Scaffold(
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              CarouselTopPilgrimes(),
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
              CarouselExploreKerala(),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: DropDownSelectDistrict(),
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: DropDownFormField(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text(
                          'Search',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
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
      ),
    );
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
                builder: (ctx) => ScreenAbout(),
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
