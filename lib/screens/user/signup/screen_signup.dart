import 'package:devine_kerala_journey/screens/user/main/screen_user.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/services/database_services.dart';
import 'package:devine_kerala_journey/shared/loading.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/constants.dart';

class ScreenSignUp extends StatefulWidget {
  ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';
  String email = '';
  String rePassword = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              title: Text(
                'Sign UP',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(48),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Spacer(),
                        CircleAvatar(
                          radius: 40,
                          child: Image.asset(
                              'assets/icons/divine-kerala-journey-logo.webp'),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username id: ';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Username: ',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //     hintText: 'Last Name: ',
                        //     hintStyle: TextStyle(
                        //       fontSize: 12,
                        //     ),
                        //   ),
                        // ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your e-mail id: ';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'E-mail id: ',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'Please enter a 6+ password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Password: ',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != password) {
                              return 'Please enter correct password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              rePassword = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Re-enter password: ',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 48,
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
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        "couldn't register because, your mail format bad";
                                    loading = false;
                                  });
                                } else {
                                  final DatabaseUser _user = DatabaseUser();
                                  _user.insertUser(result.uid, name, email);
                                  final _pref =
                                      await SharedPreferences.getInstance();
                                  await _pref.setBool(SAVE_KEY_NAME, true);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (ctx) => ScreenUser()));
                                }
                              }
                            },
                            child: Text(
                              'SIGN UP',
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
                        SizedBox(height: 12),
                        Text(error,
                            style: TextStyle(color: Colors.red, fontSize: 12)),
                        SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "By signing in , I agree to Divine Kerala Journery’s Terms and Prinvacy Plolicy",
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
