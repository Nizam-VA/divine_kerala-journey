import 'package:flutter/material.dart';

import '../../../../styles/app_colors.dart';
import '../../../screen_signup.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => ScreenSignUp()),
        );
      },
      child: const Text(
        'Create account',
        style: TextStyle(color: AppColors.primary),
        textAlign: TextAlign.end,
      ),
    );
  }
}
