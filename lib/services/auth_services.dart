import 'package:devine_kerala_journey/screens/screen_user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication authentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken,
        );
        try {
          UserCredential userCredential =
              await firebaseAuth.signInWithCredential(credential);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => ScreenUserHome(),
            ),
          );
        } catch (e) {
          final snackBar = SnackBar(
            content: Text(
              '$e',
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.red[900],
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(
          content: Text(
            'error',
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.red[900],
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(
          '$e',
          style: TextStyle(
            color: Colors.white,
            backgroundColor: Colors.red[900],
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> signOutOfGoogle(BuildContext context) async {
    try {
      googleSignIn.signOut();
      firebaseAuth.signOut();
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(
          '$e',
          style: TextStyle(
            color: Colors.white,
            backgroundColor: Colors.red[900],
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
