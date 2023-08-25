import 'package:devine_kerala_journey/screens/screen_login.dart';
import 'package:devine_kerala_journey/screens/screen_user_image_gallery.dart';
import 'package:flutter/material.dart';

var pilgrime;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.purple,
        fontFamily: 'Urbanist',
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: ScreenLogin(),
      routes: {'first': (context) => ScreenUserImageGallery()},
    );
  }
}
