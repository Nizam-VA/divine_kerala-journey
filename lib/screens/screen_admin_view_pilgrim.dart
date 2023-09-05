import 'dart:io';

import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/screens/screen_admin_update.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
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
        actions: [
          PopupMenuButton(
              onSelected: (value) async {
                if (value == 'edit') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ScreenAdminUpdate(pilgrim: pilgrim),
                    ),
                  );
                } else {
                  await DatabasePilgrim().deletePilgrim(pilgrim.id);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ])
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.brown[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: .5),
                    image: DecorationImage(
                        image: FileImage(
                          File(pilgrim.imageURL[0]),
                        ),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(height: 12),
              Text(pilgrim.place, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              Text('${pilgrim.location}, ${pilgrim.district}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              Text('Category: ${pilgrim.category}',
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              Text('Popular: ${pilgrim.popular}',
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              Text(pilgrim.description, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              Text('Air: ${pilgrim.air}', style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              Text('Train: ${pilgrim.rail}',
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              Text('Road: ${pilgrim.road}',
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              Text('Latitude: ${pilgrim.latitude}',
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              Text('Longitude: ${pilgrim.longitude}',
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
