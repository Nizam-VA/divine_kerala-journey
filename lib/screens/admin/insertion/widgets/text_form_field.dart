import 'package:flutter/material.dart';

import '../screen_admin_insert_data.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({super.key, required this.text});
  final String text;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter the ${widget.text}:';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        setState(() {
          place = value;
        });
      },
      decoration: InputDecoration(hintText: '${widget.text}: '),
    );
  }
}
