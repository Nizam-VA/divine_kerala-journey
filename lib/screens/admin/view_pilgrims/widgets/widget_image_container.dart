import 'package:flutter/material.dart';

import '../../../../model/pilgrimages_data.dart';

class WidgetImageContainer extends StatelessWidget {
  const WidgetImageContainer({
    super.key,
    required this.pilgrim,
  });

  final PilgrimagesData pilgrim;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
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
                    image: NetworkImage(pilgrim.imageURL[0]),
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
          Text('Train: ${pilgrim.rail}', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          Text('Road: ${pilgrim.road}', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          Text('Latitude: ${pilgrim.latitude}',
              style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          Text('Longitude: ${pilgrim.longitude}',
              style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
