import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/screens/admin/view_pilgrims/screen_admin_view_pilgrim.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../styles/app_colors.dart';

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
          padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) =>
                      ScreemAdminViewPilgrim(pilgrim: pilgrims[index]),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(pilgrims[index].imageURL[0]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14, left: 12),
                    child: Text(pilgrims[index].place,
                        style: const TextStyle(color: AppColors.notFavorite),
                        textAlign: TextAlign.center),
                  ),
                  PopupMenuButton(
                    onSelected: (value) async {
                      if (value == 'edit') {
                      } else {
                        await DatabasePilgrim()
                            .deletePilgrim(pilgrims[index].id);
                      }
                    },
                    color: Colors.white,
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                      const PopupMenuItem(
                          value: 'delete', child: Text('Delete'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
