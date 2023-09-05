import 'package:devine_kerala_journey/screens/screen_admin_home.dart';
import 'package:devine_kerala_journey/screens/screen_signup.dart';
import 'package:devine_kerala_journey/screens/screen_user.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/shared/loading.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(48),
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
                            if (value!.isEmpty) {
                              return 'Please enter your password: ';
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
                        const SizedBox(
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
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        "Couldn't sign in with those credentials";
                                    loading = false;
                                  });
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => ScreenAdminHome()));
                                }
                              }
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  loading = true;
                                  dynamic result = await _auth.signInAnon();
                                  if (result == null) {
                                    setState(() {
                                      error = "You can't sign in anonymously";
                                      loading = false;
                                    });
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => ScreenUser()));
                                  }
                                },
                                child: const Text(
                                  'Sign in anonymously',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              TextButton(
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
                                    color: AppColors.primary,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(error,
                            style: TextStyle(color: Colors.red, fontSize: 12)),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                              loading = true;
                              dynamic result =
                                  await _auth.signInWithGoogle(context);

                              if (result == null) {
                                setState(() {
                                  error = 'You cant sign in this account';
                                  loading = false;
                                });
                              } else {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) => ScreenUser()));
                              }
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
                            "By signing in , I agree to Divine Kerala journey's Terms and Prinvacy Plolicy",
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
            ),
          );
  }
}
