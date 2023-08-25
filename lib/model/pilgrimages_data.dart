class PilgrimagesData {
  // int id;
  String place;
  String location;
  String description;
  String road;
  String rail;
  String air;
  String latitude;
  String longitude;
  List<String> imageURL = [];
  List<String> linkURL = [];
  PilgrimagesData(
      {required this.place,
      required this.location,
      required this.description,
      required this.road,
      required this.rail,
      required this.air,
      required this.latitude,
      required this.longitude});
}
