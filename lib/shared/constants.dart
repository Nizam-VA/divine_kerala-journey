import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:flutter/material.dart';

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
