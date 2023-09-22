import 'package:devine_kerala_journey/screens/user/create_story/screen_user_create_story.dart';
import 'package:devine_kerala_journey/screens/user/favorites/screen_user_favorites.dart';
import 'package:devine_kerala_journey/screens/user/home/screen_user_home.dart';
import 'package:devine_kerala_journey/screens/user/image_gallery/screen_user_image_gallery.dart';
import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/material.dart';

int currentSelectedIndex = 0;

class ScreenUser extends StatefulWidget {
  const ScreenUser({super.key});

  @override
  State<ScreenUser> createState() => _ScreenUserState();
}

class _ScreenUserState extends State<ScreenUser> {
  final _screens = [
    ScreenUserHome(),
    ScreenUserCreateStory(),
    const ScreenUserImageGallery(),
    ScreenUserFavorites(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: FrostedBottomBar(
            hideOnScroll: true,
            bottomBarColor: Colors.grey,
            borderRadius: BorderRadius.circular(500),
            opacity: .75,
            sigmaX: 5,
            duration: const Duration(seconds: 3),
            sigmaY: 5,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.purple[900],
              selectedItemColor: Colors.yellow[500],
              unselectedItemColor: Colors.white,
              onTap: (value) {
                setState(() {
                  currentSelectedIndex = value;
                });
              },
              currentIndex: currentSelectedIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.create), label: 'Create Story'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.image_outlined), label: 'Photo Gallery'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
              ],
            ),
            body: (context, controller) => _screens[currentSelectedIndex]),
      ),
    );
  }
}
