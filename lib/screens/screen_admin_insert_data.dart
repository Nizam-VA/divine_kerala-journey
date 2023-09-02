import 'dart:io';

import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:devine_kerala_journey/widgets/dropdown_select_category.dart';
import 'package:devine_kerala_journey/widgets/dropdown_select_district.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScreenAdminInsertData extends StatefulWidget {
  const ScreenAdminInsertData({super.key});

  @override
  State<ScreenAdminInsertData> createState() => _ScreenAdminInsertDataState();
}

class _ScreenAdminInsertDataState extends State<ScreenAdminInsertData> {
  int countImage = 0;
  int countLink = 0;
  final _formKey = GlobalKey<FormState>();

  String place = '';
  String location = '';
  String description = '';
  String district = '';
  String category = '';
  bool popular = false;
  String rail = '';
  String road = '';
  String air = '';
  String latitude = '';
  String longitude = '';
  List<String> images = [];
  String link = '';
  List<String> links = [];

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the place name:';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      place = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Place name: ',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the location:';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      location = value;
                    });
                  },
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the description about the place:';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
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
                  value: popular,
                  onChanged: (value) {
                    setState(() {
                      popular = value!;
                    });
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the rail details:';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      rail = value;
                    });
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
                  child: Text(
                    'Road:',
                    textAlign: TextAlign.start,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the road details:';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      road = value;
                    });
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
                  child: Text(
                    'Air:',
                    textAlign: TextAlign.start,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the air details:';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      air = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the latitude of the place:';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      latitude = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Latitude:  ',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the longitude of the the place:';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      longitude = value;
                    });
                  },
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
                            border: Border.all(),
                            image: DecorationImage(
                                image: index < images.length
                                    ? FileImage(
                                        File(images[index]),
                                      )
                                    : FileImage(
                                        File(''),
                                      ),
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
                  onPressed: () async {
                    await bottomSheet(context).then(
                      (value) {
                        setState(() {
                          countImage++;
                        });
                      },
                    );
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
                    if (link.isNotEmpty) {
                      links.add(link);
                    }
                    setState(() {
                      countLink++;
                    });
                    print(links);
                  },
                  icon: Icon(Icons.add),
                  label: const Text(
                    'Add YouTube Link',
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {},
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
