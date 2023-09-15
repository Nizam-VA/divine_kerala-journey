import 'package:flutter/material.dart';

import '../../../../model/pilgrimages_data.dart';
import '../../../../services/database_services.dart';
import '../../updation/screen_admin_update.dart';

class WidgetPopupButton extends StatelessWidget {
  const WidgetPopupButton({
    super.key,
    required this.pilgrim,
  });

  final PilgrimagesData pilgrim;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
            ]);
  }
}
