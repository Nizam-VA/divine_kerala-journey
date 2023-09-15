import 'package:flutter/material.dart';

import '../../../../styles/app_colors.dart';

class SearchText extends StatelessWidget {
  const SearchText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Search pilgrims here...',
          suffixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide:
                  const BorderSide(color: AppColors.primary, width: .5))),
    );
  }
}
