import 'package:devine_kerala_journey/database/stories_database_helper.dart';
import 'package:devine_kerala_journey/model/user_story.dart';
import 'package:devine_kerala_journey/screens/screen_about.dart';
import 'package:devine_kerala_journey/screens/screen_settings.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/carousel_explore_kerala.dart';
import 'package:devine_kerala_journey/widgets/carousel_top_pilgrimes.dart';
import 'package:devine_kerala_journey/widgets/carousel_user_stories.dart';
import 'package:devine_kerala_journey/widgets/drop_down.dart';
import 'package:devine_kerala_journey/widgets/dropdown_select_district.dart';
import 'package:flutter/material.dart';

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
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      drawer: openDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  'Top Pilgrimes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CarouselTopPilgrimes(imagesList: _topPligrimes),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
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
            SizedBox(
              height: 8,
            ),
            CarouselExploreKerala(imagesList: _topPligrimes),
            SizedBox(
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
                  Padding(
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
                      child: Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
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
            SizedBox(
              height: 8,
            ),
            CarouselUserStories(
              userStories: userStories,
            ),
            SizedBox(
              height: 12,
            )
          ],
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
              // backgroundImage: NetworkImage(
              //     '${authServices.firebaseAuth.currentUser?.photoURL}'),
              ),
          accountName: Text(
            '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text(
            '',
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.video_camera_back_outlined,
            color: AppColors.primary,
          ),
          title: Text('Videos'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.photo,
            color: AppColors.primary,
          ),
          title: Text('Photos'),
          onTap: () {
            Navigator.pushNamed(context, 'first');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.info_outline_rounded,
            color: AppColors.primary,
          ),
          title: Text('About Us'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ScreenAbout(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: AppColors.primary,
          ),
          title: Text('Settings'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ScreenSettings(),
              ),
            );
          },
        ),
      ],
    ),
  );
}
