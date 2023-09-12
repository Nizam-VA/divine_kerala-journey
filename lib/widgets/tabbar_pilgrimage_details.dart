import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/widgets/comments.dart';
import 'package:devine_kerala_journey/widgets/photos.dart';
import 'package:devine_kerala_journey/widgets/videos.dart';
import 'package:flutter/material.dart';

import 'about.dart';

class TabBarPilgrimageDetails extends StatefulWidget {
  final PilgrimagesData pilgrim;
  const TabBarPilgrimageDetails({super.key, required this.pilgrim});

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
                  About(pilgrim: widget.pilgrim),
                  Photos(pilgrim: widget.pilgrim),
                  Videos(pilgrim: widget.pilgrim),
                  Comments(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
