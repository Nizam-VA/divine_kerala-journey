import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/screens/admin/home/widgets/widget_insert_button.dart';
import 'package:devine_kerala_journey/screens/admin/home/widgets/widget_sign_out.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/screens/admin/home/widgets/pilgrim_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenAdminHome extends StatelessWidget {
  final AuthServices _auth = AuthServices();
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
            title: const Text('Admin', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: AppColors.primary,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              WidgetSignOut(auth: _auth),
            ],
          ),
          floatingActionButton: const WidgetInsertButton(),
          body: const PilgrimList()),
    );
  }
}
