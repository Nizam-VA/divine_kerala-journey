import 'dart:io';

import 'package:devine_kerala_journey/database/stories_database_helper.dart';
import 'package:devine_kerala_journey/screens/screen_storeis_view_all.dart';
import 'package:devine_kerala_journey/screens/screen_user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user_story.dart';
import '../styles/app_colors.dart';

class ScreenUserUpdateStory extends StatefulWidget {
  final UserStory userStory;
  const ScreenUserUpdateStory({super.key, required this.userStory});

  @override
  State<ScreenUserUpdateStory> createState() => _ScreenUserUpdateStoryState();
}

class _ScreenUserUpdateStoryState extends State<ScreenUserUpdateStory> {
  UserDatabaseHelper databaseHelper = UserDatabaseHelper();
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
  void initState() {
    _placeController.text = widget.userStory.place;
    _descriptionController.text = widget.userStory.description;
    selectedCatagary = widget.userStory.category;
    _imagePath = widget.userStory.images;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        // leading: Image.asset(
        //   'assets/icons/divine-kerala-journey-logo.webp',
        //   color: Colors.white,
        // ),
        title: const Text(
          'Update Story',
          style: TextStyle(
            color: Colors.white,
          ),
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
                              id: widget.userStory.id,
                              place: place,
                              description: description,
                              category: selectedCatagary,
                              images: _imagePath!,
                            );
                            databaseHelper.updateStory(userStory).then((id) {
                              if (id > 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Updated Successfully',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                );
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => ScreenUser()),
                                    (route) => false);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Cant update data',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ScreenStoriesViewAll()),
                                );
                              }
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
