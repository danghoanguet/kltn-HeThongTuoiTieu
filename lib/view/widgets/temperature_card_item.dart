import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn/view/widgets/temperature_bar.dart';

import '../../common/constants/colors_constant.dart';

class TemperatureCardItem extends StatelessWidget {
  final String value;
  final String threshold;

  const TemperatureCardItem(
      {super.key, required this.value, required this.threshold});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      // height: size.height * 0.2,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Temperature",
                style: TextStyle(
                  color: ColorsConstant.borderTextFieldColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Row(
                children: [
                  Text(
                    isGoodCondition() ? "GOOD" : "NEED COOLDOWN",
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
                      : Icon(
                          Icons.warning,
                          color: Colors.red,
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
                    color: ColorsConstant.red.withOpacity(0.5),
                    width: 2,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: ColorsConstant.borderColors,
                  ),
                ),
                child: Image.asset(
                  "assets/images/temperature.png",
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "${value} ".split(".")[0] + "/${threshold} \u2103",
                style: GoogleFonts.aBeeZee(
                  color: ColorsConstant.borderTextFieldColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TemperatureBar(value: (double.parse(value) / 100)),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool isGoodCondition() {
    final val = double.parse(value);
    if (val > 0 && val < double.parse(threshold))
      return true;
    else if (val > double.parse(threshold)) return false;
    return false;
  }
}
