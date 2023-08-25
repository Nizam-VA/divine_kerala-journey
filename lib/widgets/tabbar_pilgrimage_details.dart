import 'package:devine_kerala_journey/widgets/near_by.dart';
import 'package:devine_kerala_journey/widgets/photos.dart';
import 'package:devine_kerala_journey/widgets/videos.dart';
import 'package:flutter/material.dart';

import 'about.dart';

class TabBarPilgrimageDetails extends StatefulWidget {
  const TabBarPilgrimageDetails({super.key});

  @override
  State<TabBarPilgrimageDetails> createState() =>
      _TabBarPilgrimageDetailsState();
}

class _TabBarPilgrimageDetailsState extends State<TabBarPilgrimageDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(
                text: 'About',
              ),
              Tab(
                text: 'Photos',
              ),
              Tab(
                text: 'Videos',
              ),
              Tab(
                text: 'Comments',
              )
            ]),
            Expanded(
              child: TabBarView(
                children: [
                  About(),
                  Photos(),
                  Videos(),
                  NearBy(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
