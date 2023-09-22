import 'dart:async'; // Import dart:async for Timer

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

import '../../../../model/pilgrimages_data.dart';
import '../../pilgrim_details/screen_pilgrimes_details.dart';

class PilgrimListView extends StatefulWidget {
  const PilgrimListView({
    super.key,
    required this.filteredCategories,
  });

  final List<PilgrimagesData> filteredCategories;

  @override
  _PilgrimListViewState createState() => _PilgrimListViewState();
}

class _PilgrimListViewState extends State<PilgrimListView> {
  bool stopShimmer = false;

  @override
  void initState() {
    super.initState();
    // Start a timer to stop shimmer after a certain duration (e.g., 2 seconds)
    Timer(const Duration(seconds: 2), () {
      setState(() {
        stopShimmer = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.filteredCategories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ScreenPilgrimesDetails(
                      pilgrim: widget.filteredCategories[index])));
            },
            child: stopShimmer
                ? Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                            widget.filteredCategories[index].imageURL[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14, left: 12),
                      child: Text(
                        widget.filteredCategories[index].place,
                        style: TextStyle(
                            shadows: const [
                              Shadow(color: Colors.black, blurRadius: 40)
                            ],
                            color: Colors.yellow[200],
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Shimmer(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.grey[300]!,
                        Colors.grey[100]!,
                        Colors.grey[300]!,
                      ],
                      stops: [0.4, 0.5, 0.6],
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors
                            .grey, // Use a fallback color while shimmering
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
