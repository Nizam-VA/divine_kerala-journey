import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ScreenUserStoryDetails extends StatelessWidget {
  const ScreenUserStoryDetails({super.key});

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
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[300],
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: Text(
                        'Shabarimala',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: Text(
                        "Sabarimala is a prominent Hindu pilgrimage site located in the state of Kerala, India. It is known for the Ayyappa Temple, dedicated to Lord Ayyappa, a deity revered as the son of Lord Shiva and Lord Vishnu in a composite form. The temple is situated on a hilltop within the Periyar Tiger Reserve, and its unique feature is that it attracts millions of devotees, primarily men, during the annual pilgrimage season from November to January. The pilgrimage is marked by a rigorous 41-day fasting and abstinence period observed by the devotees, followed by a challenging trek through the forested terrain to reach the temple. Sabarimala is renowned for its strict religious practices and customs, and the pilgrimage holds deep significance for devotees seeking spiritual growth and fulfillment. The temple's traditions and controversies surrounding issues like gender restrictions in the past have also garnered significant attention and debate",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
