import 'dart:io';

import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/screen_admin_update.dart';
import '../styles/app_colors.dart';

class PilgrimList extends StatefulWidget {
  const PilgrimList({super.key});

  @override
  State<PilgrimList> createState() => _PilgrimListState();
}

class _PilgrimListState extends State<PilgrimList> {
  @override
  Widget build(BuildContext context) {
    final pilgrims = Provider.of<List<PilgrimagesData>>(context);
    return ListView.builder(
      itemCount: pilgrims.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: FileImage(File(pilgrims[index].imageURL[0])),
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
                    pilgrims[index].place,
                    style: const TextStyle(
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
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.notFavorite,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
