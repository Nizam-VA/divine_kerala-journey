import 'package:flutter/material.dart';

import '../../../../model/pilgrimages_data.dart';
import '../../../../styles/app_colors.dart';
import '../../pilgrim_details/screen_pilgrimes_details.dart';

class PilgrimListView extends StatelessWidget {
  const PilgrimListView({
    super.key,
    required this.filteredCategories,
  });

  final List<PilgrimagesData> filteredCategories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ScreenPilgrimesDetails(
                      pilgrim: filteredCategories[index])));
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(filteredCategories[index].imageURL[0]),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 14, left: 12),
                  child: Text(filteredCategories[index].place,
                      style: const TextStyle(color: AppColors.notFavorite),
                      textAlign: TextAlign.center)),
            ),
          ),
        );
      },
    );
  }
}
