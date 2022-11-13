import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn/common/constants/colors_constant.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ConnectingScreen extends StatelessWidget {
  const ConnectingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slider = SleekCircularSlider(
        appearance: CircularSliderAppearance(
      spinnerMode: true,
      size: 40,
      customColors: CustomSliderColors(
        progressBarColors: ColorsConstant.progressBarColor,
        gradientStartAngle: 180.0,
        gradientEndAngle: 360.0,
        trackColor: ColorsConstant.progressBarTrackColor,
        dotColor: ColorsConstant.progressBarTrackColor,
      ),
    ));
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ColorsConstant.conBackgroundColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Waiting for connection...",
            style: GoogleFonts.roboto(
              color: ColorsConstant.textBlue2,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          slider,
        ],
      ),
    );
  }
}
