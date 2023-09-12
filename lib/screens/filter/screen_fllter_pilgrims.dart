import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devine_kerala_journey/screens/pilgrim_details/screen_pilgrimes_details.dart';
import 'package:devine_kerala_journey/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/pilgrimages_data.dart';
import '../../services/database_services.dart';
import '../../styles/app_colors.dart';

class ScreenFilter extends StatefulWidget {
  const ScreenFilter({super.key});

  @override
  State<ScreenFilter> createState() => _ScreenFilterState();
}

class _ScreenFilterState extends State<ScreenFilter> {
  List<String> districts = [
    'Alappuzha',
    'Eranakulam',
    'Thrissur',
    'Malappuram',
    'Kozhikkode',
    'Kasaragode',
    'Kannur',
    'Wayanad',
    'Palakkad',
    'Kollam',
    'Idukki',
    'Pathanamthitta',
    'Trivandrum'
  ];
  List<String> categories = [
    'Masjid',
    'Temple',
  ];
  String district = '';
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return StreamProvider<List<PilgrimagesData>>.value(
      value: DatabasePilgrim().pilgrims,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Pilgrims', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.next_plan_outlined),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: h,
          width: w,
          child: Form(
            child: Column(
              children: [
                SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: h / 6,
                  width: w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary, width: .5),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      DropdownButtonFormField(
                        decoration: inputDecoration.copyWith(
                            label: const Text('District')),
                        value: districts[0],
                        items: districts.map((dist) {
                          return DropdownMenuItem(
                            child: Text('$dist'),
                            value: dist,
                          );
                        }).toList(),
                        onChanged: ((value) =>
                            setState(() => district = value!)),
                      ),
                      Expanded(
                        child: ListView(
                            children: categories.map((category) {
                          return CheckboxListTile(
                            value: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value) {},
                            title: Text(category),
                          );
                        }).toList()),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('pilgrims')
                        .snapshots(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error occurred'),
                        );
                      } else {
                        final searchPilgrims = snapshot.data!.docs
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
                            .where((pilgrim) => pilgrim.district
                                .toLowerCase()
                                .contains(district.toLowerCase()))
                            .toList();

                        if (searchPilgrims.isEmpty) {
                          return const Center(
                            child: Text('There is no data'),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: searchPilgrims.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ScreenPilgrimesDetails(
                                                    pilgrim: searchPilgrims[
                                                        index])));
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: FileImage(File(
                                              searchPilgrims[index]
                                                  .imageURL[0])),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14, left: 12),
                                        child: Text(searchPilgrims[index].place,
                                            style: const TextStyle(
                                                color: AppColors.notFavorite),
                                            textAlign: TextAlign.center)),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
