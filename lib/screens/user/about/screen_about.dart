import 'package:flutter/material.dart';

import '../../../styles/app_colors.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('About Us', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Text(
                'Welcome to Divine Kerala Journey, the mobile application that helps you explore the beautiful state of Kerala, its pilgrim sites, and tourist attractions. We prioritize your privacy and are committed to safeguarding your personal information.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 24),
              Text(
                'email: nizamuasharaf@gmail.com',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('mobile: +91 8893574657',
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
