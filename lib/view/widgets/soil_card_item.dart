import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn/view/widgets/temperature_bar.dart';
import 'package:kltn/view/widgets/water_progess_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../common/constants/colors_constant.dart';

class SoilCardItem extends StatelessWidget {
  final String value;
  final String threshold;

  const SoilCardItem({super.key, required this.value, required this.threshold});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final progress = double.parse(value) / double.parse(threshold);
    return Container(
      width: double.infinity,
      // height: size.height * 0.2,
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(20.0, 20.0),
            color: ColorsConstant.progressShadowColor,
            blurRadius: 70.0,
          ),
          BoxShadow(
            offset: Offset(-20.0, -20.0),
            color: ColorsConstant.progressShadowColor2,
            blurRadius: 70.0,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: ColorsConstant.progressBarBackground,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Soil",
                style: TextStyle(
                  color: ColorsConstant.borderTextFieldColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Row(
                children: [
                  Text(
                    isGoodCondition() ? "GOOD" : "NEED WATERING",
                    style: TextStyle(
                      color: isGoodCondition()
                          ? ColorsConstant.greenPrimaryColor
                          : ColorsConstant.yellowPrimaryColor.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  isGoodCondition()
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                        )
                      : Image.asset(
                          "assets/images/watering.png",
                          color: Colors.blue,
                        ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                height: size.width * 0.12,
                width: size.width * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.brown.withOpacity(0.9),
                    width: 2,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: ColorsConstant.borderColors,
                  ),
                ),
                child: Image.asset(
                  "assets/images/soil_threshold.png",
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "${value}".split(".")[0] + "/${threshold}%",
                style: GoogleFonts.aBeeZee(
                  color: ColorsConstant.borderTextFieldColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              Expanded(
                child: Container(
                  height: size.height * 0.15,
                  child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(progressBarWidth: 10),
                      customColors: CustomSliderColors(
                        progressBarColors: ColorsConstant.progressBarSoilColor,
                        gradientStartAngle: 180.0,
                        gradientEndAngle: 360.0,
                        trackColor: Colors.brown,
                        dotColor: ColorsConstant.progressBarTrackColor,
                      ),
                    ),
                    min: 0,
                    max: double.parse(threshold),
                    initialValue:
                        (double.parse(value) > double.parse(threshold))
                            ? double.parse(threshold)
                            : double.parse(value),
                    innerWidget: (_) {
                      return Center(
                        child: Container(
                          width: 60.0,
                          height: 50.0,
                          child: Column(
                            children: [
                              Flexible(
                                child: Text(
                                  // (double.parse(value) > double.parse(threshold))
                                  //     ? threshold + "%" :
                                  value.toString() + "%",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w900,
                                    color: ColorsConstant.mainTextColor,
                                  ),
                                ),
                              ),
                              Text(
                                "SOIL",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorsConstant.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  bool isGoodCondition() {
    final val = double.parse(value);
    if (val > 0 && val <= double.parse(threshold))
      return false;
    else if (val > double.parse(threshold)) return true;
    return false;
  }
}
