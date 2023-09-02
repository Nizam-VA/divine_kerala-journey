import 'package:devine_kerala_journey/screens/screen_admin_insert_data.dart';
import 'package:devine_kerala_journey/screens/screen_admin_update.dart';
import 'package:devine_kerala_journey/screens/screen_login.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ScreenAdminHome extends StatelessWidget {
  AuthServices _auth = AuthServices();
  ScreenAdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => ScreenLogin()),
                  (route) => false);
            },
            icon: Icon(Icons.power_settings_new),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ScreenAdminInsertData(),
            ),
          );
        },
        child: Row(
          children: [
            Icon(Icons.add),
            Text(
              'ADD',
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: List.generate(2, (index) {
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/mkc-overview.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 14,
                        left: 12,
                      ),
                      child: Text(
                        'Markaz Knowledge City, Calicut',
                        style: TextStyle(
                          color: AppColors.notFavorite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ScreenAdminUpdate(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: AppColors.notFavorite,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
