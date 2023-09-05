import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/screens/screen_admin_insert_data.dart';
import 'package:devine_kerala_journey/screens/screen_login.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/pilgrim_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenAdminHome extends StatelessWidget {
  AuthServices _auth = AuthServices();
  ScreenAdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PilgrimagesData>>.value(
      value: DatabasePilgrim().pilgrims,
      initialData: [],
      catchError: (context, error) {
        print('Error occurred in the stream $error');
        return [];
      },
      child: Scaffold(
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
          body: const PilgrimList()),
    );
  }
}
