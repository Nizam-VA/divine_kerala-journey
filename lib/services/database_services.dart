import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';

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
}

class DatabasePilgrim {
  final String? id;
  DatabasePilgrim({this.id});

  final CollectionReference pilgrimCollection =
      FirebaseFirestore.instance.collection('pilgrims');

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
      'images': pilgrimagesData.imageURL,
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
  List<PilgrimagesData> _pilgrimListFromSnapshot(QuerySnapshot snapshot) {
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
    return pilgrimCollection.snapshots().map((_pilgrimListFromSnapshot));
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




  


  //retrieve pilgrim object by id
  