import 'package:devine_kerala_journey/screens/screen_login.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  List<String> items = ['Logout', 'Change password', 'Language'];
  ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 36, right: 24, top: 36, bottom: 12),
            child: Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Divider(),
          Column(
            children: List.generate(3, (index) {
              return InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (ctx) => ScreenLogin()),
                        (route) => false);
                  } else if (index == 1) {
                  } else {}
                },
                child: ListTile(
                  title: Text(items[index]),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
