import 'package:devine_kerala_journey/shared/constants.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  List<String> districts = [
    'Alappuzha',
    'Eranakulam',
    'Thrissur',
    'Malappuram',
    'Kozhikkode',
    'Kasaragode',
    'Kannur',
    'Wayanad',
    'Palakkad',
    'Kollam',
    'Idukki',
    'Pathanamthitta',
    'Trivandrum'
  ];
  String district = '';
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: h / 6,
      width: w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary, width: .5),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          DropdownButtonFormField(
            decoration: inputDecoration.copyWith(label: const Text('District')),
            value: districts[0],
            items: districts.map((dist) {
              return DropdownMenuItem(
                child: Text('$dist'),
                value: dist,
              );
            }).toList(),
            onChanged: ((value) => setState(() => district = value!)),
          ),
        ],
      ),
    );
  }
}
