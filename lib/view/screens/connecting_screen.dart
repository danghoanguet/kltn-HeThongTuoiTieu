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
      size: 60,
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
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://visme.co/blog/wp-content/uploads/2017/07/50-Beautiful-and-Minimalist-Presentation-Backgrounds-05.jpg"),
          fit: BoxFit.cover,
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
              fontSize: 30,
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
