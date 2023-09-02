import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUser {
  insertUser(String uid, String name, String email) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> users = {
      'id': uid,
      'name': name,
      'email': email,
    };
    documentReference.set(users).whenComplete(() {
      print("$name created");
    });
  }

  List<String>? getUser(String uid) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(uid);
    documentReference.get().then((value) {
      return [value['name'], value['email']];
    });
  }
}
