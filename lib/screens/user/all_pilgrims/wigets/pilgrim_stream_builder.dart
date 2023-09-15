import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devine_kerala_journey/screens/user/all_pilgrims/wigets/pilgrim_list_view.dart';
import 'package:flutter/material.dart';

import '../../../../model/pilgrimages_data.dart';

class PilgrimStreamBuilder extends StatelessWidget {
  const PilgrimStreamBuilder({
    super.key,
    required this.query,
    required this.district,
    required this.categories,
  });

  final String query;
  final String district;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pilgrims').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error occurred'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final List<PilgrimagesData> searchPilgrims = snapshot.data!.docs
                .map((doc) => PilgrimagesData(
                    id: doc['id'],
                    place: doc['place_name'],
                    location: doc['location'],
                    description: doc['description'],
                    district: doc['district'],
                    category: doc['category'],
                    popular: doc['popular'],
                    road: doc['road'],
                    rail: doc['rail'],
                    air: doc['air'],
                    latitude: doc['latitude'],
                    longitude: doc['longitude'],
                    imageURL: List.from(doc['images']),
                    linkURL: List.from(doc['links'])))
                .where((pilgrim) =>
                    pilgrim.place.toLowerCase().contains(query.toLowerCase()))
                .toList();
            List<PilgrimagesData> filterDistrict;
            if (district == '') {
              filterDistrict = searchPilgrims;
            } else {
              filterDistrict = searchPilgrims
                  .where((pilgrim) => pilgrim.district == district)
                  .toList();
            }
            List<PilgrimagesData> filteredCategories;
            if (categories.isEmpty) {
              filteredCategories = filterDistrict;
            } else {
              filteredCategories = filterDistrict
                  .where((pilgrim) => categories.contains(pilgrim.category))
                  .toList();
            }

            if (filteredCategories.isEmpty) {
              return const Center(
                child: Text('There is no data'),
              );
            } else {
              return PilgrimListView(filteredCategories: filteredCategories);
            }
          }
        }),
      ),
    );
  }
}
