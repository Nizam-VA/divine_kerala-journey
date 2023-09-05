import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles/app_colors.dart';
import '../widgets/user_pilgrim_list.dart';

class ScreenUserViewAllPilgrims extends StatelessWidget {
  const ScreenUserViewAllPilgrims({super.key});

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
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Pilgrims', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: UserPilgrimList(),
      ),
    );
  }
}
