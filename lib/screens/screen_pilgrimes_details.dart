import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/tabbar_pilgrimage_details.dart';
import 'package:flutter/material.dart';

class ScreenPilgrimesDetails extends StatelessWidget {
  const ScreenPilgrimesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Image.asset(
          'assets/icons/divine-kerala-journey-logo.webp',
          height: 24,
          color: Colors.white,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        child: Icon(Icons.comment),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    color: Colors.red,
                  ),
                  Positioned(
                    top: (MediaQuery.of(context).size.height / 3) - 20,
                    right: 12,
                    left: 12,
                    child: Container(
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          border: Border.all(
                            color: AppColors.primary,
                            width: .3,
                          ),
                        ),
                        child: TabBarPilgrimageDetails()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
