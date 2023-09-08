import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}
