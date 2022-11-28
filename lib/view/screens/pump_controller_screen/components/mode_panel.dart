import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kltn/data/model/PumpModel.dart';

import '../../../../common/constants/colors_constant.dart';
import '../../../widgets/toggle_button.dart';
import 'mode_option.dart';

class ModePanel extends StatelessWidget {
  final PumpModel pumpModel;
  const ModePanel({
    Key? key,
    required this.pumpModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isManual = pumpModel.control == "1" ? true : false;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      margin: EdgeInsets.only(top: 10),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Mode",
            style: TextStyle(
              color: ColorsConstant.mainTextColor,
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ModeOption(
                name: "Auto",
                icon: Text(
                  "A",
                  style: TextStyle(
                    color: pumpModel.control == "1"
                        ? ColorsConstant.lightTextColor
                        : ColorsConstant.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  ),
                ),
                onTab: isManual == true
                    ? (isManual) async {
                        DatabaseReference _refControl =
                            FirebaseDatabase.instance.ref("CONTROL");
                        await _refControl.update({"Manual": "0", "State": "0"});
                      }
                    : (isManual) {},
                isOn: pumpModel.control != "1" ? true : false,
              ),
              ModeOption(
                name: "Manual",
                icon: Text(
                  "M",
                  style: TextStyle(
                    color: pumpModel.control == "0"
                        ? ColorsConstant.lightTextColor
                        : ColorsConstant.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  ),
                ),
                onTab: isManual == false
                    ? (isManual) async {
                        DatabaseReference _refControl =
                            FirebaseDatabase.instance.ref("CONTROL");
                        await _refControl.update({"Manual": "1", "State": "0"});
                      }
                    : (isManual) {},
                isOn: pumpModel.control == "1" ? true : false,
              ),
              // ModeOption(
              //   name: "Cool",
              //   icon: SvgPicture.asset("assets/svgs/page_three_cool.svg"),
              // ),
              // ModeOption(
              //   name: "Program",
              //   icon: SvgPicture.asset("assets/svgs/page_three_program.svg"),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
