import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kltn/view/screens/threshold_screen/components/warning_item.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../common/constants/colors_constant.dart';
import '../../../data/model/DHTModel.dart';
import '../../../data/model/threshold_model.dart';
import '../../widgets/label_item.dart';
import '../../widgets/show_alert_dialog.dart';
import 'components/set_vpd_item.dart';

class ThresholdScreen extends StatefulWidget {
  const ThresholdScreen({Key? key}) : super(key: key);

  @override
  State<ThresholdScreen> createState() => _ThresholdScreenState();
}

class _ThresholdScreenState extends State<ThresholdScreen> {
  final _database = FirebaseDatabase.instance.ref();
  bool _isValidate = false;
  Color? vpdColor = Colors.transparent;
  String? vpdStatus = "";

  TextEditingController _vpdMinController = TextEditingController();
  TextEditingController _vpdMaxController = TextEditingController();
  TextEditingController _doAmDatController = TextEditingController();
  double calculateVPD(double temp, double rh) {
    return ((610.7 * pow(10, (7.5 * temp / (237.3 + temp)))) /
        1000 *
        (1 - rh / 100));
  }

  @override
  void dispose() {
    _vpdMinController.dispose();
    _vpdMaxController.dispose();
    _doAmDatController.dispose();
    super.dispose();
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: ColorsConstant.progressBarTrackColor,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset(
          "assets/images/threshold.png",
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: Text(
        "Set Threshold",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    RangeValues _currentRangeValues = const RangeValues(0, 5);
    SfRangeValues _values = SfRangeValues(40.0, 80.0);

    Size size = MediaQuery.of(context).size;
    final scaffold = ScaffoldMessenger.of(context);
    // print("threshold build run");
    return StreamBuilder<DatabaseEvent>(
        stream: _database.child("Threshold").onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final _thresholdModel = ThresholdModel.fromRTDB(
                Map<String, dynamic>.from(
                    snapshot.data?.snapshot.value as Map<dynamic, dynamic>));
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                appBar: buildAppBar(),
                body: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        // topRight: Radius.circular(50.0),
                        // topLeft: Radius.circular(50.0),
                        ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: ColorsConstant.borderColors,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // WarningItem(),
                        SizedBox(
                          height: 20,
                        ),
                        LabelItem(
                          label: "SET THRESHOLD",
                          imageUrl: "assets/images/stat.png",
                          color: ColorsConstant.kPrimaryColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SetVPDItem(
                          temp: _thresholdModel.temp,
                          humid: _thresholdModel.humid,
                          max: _thresholdModel.vpdMax.toString(),
                          soil: _thresholdModel.soil,
                          min: _thresholdModel.vpdMin.toString(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // SfRangeSlider(
                        //   min: 0.0,
                        //   max: 100.0,
                        //   values: _values,
                        //   interval: 20,
                        //   showTicks: true,
                        //   showLabels: true,
                        //   enableTooltip: true,
                        //   minorTicksPerInterval: 1,
                        //   onChanged: (SfRangeValues values) {
                        //     setState(() {
                        //       _values = values;
                        //     });
                        //   },
                        // ),
                        // RangeSlider(
                        //   values: _currentRangeValues,
                        //   min: 0,
                        //   max: 6,
                        //   divisions: 5,
                        //   labels: RangeLabels(
                        //     _currentRangeValues.start.round().toString(),
                        //     _currentRangeValues.end.round().toString(),
                        //   ),
                        //   onChanged: (RangeValues values) {
                        //     setState(() {
                        //       _currentRangeValues = values;
                        //     });
                        //   },
                        // ),
                        // TODO: Delete
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (_) => isValidated(),
                            controller: _vpdMinController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                // hintText: 'Temperature(\u2103)',
                                // hintStyle: TextStyle(
                                //   color: Colors.white,
                                //   fontWeight: FontWeight.bold,
                                //   //fontSize: 20,
                                // ),
                                labelText: 'VPD Min',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 20,
                                ),
                                filled: true,
                                fillColor:
                                    ColorsConstant.gray1.withOpacity(0.5),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          ColorsConstant.red.withOpacity(0.8),
                                      width: 3.0),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorsConstant.red, width: 3.0),
                                ),
                                contentPadding: EdgeInsets.all(20)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (_) => isValidated(),
                            controller: _vpdMaxController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                labelText: 'VPD Max',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 20,
                                ),
                                filled: true,
                                fillColor:
                                    ColorsConstant.gray1.withOpacity(0.5),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorsConstant.bluePrimaryColor
                                          .withOpacity(0.8),
                                      width: 3.0),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorsConstant.bluePrimaryColor,
                                      width: 3.0),
                                ),
                                contentPadding: EdgeInsets.all(20)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //TODO:end
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (_) => isValidated(),
                            onEditingComplete: () => _onSave(scaffold),
                            controller: _doAmDatController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                labelText: 'SOIL',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  //fontSize: 20,
                                ),
                                filled: true,
                                fillColor:
                                    ColorsConstant.gray1.withOpacity(0.5),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.brown.withOpacity(0.8),
                                      width: 3.0),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.brown, width: 3.0),
                                ),
                                contentPadding: EdgeInsets.all(20)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: _isValidate == true
                              ? () => _onSave(scaffold)
                              : null,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(12.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              backgroundColor: ColorsConstant.kPrimaryColor),
                          child: Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<DatabaseEvent>(
                            stream: _database.child("DHT").onValue,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                print(
                                    "${snapshot.data?.snapshot.value.toString()}\n");

                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                final _dHTModel = DHTModel.fromRTDB(
                                    Map<String, dynamic>.from(snapshot
                                        .data
                                        ?.snapshot
                                        .value as Map<dynamic, dynamic>));
                                final vpd = calculateVPD(
                                    double.parse(_dHTModel.temp),
                                    double.parse(_dHTModel.humid));
                                if (double.parse(_thresholdModel.vpdMin) <=
                                        vpd &&
                                    vpd <=
                                        double.parse(_thresholdModel.vpdMax)) {
                                  vpdColor = Colors.green;
                                  vpdStatus = "Vegetative";
                                  // } else if (vpd > 1 && vpd <= 1.24) {
                                  //   vpdColor = Colors.yellowAccent.shade700;
                                  //   vpdStatus = "Flowering";
                                } else if (vpd >
                                    double.parse(_thresholdModel.vpdMax)) {
                                  vpdColor = Colors.deepPurpleAccent;
                                  vpdStatus = "Dry/Stress";
                                } else {
                                  vpdColor = Colors.blueAccent.shade200;
                                  vpdStatus = "Humid";
                                }
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: vpdColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "VPD: ${vpd.toStringAsFixed(2)}(kPa)",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Status: " + vpdStatus!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                );
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   width: double.infinity,
                        //   // height: size.height * 0.2,
                        //   padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        //   decoration: BoxDecoration(
                        //     boxShadow: [
                        //       BoxShadow(
                        //         offset: Offset(20.0, 20.0),
                        //         color: ColorsConstant.progressShadowColor,
                        //         blurRadius: 70.0,
                        //       ),
                        //       BoxShadow(
                        //         offset: Offset(-20.0, -20.0),
                        //         color: ColorsConstant.progressShadowColor2,
                        //         blurRadius: 70.0,
                        //       ),
                        //     ],
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //       colors: ColorsConstant.progressBarBackground,
                        //     ),
                        //     borderRadius: BorderRadius.all(
                        //       Radius.circular(20.0),
                        //     ),
                        //   ),
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Icon(
                        //             Icons.warning,
                        //             color: ColorsConstant.yellowPrimaryColor,
                        //             size: 30,
                        //           ),
                        //           SizedBox(
                        //             width: 15,
                        //           ),
                        //           Text(
                        //             "Warning",
                        //             style: TextStyle(
                        //               color: ColorsConstant.borderTextFieldColor,
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 20,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 20,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Container(
                        //             padding: EdgeInsets.only(
                        //               top: 5,
                        //               bottom: 5,
                        //             ),
                        //             height: size.width * 0.12,
                        //             width: size.width * 0.12,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(12),
                        //               border: Border.all(
                        //                 color: ColorsConstant.red.withOpacity(0.5),
                        //                 width: 2,
                        //               ),
                        //               gradient: LinearGradient(
                        //                 begin: Alignment.topCenter,
                        //                 end: Alignment.bottomCenter,
                        //                 colors: ColorsConstant.borderColors,
                        //               ),
                        //             ),
                        //             child: Image.asset(
                        //               "assets/images/temperature.png",
                        //               color: Colors.white,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 15,
                        //           ),
                        //           Flexible(
                        //             child: Text(
                        //               "When temperature reach or greater than temperature threshold, plant need watering (\u2103)",
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: ColorsConstant.borderTextFieldColor,
                        //                 fontWeight: FontWeight.w500,
                        //                 fontSize: 15,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 20,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Container(
                        //             padding: EdgeInsets.only(
                        //               top: 5,
                        //               bottom: 5,
                        //             ),
                        //             height: size.width * 0.12,
                        //             width: size.width * 0.12,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(12),
                        //               border: Border.all(
                        //                 color: ColorsConstant.bluePrimaryColor
                        //                     .withOpacity(0.5),
                        //                 width: 2,
                        //               ),
                        //               gradient: LinearGradient(
                        //                 begin: Alignment.topCenter,
                        //                 end: Alignment.bottomCenter,
                        //                 colors: ColorsConstant.borderColors,
                        //               ),
                        //             ),
                        //             child: Image.asset(
                        //               "assets/images/water.png",
                        //               color: Colors.white,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 15,
                        //           ),
                        //           Flexible(
                        //             child: Text(
                        //               "When humid % smaller or equal than humid threshold %, plant need watering",
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: ColorsConstant.borderTextFieldColor,
                        //                 fontWeight: FontWeight.w500,
                        //                 fontSize: 15,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 20,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Container(
                        //             padding: EdgeInsets.only(
                        //               top: 5,
                        //               bottom: 5,
                        //             ),
                        //             height: size.width * 0.12,
                        //             width: size.width * 0.12,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(12),
                        //               border: Border.all(
                        //                 color: Colors.brown.withOpacity(0.9),
                        //                 width: 2,
                        //               ),
                        //               gradient: LinearGradient(
                        //                 begin: Alignment.topCenter,
                        //                 end: Alignment.bottomCenter,
                        //                 colors: ColorsConstant.borderColors,
                        //               ),
                        //             ),
                        //             child: Image.asset(
                        //               "assets/images/soil_threshold.png",
                        //               color: Colors.white,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 15,
                        //           ),
                        //           Flexible(
                        //             child: Text(
                        //               "When soil % smaller or equal than soil threshold %, plant need watering",
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: ColorsConstant.borderTextFieldColor,
                        //                 fontWeight: FontWeight.w500,
                        //                 fontSize: 15,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 20,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }

  void _onSave(ScaffoldMessengerState scaffold) async {
    print(
        "${_vpdMinController.text == "" ? 0 : _vpdMinController.text}\n${_vpdMaxController.text == "" ? 0 : _vpdMaxController.text}\n${_doAmDatController.text == "" ? 0 : _doAmDatController.text}\n");
    if (await showAlertDialog(context,
            title: 'Are you sure?',
            content:
                'Vpd Min: ${_vpdMinController.text.toString()}(kPa)\nVPD Max: ${_vpdMaxController.text.toString()}(kPa)\nSoil threshold: ${_doAmDatController.text.toString()}%',
            defaultActionText: 'OK',
            cancelActionText: "NO") ==
        true) {
      DatabaseReference _refThreshold =
          FirebaseDatabase.instance.ref("Threshold");
      String vpdMaxFixed = _vpdMaxController.text.replaceFirst(",", ".");
      String vpdMinFixed = _vpdMinController.text.replaceFirst(",", ".");

      await _refThreshold.update({
        "vpdMax": vpdMaxFixed,
        "vpdMin": vpdMinFixed,
        "SOIL": _doAmDatController.text == "0" ||
                int.parse(_doAmDatController.text) == 0
            ? "1"
            : _doAmDatController.text.toString()
      });
      setState(() {
        _vpdMinController.clear();
        _doAmDatController.clear();
        _vpdMaxController.clear();
        _isValidate = false;
      });
      scaffold.showSnackBar(SnackBar(
        content: Text(
          "Set new threshold success",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ColorsConstant.background,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        duration: Duration(seconds: 2),
      ));
    } else {
      setState(() {
        _vpdMinController.clear();
        _doAmDatController.clear();
        _vpdMaxController.clear();
        _isValidate = false;
      });
    }
    FocusScope.of(context).unfocus();
  }

  void isValidated() {
    setState(() {
      _isValidate = _vpdMinController.text.isNotEmpty &&
          _vpdMaxController.text.isNotEmpty &&
          _doAmDatController.text.isNotEmpty;
    });
  }
}
