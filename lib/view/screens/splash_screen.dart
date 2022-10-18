import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kltn/common/constants/colors_constant.dart';

import 'dashboard.dart';

class SplashScreen extends StatelessWidget {
  final imageBackgroundUrl =
      "https://visme.co/blog/wp-content/uploads/2017/07/50-Beautiful-and-Minimalist-Presentation-Backgrounds-05.jpg";
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Dashboard())));
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageBackgroundUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash_screen_plant.png"),
            SizedBox(height: 70),
            CircularProgressIndicator(
              color: ColorsConstant.greenPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
