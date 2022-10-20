import 'package:flutter/material.dart';
import 'package:gradient_progress_bar/gradient_progress_bar.dart';
import 'package:kltn/common/constants/colors_constant.dart';

class TemperatureBar extends StatelessWidget {
  const TemperatureBar({Key? key, required this.value}) : super(key: key);
  final double value;

  @override
  Widget build(BuildContext context) {
    final listNumber = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
    return Container(
      //height: 20,
      //color: Colors.red,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: listNumber
                    .map((item) => Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Text(
                              item.toString(),
                              style: TextStyle(
                                  color: ColorsConstant.borderTextFieldColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                            Container(
                              width: 2.0,
                              height: 6.0,
                              margin: EdgeInsets.fromLTRB(0, 5.0, 0, 0.0),
                              decoration: BoxDecoration(
                                color: ColorsConstant.borderTextFieldColor,
                                // borderRadius: BorderRadius.all(
                                //   Radius.circular(50.0),
                                // ),
                              ),
                            ),
                          ],
                        ))
                    .toList()),
          ),
          GradientProgressIndicator([
            ColorsConstant.greenSecondaryColor,
            ColorsConstant.greenPrimaryColor,
            ColorsConstant.yellowPrimaryColor,
            ColorsConstant.red,
            ColorsConstant.red,
            Color(0xffF2E0F9),
            Color(0xffDDC5EE),
            Color(0xffCDE8F1),
            Color(0xffF1C358),
            Color(0xffEFDE62),
          ], value),
        ],
      ),
    );
  }
}
