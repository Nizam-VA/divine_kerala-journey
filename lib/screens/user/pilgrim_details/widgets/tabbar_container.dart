import 'package:devine_kerala_journey/screens/user/pilgrim_details/widgets/tabbar_pilgrimage_details.dart';
import 'package:flutter/material.dart';

import '../../../../styles/app_colors.dart';
import '../screen_pilgrimes_details.dart';

class TabbarContainer extends StatelessWidget {
  const TabbarContainer({
    super.key,
    required this.widget,
  });

  final ScreenPilgrimesDetails widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).size.height / 3) - 20,
      right: 12,
      left: 12,
      child: Container(
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(
              color: AppColors.primary,
              width: .3,
            ),
          ),
          child: TabBarPilgrimageDetails(pilgrim: widget.pilgrim)),
    );
  }
}
