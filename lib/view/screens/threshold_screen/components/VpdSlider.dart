import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kltn/data/model/PumpModel.dart';
import 'package:kltn/data/model/threshold_model.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../common/constants/colors_constant.dart';

class VpdSlider extends StatefulWidget {
  final ThresholdModel thresholdModel;
  const VpdSlider({
    Key? key,
    required this.thresholdModel,
  }) : super(key: key);

  @override
  _VpdSliderState createState() => _VpdSliderState();
}

class _VpdSliderState extends State<VpdSlider> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
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
            Radius.circular(360.0),
          ),
        ),
        padding: EdgeInsets.all(10.0),
        child: SleekCircularSlider(
          appearance: CircularSliderAppearance(
            startAngle: 90.0,
            size: 180.0,
            animationEnabled: true,
            customColors: CustomSliderColors(
              progressBarColors: ColorsConstant.progressBarColor,
              gradientStartAngle: 180.0,
              gradientEndAngle: 360.0,
              trackColor: ColorsConstant.progressBarTrackColor,
              dotColor: ColorsConstant.progressBarTrackColor,
            ),
            customWidths: CustomSliderWidths(
              trackWidth: 30.0,
              progressBarWidth: 30.0,
              shadowWidth: 30.0,
            ),
            spinnerMode: false,
            angleRange: 360.0,
          ),
          min: 0.0,
          max: 100.0,
          initialValue: double.parse(widget.thresholdModel.vpdMin),
          // onChange: (double value) {},
          // onChangeEnd: (double value) async {
          //   DatabaseReference _refControl =
          //       FirebaseDatabase.instance.ref("CONTROL");
          //   await _refControl.update({"State": value.round().toString()});
          // },
          innerWidget: (double value) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        value.toInt().toString() + "%",
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w900,
                          color: ColorsConstant.mainTextColor,
                        ),
                      ),
                    ),
                    Text(
                      "Power",
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
    );
  }
}
