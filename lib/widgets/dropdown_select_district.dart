import 'package:flutter/material.dart';

class DropDownSelectDistrict extends StatefulWidget {
  DropDownSelectDistrict({super.key});

  @override
  State<DropDownSelectDistrict> createState() => _DropDownSelectDistrictState();
}

class _DropDownSelectDistrictState extends State<DropDownSelectDistrict> {
  List<DropdownMenuItem<String>> get dropDownDistricts {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text('Select District'), value: 'Select District'),
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

  var selectedDistrict = 'Select District';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
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
              value: selectedDistrict,
              onChanged: (String? newValue) {
                setState(
                  () {
                    selectedDistrict = newValue!;
                  },
                );
              },
              items: dropDownDistricts,
            ),
          ),
        ],
      ),
    );
  }
}
