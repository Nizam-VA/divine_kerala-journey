import 'package:devine_kerala_journey/database/favorites_database.dart';
import 'package:devine_kerala_journey/screens/user/image_gallery/screen_user_image_gallery.dart';
import 'package:devine_kerala_journey/screens/user/splash/screensplash.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

var pilgrime;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DatabaseFavorites().isFavorite();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthServices authServices = AuthServices();
  User? currentUser;

  @override
  void initState() {
    currentUser = authServices.firebaseAuth.currentUser;
    super.initState();
  }

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
      home: ScreenSplash(),
      routes: {'first': (context) => ScreenUserImageGallery()},
    );
  }
}
