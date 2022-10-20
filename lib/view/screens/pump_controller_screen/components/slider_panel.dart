import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/colors_constant.dart';
import '../../../../data/model/PumpModel.dart';

class SliderPanel extends StatefulWidget {
  final PumpModel pumpModel;

  const SliderPanel({super.key, required this.pumpModel});
  @override
  _SliderPanelState createState() => _SliderPanelState();
}

class _SliderPanelState extends State<SliderPanel> {
  double _currentSliderValue = 3;

  double calculateWidth(Size size) {
    double value = (size.width - 50) * (_currentSliderValue * 2 / 10) - 40;
    return value;
  }

  double calculateWidth2(Size size) {
    double base = 62 - ((_currentSliderValue - 1) * 4.5);

    double value = (size.width - 50) * (_currentSliderValue * 2 / 10) - base;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _pumpValue = double.parse(widget.pumpModel.state);

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Pump Power",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
              color: ColorsConstant.mainTextColor,
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 70.0,
            child: Stack(
              children: [
                SliderNumber(index: 1),
                SliderNumber(index: 2),
                SliderNumber(index: 3),
                SliderNumber(index: 4),
                SliderNumber(index: 5),

                // SliderNumber(index: 6),
                // SliderNumber(index: 7),
                // SliderNumber(index: 8),
                // SliderNumber(index: 9),
                // SliderNumber(index: 10),
                //Progress
                Positioned.fill(
                  child: Image.asset("assets/images/slider_bottom.png"),
                ),
                //Progress filled
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/images/slider_progress.png",
                      fit: BoxFit.fitWidth,
                      height: 4.0,
                      width: calculateWidth(size),
                    ),
                  ),
                ),
                //Dot
                Positioned.fill(
                  child: Container(
                    transform: Matrix4.translationValues(0, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      transform: Matrix4.translationValues(
                          calculateWidth2(size), 0, 0),
                      height: 30.0,
                      width: 30.0,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: -23,
                            right: -23,
                            top: -23,
                            bottom: -23,
                            child: Image.asset("assets/images/slider_dot.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Slider(
                    activeColor: Colors.transparent,
                    inactiveColor: Colors.transparent,
                    value: _currentSliderValue,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: (_currentSliderValue.round() * 20).toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                    onChangeEnd: (value) async {
                      DatabaseReference _refControl =
                          FirebaseDatabase.instance.ref("CONTROL");
                      await _refControl.update({
                        "State": (_currentSliderValue.round() * 20).toString()
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SliderNumber extends StatelessWidget {
  final int index;

  const SliderNumber({Key? key, required this.index}) : super(key: key);

  double calculateWidth2(Size size) {
    double base = 62 - ((index - 1) * 4.5);

    double value = (size.width - 50) * (index * 2 / 10) - base;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned.fill(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        transform: Matrix4.translationValues(calculateWidth2(size), 0, 0),
        width: 30.0,
        height: 30.0,
        child: Text(
          index.toString(),
          style: TextStyle(
            color: ColorsConstant.lightTextColor,
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
