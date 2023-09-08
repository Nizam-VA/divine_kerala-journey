import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/screens/screen_view_map.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  PilgrimagesData pilgrim;
  About({required this.pilgrim});
  List<Icon> icons = [
    Icon(Icons.directions_bus),
    Icon(Icons.directions_railway_filled_outlined),
    Icon(Icons.flight)
  ];
  List<String> ways = ['Road', 'Rail', 'Air'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              Text(
                pilgrim.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ScreenViewMap(
                                    latitude: pilgrim.latitude,
                                    longitude: pilgrim.longitude,
                                    place: pilgrim.place,
                                  )));
                        },
                        icon: CircleAvatar(
                          radius: 21,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/icons/send.png',
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                      const Text('Direction'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          launchGoogleMaps(pilgrim.location);
                        },
                        icon: CircleAvatar(
                          radius: 21,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              'assets/icons/maps-and-flags.png',
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                      const Text('Google Map'),
                    ],
                  ),
                ],
              ),
              Divider(),
              Title(
                color: Colors.black,
                child: const Text(
                  'How to reach?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                  children: List.generate(3, (index) {
                List<String> description = [
                  pilgrim.road,
                  pilgrim.rail,
                  pilgrim.air
                ];
                return ListTile(
                  title: Text(
                    description[index],
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  leading: Column(
                    children: [
                      CircleAvatar(
                        child: icons[index],
                      ),
                      Text(ways[index])
                    ],
                  ),
                );
              }))
            ],
          ),
        ),
      ),
    );
  }

  void launchGoogleMaps(String locationLink) async {
    if (await canLaunchUrl(Uri.parse(locationLink))) {
      await launchUrl(Uri.parse(locationLink));
    } else {
      throw ('Could not launch $locationLink');
    }
  }
}
