import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devine_kerala_journey/model/pilgrimages_data.dart';

class DatabasePilgrimes {
  insertPilgrime(PilgrimagesData pilgrimagesData) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('pilgrimes')
        .doc(pilgrimagesData.id);
    Map<String, dynamic> pilgrimes = {
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
    documentReference.set(pilgrimes);
  }
}
