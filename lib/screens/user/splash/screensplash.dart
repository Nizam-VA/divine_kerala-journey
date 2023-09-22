import 'package:devine_kerala_journey/screens/user/login/screen_login.dart';
import 'package:devine_kerala_journey/screens/user/main/screen_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/constants.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Image.asset(
          'assets/icons/divine-kerala-journey-logo.webp',
          height: 80,
        ),
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScreenLogin(),
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final _pref = await SharedPreferences.getInstance();
    final _userLoggedIn = _pref.getBool(SAVE_KEY_NAME);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      gotoLogin();
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => ScreenUser(),
        ),
      );
    }
  }
}
