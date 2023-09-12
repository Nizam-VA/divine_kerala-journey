import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/comments.dart';
import '../model/user.dart';

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

    Future<UserModel?> getUser(String uid) async {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel(
          uid: uid,
          name: data['name'] as String?,
          email: data['email'] as String?,
        );
        return user;
      } else {
        return null; // User not found
      }
    }
  }
}

class DatabasePilgrim {
  final String? id;
  DatabasePilgrim({this.id});

  final CollectionReference pilgrimCollection =
      FirebaseFirestore.instance.collection('pilgrims');

  //image storage on firestorage

  Future<List<String>> uploadImages(
      List<String> imageList, String placeName) async {
    List<String> imageString = [];
    for (var img in imageList) {
      File imageFile = File(img);
      String imageName = imageFile.path.split('/').last.toString();
      Reference toRoot = FirebaseStorage.instance.ref();
      Reference toDirectory = toRoot.child('Pilgrim Images');
      Reference toImage = toDirectory.child('$placeName/$imageName');
      try {
        await toImage.putFile(imageFile);
        final url = await toImage.getDownloadURL();
        imageString.add(url);
      } catch (e) {
        e;
      }
    }
    return imageString;
  }

  //insert data
  Future insertPilgrim(PilgrimagesData pilgrimagesData) async {
    Map<String, dynamic> pilgrims = {
      'id': pilgrimagesData.id,
      'place_name': pilgrimagesData.place,
      'location': pilgrimagesData.location,
      'description': pilgrimagesData.description,
      'district': pilgrimagesData.district,
      'category': pilgrimagesData.category,
      'popular': pilgrimagesData.popular,
      'rail': pilgrimagesData.rail,
      'road': pilgrimagesData.road,
      'air': pilgrimagesData.air,
      'latitude': pilgrimagesData.latitude,
      'longitude': pilgrimagesData.longitude,
      'images':
          await uploadImages(pilgrimagesData.imageURL, pilgrimagesData.place),
      'links': pilgrimagesData.linkURL,
    };
    return await pilgrimCollection.doc(id).set(pilgrims).whenComplete(() {
      print('$id is created');
    });
  }

  //delete data
  Future deletePilgrim(String id) async {
    return await pilgrimCollection.doc(id).delete().whenComplete(() {
      print('$id is deleted');
    });
  }

  //pilgrim list from snapshot
  List<PilgrimagesData> pilgrimListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final String place = doc['place_name'];
      final String location = doc['location'];
      final String description = doc['description'];
      final String district = doc['district'];
      final String category = doc['category'];
      final bool popular = doc['popular'];
      final String road = doc['road'];
      final String rail = doc['rail'];
      final String air = doc['air'];
      final String latitude = doc['latitude'];
      final String longitude = doc['longitude'];
      final List<String> images = List<String>.from(doc['images']);
      final List<String> links = List<String>.from(doc['links']);
      return PilgrimagesData(
        id: doc['id'],
        place: place,
        location: location,
        description: description,
        district: district,
        category: category,
        popular: popular,
        road: road,
        rail: rail,
        air: air,
        latitude: latitude,
        longitude: longitude,
        imageURL: images,
        linkURL: links,
      );
    }).toList();
  }

  Stream<List<PilgrimagesData>> get pilgrims {
    return pilgrimCollection.snapshots().map((pilgrimListFromSnapshot));
  }

  //pilgrim from firebase
  PilgrimagesData _pilgrimDataFromSnapshot(DocumentSnapshot snapshot) {
    return PilgrimagesData(
        id: snapshot['id'],
        place: snapshot['place_name'],
        location: snapshot['location'],
        description: snapshot['description'],
        district: snapshot['district'],
        category: snapshot['category'],
        popular: snapshot['popular'],
        road: snapshot['road'],
        rail: snapshot['rail'],
        air: snapshot['air'],
        latitude: snapshot['latitude'],
        longitude: snapshot['longitude'],
        imageURL: snapshot['images'],
        linkURL: snapshot['links']);
  }

  //retrieve pilgrim object by id

  Future<PilgrimagesData?> getPilgrimageById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance.collection('pilgrims').doc(id).get();

      if (documentSnapshot.exists) {
        // Use the factory constructor to create a PilgrimagesData object from the Firestore document
        return PilgrimagesData(
          id: documentSnapshot['id'],
          place: documentSnapshot['place_name'],
          location: documentSnapshot['location'],
          description: documentSnapshot['description'],
          district: documentSnapshot['district'],
          category: documentSnapshot['category'],
          popular: documentSnapshot['popular'],
          road: documentSnapshot['road'],
          rail: documentSnapshot['rail'],
          air: documentSnapshot['air'],
          latitude: documentSnapshot['latitude'],
          longitude: documentSnapshot['longitude'],
          imageURL: List<String>.from(documentSnapshot['images']),
          linkURL: List<String>.from(documentSnapshot['links']),
        );
      } else {
        // Document with the specified ID does not exist
        return null;
      }
    } catch (e) {
      print("Error getting document by ID: $e");
      return null;
    }
  }
}

class DatabaseComments {
  final String? id;
  DatabaseComments({this.id});
  final CollectionReference pilgrimCollection =
      FirebaseFirestore.instance.collection('pilgrims');

  Future insertPilgrim(CommentsModel comments) async {
    Map<String, dynamic> comment = {
      'commentId': comments.commentId,
      'userId': comments.userId,
      'userName': comments.userName,
      'pilgrimId': comments.pilgrimId,
      'message': comments.message,
    };
    return await pilgrimCollection
        .doc(comments.pilgrimId)
        .collection('comments')
        .add(comment)
        .whenComplete(() {
      print('${comments.userName} is created');
    });
  }

  // Future<CommentsModel> getMessage(String commentId) async{

  // }
}

  


  //retrieve pilgrim object by id
  