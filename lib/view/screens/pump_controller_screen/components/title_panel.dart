import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kltn/data/model/PumpModel.dart';

import '../../../../common/constants/colors_constant.dart';
import '../../../widgets/toggle_button.dart';

class TitlePanel extends StatelessWidget {
  final PumpModel pumpModel;

  const TitlePanel({super.key, required this.pumpModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pump is " + (pumpModel.state != "0" ? "ON" : "OFF"),
                style: TextStyle(
                  color: ColorsConstant.mainTextColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 5.0),
              Flexible(
                child: Text(
                  "Tap to turn off or swipe up",
                  style: TextStyle(
                    color: ColorsConstant.lightTextColor,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: -60.0,
            right: -55.0,
            child: ToggleButton(
              child: SvgPicture.asset("assets/svgs/power.svg"),
              isOn: pumpModel.state != "0" ? true : false,
              onTab: (isOn) async {
                DatabaseReference _refControl =
                    FirebaseDatabase.instance.ref("CONTROL");
                await _refControl.update({"State": isOn == true ? "0" : "100"});
              },
            ),
          ),
        ],
      ),
    );
  }
}
