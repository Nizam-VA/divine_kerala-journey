import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/dropdown_select_category.dart';
import 'package:devine_kerala_journey/widgets/dropdown_select_district.dart';
import 'package:flutter/material.dart';

class ScreenAdminInsertData extends StatefulWidget {
  const ScreenAdminInsertData({super.key});

  @override
  State<ScreenAdminInsertData> createState() => _ScreenAdminInsertDataState();
}

class _ScreenAdminInsertDataState extends State<ScreenAdminInsertData> {
  int countImage = 0;
  int countLink = 0;

  final _placeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _roadController = TextEditingController();
  final _railController = TextEditingController();
  final _airController = TextEditingController();
  final _latController = TextEditingController();
  final _longController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Add Pilgrimes',
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
                controller: _placeController,
                decoration: const InputDecoration(
                  hintText: 'Place name: ',
                ),
              ),
              TextFormField(
                controller: _locationController,
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
                controller: _descriptionController,
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
                controller: _railController,
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
                controller: _roadController,
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
                controller: _airController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              TextFormField(
                controller: _latController,
                decoration: const InputDecoration(
                  hintText: 'Latitude:  ',
                ),
              ),
              TextFormField(
                controller: _longController,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width / 1.4,
                        height: MediaQuery.of(context).size.height / 6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            countImage--;
                          });
                        },
                        icon: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.red,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 12,
                            child: Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'YouTube link ${index + 1}'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            countLink--;
                          });
                        },
                        icon: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.red,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 12,
                            child: Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
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
                    var pilgrime = PilgrimagesData(
                        place: _placeController.text,
                        location: _locationController.text,
                        description: _descriptionController.text,
                        road: _roadController.text,
                        rail: _railController.text,
                        air: _airController.text,
                        latitude: _latController.text,
                        longitude: _longController.text);
                    print(pilgrime.place);
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
