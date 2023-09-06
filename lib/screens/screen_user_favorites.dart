import 'package:devine_kerala_journey/screens/screen_login.dart';
import 'package:devine_kerala_journey/services/auth_services.dart';
import 'package:devine_kerala_journey/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ScreenUserFavorites extends StatelessWidget {
  AuthServices _auth = AuthServices();
  List<String> _topPligrimes = [
    'assets/images/mkc-overview.jpg',
    'assets/images/koodal-manikyam - Copy.jpg',
    'assets/images/malayattoor.jpg',
    'assets/images/beemapalli.jpg'
  ];
  List<String> places = [
    'Markaz Knowledge City, Calicut',
    'Koodal manikyam, Irinjalakkuda',
    'Malayatoor Church',
    'Beemapalli, Trivandrum'
  ];
  ScreenUserFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: Image.asset(
          'assets/icons/divine-kerala-journey-logo.webp',
          color: Colors.white,
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOutOfGoogle(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => ScreenLogin()),
                  (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: List.generate(_topPligrimes.length, (index) {
              return InkWell(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (ctx) => ScreenPilgrimesDetails(),
                  //   ),
                  // );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                    // boxShadow: [
                    //   BoxShadow(
                    //     blurRadius: 1,
                    //     spreadRadius: -1,
                    //   ),
                    // ],
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage(_topPligrimes[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 14,
                          left: 12,
                        ),
                        child: Text(
                          places[index],
                          style: TextStyle(
                            color: AppColors.notFavorite,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: AppColors.favorite,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
