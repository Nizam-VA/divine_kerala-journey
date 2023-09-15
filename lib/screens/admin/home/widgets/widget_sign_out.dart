import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/auth_services.dart';
import '../../../user/login/screen_login.dart';

class WidgetSignOut extends StatelessWidget {
  const WidgetSignOut({super.key, required AuthServices auth}) : _auth = auth;

  final AuthServices _auth;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final _pref = await SharedPreferences.getInstance();
        await _pref.clear();
        await _auth.signOutOfGoogle(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => ScreenLogin()),
            (route) => false);
      },
      icon: const Icon(Icons.power_settings_new),
    );
  }
}
