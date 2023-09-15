import 'dart:io';

import 'package:devine_kerala_journey/database/stories_database_helper.dart';
import 'package:devine_kerala_journey/model/user_story.dart';
import 'package:devine_kerala_journey/screens/screen_user.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScreenUserCreateStory extends StatefulWidget {
  UserDatabaseHelper databaseHelper = UserDatabaseHelper();
  ScreenUserCreateStory({super.key});

  @override
  State<ScreenUserCreateStory> createState() => _ScreenUserCreateStoryState();
}

class _ScreenUserCreateStoryState extends State<ScreenUserCreateStory> {
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

  int count = 0;
  var selectedCatagary = 'Select Category';
  final _formKey = GlobalKey<FormState>();
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _imagePath;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Create Story',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  color: Colors.grey[200],
                  child: _imagePath != null
                      ? Image(
                          image: FileImage(
                            File(
                              _imagePath!,
                            ),
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppColors.primary,
                          width: .3,
                        )),
                    child: TextButton.icon(
                      onPressed: () {
                        bottomSheet(context);
                      },
                      icon: Icon(Icons.add_a_photo_outlined),
                      label: Text('Add Images'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _placeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the place name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Place: ',
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the description';
                        }
                        return null;
                      },
                      cursorHeight: 18,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: .1,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
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
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: AppColors.primary,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final place = _placeController.text;
                            final description = _descriptionController.text;
                            final userStory = UserStory(
                              id: 0,
                              place: place,
                              description: description,
                              category: selectedCatagary,
                              images: _imagePath!,
                            );
                            widget.databaseHelper
                                .insertStory(userStory)
                                .then((id) {
                              if (id > 0) {
                                _placeController.text = '';
                                _descriptionController.text = '';
                                _imagePath = '';
                                selectedCatagary = 'Select Category';
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Data added successfully',
                                        style: TextStyle(color: Colors.green)),
                                    backgroundColor: Colors.white,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Data didnt added',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    backgroundColor: Colors.white,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                              currentSelectedIndex = 0;
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (ctx) => ScreenUser()),
                                  (route) => false);
                            });
                          }
                        },
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: .4,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Select the image source:',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      XFile? img = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      setState(() {
                        image = img;
                      });
                      _imagePath = image!.path;
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.camera,
                    ),
                    label: const Text(
                      'Camera',
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      XFile? img = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      setState(() {
                        image = img;
                      });
                      _imagePath = image!.path;
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.image,
                    ),
                    label: const Text(
                      'Gallery',
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
