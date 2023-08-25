import 'package:flutter/material.dart';

class About extends StatelessWidget {
  List<Icon> icons = [
    Icon(Icons.directions_bus),
    Icon(Icons.directions_railway_filled_outlined),
    Icon(Icons.flight)
  ];
  List<String> ways = ['Road', 'Rail', 'Air'];
  List<String> description = [
    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
    'The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ',
    ' Various versions have evolved over the years, sometimes by accident, sometimes on purpose',
  ];
  About({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              Text(
                'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.',
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
                        onPressed: () {},
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
                        onPressed: () {},
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
}
