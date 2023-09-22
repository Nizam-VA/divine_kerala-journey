import 'package:devine_kerala_journey/screens/user/all_pilgrims/wigets/pilgrim_stream_builder.dart';
import 'package:flutter/material.dart';

import '../../../../shared/constants.dart';
import '../../../../styles/app_colors.dart';

class UserViewAllContainer extends StatefulWidget {
  UserViewAllContainer({super.key});

  @override
  State<UserViewAllContainer> createState() => _UserViewAllContainerState();
}

class _UserViewAllContainerState extends State<UserViewAllContainer> {
  String query = '';
  String district = '';
  List<String> categories = [];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    // final pilgrims = Provider.of<List<PilgrimagesData>>(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: h,
        width: w,
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 12),
              queryTextField(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: h / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary, width: .5),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 2),
                      districtDropdown(),
                      const SizedBox(height: 10),
                      categoryButtons()
                    ],
                  ),
                ),
              ),
              PilgrimStreamBuilder(
                  query: query, district: district, categories: categories),
            ],
          ),
        ),
      ),
    );
  }

  Expanded categoryButtons() {
    return Expanded(
        child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categoriesList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / .30, crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2),
          child: ElevatedButton.icon(
            onPressed: () async {
              categoryItems(categoriesList[index]);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: categories.contains(categoriesList[index])
                    ? AppColors.primary
                    : Colors.white,
                side: BorderSide(
                    color: categories.contains(categoriesList[index])
                        ? Colors.white
                        : AppColors.primary,
                    width: .5)),
            icon: Icon(icons[index],
                size: 14,
                color: categories.contains(categoriesList[index])
                    ? Colors.white
                    : AppColors.primary),
            label: Text(
              categoriesList[index],
              style: TextStyle(
                  fontSize: 10,
                  color: categories.contains(categoriesList[index])
                      ? Colors.white
                      : AppColors.primary),
            ),
          ),
        );
      },
    ));
  }

  SizedBox districtDropdown() {
    return SizedBox(
      height: 60,
      child: DropdownButtonFormField(
        decoration: inputDecoration.copyWith(
          labelText: 'Select district',
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary)),
        ),
        items: districts.map((dist) {
          return DropdownMenuItem(
            value: dist,
            child: Text(dist),
          );
        }).toList(),
        onChanged: ((value) {
          setState(() => district = value!);
        }),
      ),
    );
  }

  SizedBox queryTextField() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            query = value;
          });
        },
        decoration:
            inputDecorations().copyWith(contentPadding: EdgeInsets.all(20)),
      ),
    );
  }

  categoryItems(String category) {
    if (categories.contains(category)) {
      categories.remove(category);
      print(categories);
    } else {
      categories.add(category);
      print(categories);
    }
    setState(() {});
  }
}
