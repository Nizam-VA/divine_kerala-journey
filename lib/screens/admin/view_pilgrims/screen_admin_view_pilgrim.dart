import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/screens/admin/view_pilgrims/widgets/widget_image_container.dart';
import 'package:devine_kerala_journey/screens/admin/view_pilgrims/widgets/widget_popup.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ScreemAdminViewPilgrim extends StatelessWidget {
  final PilgrimagesData pilgrim;
  const ScreemAdminViewPilgrim({super.key, required this.pilgrim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(pilgrim.place, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [WidgetPopupButton(pilgrim: pilgrim)],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: WidgetImageContainer(pilgrim: pilgrim),
        ),
      ),
    );
  }
}
