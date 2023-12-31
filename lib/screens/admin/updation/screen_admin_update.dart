import 'dart:io';

import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:devine_kerala_journey/screens/admin/home/screen_admin_home.dart';
import 'package:devine_kerala_journey/shared/constants.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/database_services.dart';

class ScreenAdminUpdate extends StatefulWidget {
  PilgrimagesData pilgrim;
  ScreenAdminUpdate({super.key, required this.pilgrim});

  @override
  State<ScreenAdminUpdate> createState() => _ScreenAdminUpdateState();
}

class _ScreenAdminUpdateState extends State<ScreenAdminUpdate> {
  final _formKey = GlobalKey<FormState>();
  String? id;
  final _placeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? district;
  String? category;
  bool? popular;
  final _railController = TextEditingController();
  final _roadController = TextEditingController();
  final _airController = TextEditingController();
  final _latController = TextEditingController();
  final _longController = TextEditingController();
  List<String> images = [];
  String link = '';
  List<String> links = [];

  int countImage = 0;
  int countLink = 0;

  @override
  void initState() {
    id = widget.pilgrim.id;
    popular = widget.pilgrim.popular;
    district = widget.pilgrim.district;
    category = widget.pilgrim.category;
    images = widget.pilgrim.imageURL;
    links = widget.pilgrim.linkURL;
    _placeController.text = widget.pilgrim.place;
    _locationController.text = widget.pilgrim.location;
    _descriptionController.text = widget.pilgrim.description;
    _railController.text = widget.pilgrim.rail;
    _roadController.text = widget.pilgrim.road;
    _airController.text = widget.pilgrim.air;
    _latController.text = widget.pilgrim.latitude;
    _longController.text = widget.pilgrim.longitude;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            const Text('Update Pilgrim', style: TextStyle(color: Colors.white)),
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
                  controller: _placeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the place name:';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(hintText: 'Place name: '),
                ),
                TextFormField(
                  controller: _locationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the location name:';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(hintText: 'Location: '),
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text('Description:', textAlign: TextAlign.start),
                ),
                TextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the place description:';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  decoration:
                      inputDecoration.copyWith(label: const Text('District')),
                  value: district,
                  items: districts.map((dist) {
                    return DropdownMenuItem(value: dist, child: Text(dist));
                  }).toList(),
                  onChanged: ((value) => setState(() => district = value!)),
                ),
                const SizedBox(height: 12),
                categoryDropdown(),
                CheckboxListTile(
                  value: popular,
                  onChanged: (bool? value) {
                    setState(() {
                      popular = value!;
                    });
                  },
                  title: const Text('Popular'),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text('Rail:', textAlign: TextAlign.start),
                ),
                TextFormField(
                  controller: _railController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the rail distance:';
                    } else {
                      return null;
                    }
                  },
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
                  child: Text('Road:', textAlign: TextAlign.start),
                ),
                TextFormField(
                  controller: _roadController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the road distance:';
                    } else {
                      return null;
                    }
                  },
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
                  child: Text('Air:', textAlign: TextAlign.start),
                ),
                TextFormField(
                  controller: _airController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the air distance:';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _latController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the latitude:';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Latitude:  ',
                  ),
                ),
                TextFormField(
                  controller: _longController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the longitude:';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(hintText: 'Longitude: '),
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                    children: List.generate(images.length, (index) {
                  return Row(
                    children: [
                      Visibility(
                        visible: true,
                        child: Container(
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
                  );
                })),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () async {
                    await bottomSheet(context).then(
                      (value) {
                        setState(() {
                          countImage++;
                        });
                      },
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Image'),
                ),
                youtubeLinks(context),
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
                  icon: Icon(Icons.add),
                  label: const Text('Add YouTube Link'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final pilgrim = PilgrimagesData(
                          id: widget.pilgrim.id,
                          place: _placeController.text,
                          location: _locationController.text,
                          description: _descriptionController.text,
                          district: district!,
                          category: category!,
                          popular: popular!,
                          road: _roadController.text,
                          rail: _railController.text,
                          air: _airController.text,
                          latitude: _latController.text,
                          longitude: _longController.text,
                          imageURL: images,
                          linkURL: links,
                        );
                        print(pilgrim.air);
                        await DatabasePilgrim(id: id).insertPilgrim(pilgrim);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (ctx) => ScreenAdminHome()),
                            (route) => false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white),
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column youtubeLinks(BuildContext context) {
    return Column(
        children: List.generate(links.length, (index) {
      return Visibility(
        visible: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Form(
                child: TextFormField(
                  initialValue: links[index],
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
                  decoration:
                      InputDecoration(hintText: 'YouTube link ${index + 1}'),
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
    }));
  }

  DropdownButtonFormField<String> categoryDropdown() {
    return DropdownButtonFormField(
      decoration: inputDecoration.copyWith(label: const Text('Category')),
      value: category,
      items: categories.map((cat) {
        return DropdownMenuItem(value: cat, child: Text(cat));
      }).toList(),
      onChanged: ((value) => setState(() => category = value!)),
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
                    label: const Text('Camera'),
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
                    label: const Text('Gallery'),
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
