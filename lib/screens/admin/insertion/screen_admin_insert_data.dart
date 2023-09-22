import 'dart:io';

import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:devine_kerala_journey/shared/constants.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String? place;
int countImage = 0;

class ScreenAdminInsertData extends StatefulWidget {
  const ScreenAdminInsertData({super.key});

  @override
  State<ScreenAdminInsertData> createState() => _ScreenAdminInsertDataState();
}

class _ScreenAdminInsertDataState extends State<ScreenAdminInsertData> {
  int countLink = 0;
  final _formKey = GlobalKey<FormState>();

  String id = DateTime.now().toString();

  String? location;
  String? description;
  String? district;
  String? category;
  bool popular = false;
  String? rail;
  String? road;
  String? air;
  String? latitude;
  String? longitude;
  List<String> images = [];
  String link = '';
  List<String> links = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            const Text('Add Pilgrims', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the place name';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      place = value;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'place'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the location';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      location = value;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'location'),
                ),
                const SizedBox(height: 12),
                const SizedBox(
                  width: double.infinity,
                  child: Text('Description:', textAlign: TextAlign.start),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  cursorHeight: 18,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: .1, color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  decoration:
                      inputDecoration.copyWith(label: const Text('District')),
                  value: districts[0],
                  items: districts.map((dist) {
                    return DropdownMenuItem(value: dist, child: Text(dist));
                  }).toList(),
                  onChanged: ((value) => setState(() => district = value!)),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  decoration:
                      inputDecoration.copyWith(label: const Text('Category')),
                  value: categories[0],
                  items: categories.map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat));
                  }).toList(),
                  onChanged: ((value) => setState(() => category = value!)),
                ),
                CheckboxListTile(
                  value: popular,
                  onChanged: (value) {
                    setState(() {
                      popular = value!;
                    });
                  },
                  title: const Text('popular'),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text('Rail:', textAlign: TextAlign.start),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the rail details';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      rail = value;
                    });
                  },
                  cursorHeight: 18,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: .1, color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const SizedBox(
                  width: double.infinity,
                  child: Text('Road:', textAlign: TextAlign.start),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the road details';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      road = value;
                    });
                  },
                  cursorHeight: 18,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: .1, color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const SizedBox(
                  width: double.infinity,
                  child: Text('Air:', textAlign: TextAlign.start),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the air details';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      air = value;
                    });
                  },
                  cursorHeight: 18,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: .1, color: AppColors.primary),
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the latitude';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      latitude = value;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'latitude'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the longitude';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      longitude = value;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'longitude'),
                ),
                const SizedBox(height: 12),
                Column(
                    children: List.generate(countImage, (index) {
                  return Visibility(
                    visible: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: MediaQuery.of(context).size.height / 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(),
                            image: DecorationImage(
                                image: index < images.length
                                    ? FileImage(File(images[index]))
                                    : FileImage(File('')),
                                fit: BoxFit.cover),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              images.removeAt(index);
                              countImage--;
                              print(images);
                            });
                          },
                          icon: const CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.red,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12,
                              child: Icon(Icons.remove, color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () async {
                    await bottomSheet(context).then((value) {
                      setState(() {
                        countImage++;
                      });
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Image'),
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
                          child: Form(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the youtube link';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  link = value;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: 'YouTube link ${index + 1}'),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              countLink--;
                              links.removeAt(index);
                              print(links);
                            });
                          },
                          icon: const CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.red,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12,
                              child: Icon(Icons.remove, color: Colors.red),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })),
                TextButton.icon(
                  onPressed: () {
                    if (link.isNotEmpty) {
                      links.add(link);
                    }
                    setState(() {
                      countLink++;
                    });
                    print(links);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Add YouTube Link',
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final pilgrim = PilgrimagesData(
                          id: id,
                          place: place!,
                          location: location!,
                          description: description!,
                          district: district!,
                          category: category!,
                          popular: popular,
                          road: road!,
                          rail: rail!,
                          air: air!,
                          latitude: latitude!,
                          longitude: longitude!,
                          imageURL: images,
                          linkURL: links,
                        );
                        print(pilgrim.air);
                        await DatabasePilgrim(id: id).insertPilgrim(pilgrim);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future bottomSheet(BuildContext context) async {
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
                        images.add(img!.path);
                      });

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
                        images.add(img!.path);
                      });

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
