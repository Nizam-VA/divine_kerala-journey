import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(),
                  title: const Text('Hello'),
                  subtitle: const Text('Nissamudeen'),
                  trailing: Text(DateTime.now().toString()),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: 4)),
    );
  }
}
