import 'package:devine_kerala_journey/screens/screen_admin_home.dart';
import 'package:devine_kerala_journey/screens/screen_signup.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatelessWidget {
  AuthServices authServices = AuthServices();
  ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(48),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Spacer(),
                CircleAvatar(
                  radius: 40,
                  child: Image.asset(
                      'assets/icons/divine-kerala-journey-logo.webp'),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'E-mail id: ',
                    hintStyle: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password: ',
                    hintStyle: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: AppColors.primary,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenAdminHome(),
                        ),
                      );
                    },
                    child: Text(
                      'LOGIN',
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
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => ScreenSignUp(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create account',
                      style: TextStyle(
                        color: AppColors.font,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: MediaQuery.of(context).size.width / 5,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        'or sign in with',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: MediaQuery.of(context).size.width / 5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.primary,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await authServices.signInWithGoogle(context);
                    },
                    icon: Image.asset(
                      'assets/icons/search.png',
                      height: 16,
                    ),
                    label: Text(
                      'Google',
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                const Text(
                    "By signing in , I agree to Divine Kerala Journery’s Terms and Prinvacy Plolicy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    )),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
