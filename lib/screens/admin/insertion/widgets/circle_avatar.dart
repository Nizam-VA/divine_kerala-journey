import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 14,
      backgroundColor: Colors.red,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 12,
        child: Icon(Icons.remove, color: Colors.red),
      ),
    );
  }
}
