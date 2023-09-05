class PilgrimagesData {
  String id;
  String place;
  String location;
  String description;
  String district;
  String category;
  bool popular;
  String road;
  String rail;
  String air;
  String latitude;
  String longitude;
  List<String> imageURL;
  List<String> linkURL;

  PilgrimagesData({
    required this.id,
    required this.place,
    required this.location,
    required this.description,
    required this.district,
    required this.category,
    required this.popular,
    required this.road,
    required this.rail,
    required this.air,
    required this.latitude,
    required this.longitude,
    required this.imageURL,
    required this.linkURL,
  });
}
