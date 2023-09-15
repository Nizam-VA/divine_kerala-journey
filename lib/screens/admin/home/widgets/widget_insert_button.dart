import 'package:flutter/material.dart';

import '../../insertion/screen_admin_insert_data.dart';

class WidgetInsertButton extends StatelessWidget {
  const WidgetInsertButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ScreenAdminInsertData(),
          ),
        );
      },
      child: const Row(
        children: [
          Icon(Icons.add),
          Text('ADD'),
        ],
      ),
    );
  }
}
