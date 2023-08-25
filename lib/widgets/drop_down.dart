import 'package:flutter/material.dart';

class DropDownFormField extends StatefulWidget {
  const DropDownFormField({super.key});

  @override
  State<DropDownFormField> createState() => _DropDownFormFieldState();
}

class _DropDownFormFieldState extends State<DropDownFormField> {
  List<DropdownMenuItem<String>> get dropDownCatagories {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text('Select Category'), value: 'Select Category'),
      DropdownMenuItem(child: Text('Masjid'), value: 'Masjid'),
      DropdownMenuItem(child: Text('Temple'), value: 'Temple'),
      DropdownMenuItem(child: Text('Church'), value: 'Church'),
      DropdownMenuItem(child: Text('Synagogue'), value: 'Synagogue'),
      DropdownMenuItem(
          child: Text('Historical Place'), value: 'Historical Place'),
      DropdownMenuItem(child: Text('Others'), value: 'Others'),
    ];
    return menuItems;
  }

  var selectedCatagary = 'Select Category';
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: .2),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: .2),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        dropdownColor: Colors.white,
        value: selectedCatagary,
        onChanged: (String? newValue) {
          setState(
            () {
              selectedCatagary = newValue!;
            },
          );
        },
        items: dropDownCatagories,
      ),
    );
  }
}
