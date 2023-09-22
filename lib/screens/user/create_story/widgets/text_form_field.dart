import 'package:flutter/material.dart';

import '../../../../styles/app_colors.dart';

class WidgetTextFormField extends StatelessWidget {
  const WidgetTextFormField({
    super.key,
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _descriptionController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter the description';
        }
        return null;
      },
      maxLines: null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: .1, color: AppColors.primary),
        ),
      ),
    );
  }
}
