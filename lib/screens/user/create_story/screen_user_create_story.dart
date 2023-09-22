import 'dart:io';

import 'package:devine_kerala_journey/database/stories_database_helper.dart';
import 'package:devine_kerala_journey/model/user_story.dart';
import 'package:devine_kerala_journey/screens/user/create_story/widgets/text_form_field.dart';
import 'package:devine_kerala_journey/screens/user/main/screen_user.dart';
import 'package:devine_kerala_journey/shared/constants.dart';
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
  int count = 0;
  var selectedCategory = 'Select Category';
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
            InkWell(
              onTap: () {
                bottomSheet(context);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(width: .5),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: _imagePath != null
                            ? FileImage(File(_imagePath!))
                            : FileImage(File('')),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                      child: _imagePath == null
                          ? const Icon(Icons.add_a_photo_outlined,
                              color: AppColors.primary, size: 50)
                          : null)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text('Place:', textAlign: TextAlign.start),
                    ),
                    WidgetTextFormField(
                        descriptionController: _placeController),
                    const SizedBox(height: 12),
                    const SizedBox(
                      width: double.infinity,
                      child: Text('Description:', textAlign: TextAlign.start),
                    ),
                    WidgetTextFormField(
                        descriptionController: _descriptionController),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField(
                        decoration: inputDecoration.copyWith(
                          labelText: 'Select category',
                        ),
                        items: categories.map((cat) {
                          return DropdownMenuItem(value: cat, child: Text(cat));
                        }).toList(),
                        onChanged: ((value) =>
                            setState(() => selectedCategory = value!)),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      decoration: const BoxDecoration(
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
                              category: selectedCategory,
                              images: _imagePath!,
                            );
                            widget.databaseHelper
                                .insertStory(userStory)
                                .then((id) {
                              if (id > 0) {
                                _placeController.text = '';
                                _descriptionController.text = '';
                                _imagePath = '';
                                selectedCategory = 'Select Category';
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Data added successfully',
                                        style: TextStyle(color: Colors.green)),
                                    backgroundColor: Colors.white,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
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
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary, elevation: 0),
                        child: const Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
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
