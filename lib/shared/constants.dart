import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

final inputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
  filled: true,
  fillColor: Colors.white,
);

const SAVE_KEY_NAME = 'UserLoggedIn';

ValueNotifier<List<PilgrimagesData>> allPilgrims =
    ValueNotifier<List<PilgrimagesData>>([]);

ValueNotifier<List<String>> allImages = ValueNotifier<List<String>>([]);

getAllImages() {
  allImages.value = allPilgrims.value.expand((x) => x.imageURL).toList();
  print(allImages.value);
}

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
  'Kottyam',
  'Pathanamthitta',
  'Trivandrum'
];
List<String> categories = [
  'Masjid',
  'Temple',
  'Church',
  'Synagoge',
  'Historical',
  'Others'
];

List<String> categoriesList = [
  'Masjid',
  'Temple',
  'Church',
  'Synagoge',
  'Historical',
  'Others'
];

List<IconData> icons = const [
  Icons.mosque,
  Icons.temple_hindu,
  Icons.church,
  Icons.synagogue,
  Icons.history,
  Icons.tour_outlined
];

InputDecoration inputDecorations() {
  return InputDecoration(
      hintText: 'Search pilgrims here...',
      suffixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: const BorderSide(color: AppColors.primary, width: .5)));
}
