import 'package:devine_kerala_journey/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get firebaseAuth {
    return _auth;
  }

  //signing with google account

  Future signInWithGoogle(BuildContext context) async {
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
              await _auth.signInWithCredential(credential);
          User? user = userCredential.user;
          return _userFromFirebaseUser(user);
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
          return null;
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
    return null;
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('$e ');
      return null;
    }
  }

  //register with email and password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('$e');
      return null;
    }
  }

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //signing in using email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('$e error done here');
    }
  }

  Future signOutOfGoogle(BuildContext context) async {
    try {
      googleSignIn.signOut();
      _auth.signOut();
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
