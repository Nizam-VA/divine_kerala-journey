import 'package:flutter/material.dart';

class FolatingButton extends StatelessWidget {
  const FolatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: () {},
      child: const Icon(Icons.comment),
    );
  }
}
