import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/dropdown_select_category.dart';
import 'package:devine_kerala_journey/widgets/dropdown_select_district.dart';
import 'package:flutter/material.dart';

class ScreenAdminUpdate extends StatefulWidget {
  const ScreenAdminUpdate({super.key});

  @override
  State<ScreenAdminUpdate> createState() => _ScreenAdminUpdateState();
}

class _ScreenAdminUpdateState extends State<ScreenAdminUpdate> {
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

  List<DropdownMenuItem<String>> get dropDownCatagaries {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text('Select Catagary'), value: 'Select Catagary'),
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
  var selectedCatagary = 'Select Catagary';
  int countImage = 0;
  int countLink = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Edit Pilgrime',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Place name: ',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Location: ',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Description:',
                  textAlign: TextAlign.start,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              DropDownSelectDistrict(),
              const SizedBox(
                height: 12,
              ),
              DropDownSelectCategory(),
              CheckboxListTile(
                value: false,
                onChanged: (bool? value) {
                  value = value;
                },
                title: Text('Popular'),
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Rail:',
                  textAlign: TextAlign.start,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Road:',
                  textAlign: TextAlign.start,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Air:',
                  textAlign: TextAlign.start,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Latitude:  ',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Longitude: ',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                  children: List.generate(countImage, (index) {
                return Visibility(
                  visible: true,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                  ),
                );
              })),
              const SizedBox(
                height: 12,
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    countImage++;
                  });
                },
                icon: Icon(Icons.add),
                label: const Text(
                  'Add Image',
                ),
              ),
              Column(
                  children: List.generate(countLink, (index) {
                return Visibility(
                    visible: true,
                    child: TextFormField(
                      decoration:
                          InputDecoration(hintText: 'YouTube link${index + 1}'),
                    ));
              })),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    countLink++;
                  });
                },
                icon: Icon(Icons.add),
                label: const Text(
                  'Add YouTube Link',
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
