import 'package:flutter/material.dart';

class DropDownSelectCategory extends StatefulWidget {
  const DropDownSelectCategory({super.key});

  @override
  State<DropDownSelectCategory> createState() => _DropDownSelectCategoryState();
}

class _DropDownSelectCategoryState extends State<DropDownSelectCategory> {
  List<DropdownMenuItem<String>> get dropDownCatagaries {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text('Select Category'), value: 'Select Category'),
      DropdownMenuItem(child: Text('Kasaragode'), value: 'Kasaragode'),
      DropdownMenuItem(child: Text('Kannur'), value: 'Kannur'),
      DropdownMenuItem(child: Text('Kozhikkode'), value: 'Kozhikkode'),
      DropdownMenuItem(child: Text('Wayanad'), value: 'Wayanad'),
      DropdownMenuItem(child: Text('Malappuram'), value: 'Malappuram'),
      DropdownMenuItem(child: Text('Palakkad'), value: 'Palakkad'),
      DropdownMenuItem(child: Text('Thrissur'), value: 'Thrissur'),
      DropdownMenuItem(child: Text('Eranakulam'), value: 'Eranakulam'),
    ];
    return menuItems;
  }

  var selectedCategory = 'Select Category';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        dropdownColor: Colors.white,
        value: selectedCategory,
        onChanged: (String? newValue) {
          setState(
            () {
              selectedCategory = newValue!;
            },
          );
        },
        items: dropDownCatagaries,
      ),
    );
  }
}
