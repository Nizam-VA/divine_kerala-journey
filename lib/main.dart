import 'package:devine_kerala_journey/screens/screen_login.dart';
import 'package:devine_kerala_journey/screens/screen_user_image_gallery.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

var pilgrime;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: ScreenLogin(),
      routes: {'first': (context) => ScreenUserImageGallery()},
    );
  }
}
