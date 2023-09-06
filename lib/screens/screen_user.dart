import 'package:devine_kerala_journey/screens/screen_user_create_story.dart';
import 'package:devine_kerala_journey/screens/screen_user_favorites.dart';
import 'package:devine_kerala_journey/screens/screen_user_home.dart';
import 'package:devine_kerala_journey/screens/screen_user_image_gallery.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ScreenUser extends StatefulWidget {
  const ScreenUser({super.key});

  @override
  State<ScreenUser> createState() => _ScreenUserState();
}

class _ScreenUserState extends State<ScreenUser> {
  int _currentSelectedIndex = 0;
  final _screens = [
    ScreenUserHome(),
    ScreenUserCreateStory(),
    ScreenUserImageGallery(),
    ScreenUserFavorites(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            _currentSelectedIndex = newIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), label: 'Create Story'),
          BottomNavigationBarItem(
              icon: Icon(Icons.image_outlined), label: 'Photo Gallery'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        backgroundColor: AppColors.primary,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
