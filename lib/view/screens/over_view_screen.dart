import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn/data/model/DHTModel.dart';
import 'package:kltn/data/model/PumpModel.dart';
import 'package:kltn/data/model/threshold_model.dart';

import '../../common/constants/colors_constant.dart';
import '../widgets/header_with_seachbox.dart';
import '../widgets/label_item.dart';
import '../widgets/sensor_water_item.dart';
import '../widgets/water_progess_indicator.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  final _database = FirebaseDatabase.instance.ref();
  final imageBackgroundUrl =
      "https://cdn.pixabay.com/photo/2016/09/05/15/07/concrete-1646788__340.jpg";

  @override
  void initState() {
    // _activateListener();
    super.initState();
  }

  void _activateListener() {
    // _database.child("DHT/Nhiệt độ").onValue.listen((event) {
    //   final String nhietDo = event.snapshot.value.toString();
    //   setState(() {
    //     _nhietDo = nhietDo;
    //   });
    // });
  }

  TextEditingController _nhietDoController = TextEditingController();
  TextEditingController _doAmController = TextEditingController();
  TextEditingController _doAmDatController = TextEditingController();

  @override
  void dispose() {
    _nhietDoController.dispose();
    _doAmController.dispose();
    _doAmDatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageBackgroundUrl),
            fit: BoxFit.cover,
          ),
        ),
        // padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            HeaderWithSearchBox(size: size),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<DatabaseEvent>(
                    stream: _database.child("CONTROL").onValue,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final _pumpModel = PumpModel.fromRTDB(
                            Map<String, dynamic>.from(snapshot.data?.snapshot
                                .value as Map<dynamic, dynamic>));

                        //PUMP ITEM
                        return _buildPumpCard(
                            size: size, pumpModel: _pumpModel);
                      }
                    }),
                Expanded(
                    child: Column(
                  children: [
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
                                Map<String, dynamic>.from(snapshot.data
                                    ?.snapshot.value as Map<dynamic, dynamic>));
                            return _buildSensorCard(
                                size: size, dHTModel: _dHTModel);
                          }
                        }),
                    StreamBuilder<DatabaseEvent>(
                        stream: _database.child("Threshold").onValue,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            final _thresholdModel = ThresholdModel.fromRTDB(
                                Map<String, dynamic>.from(snapshot.data
                                    ?.snapshot.value as Map<dynamic, dynamic>));
                            return _buildThresholdCard(
                                size: size, thresholdModel: _thresholdModel);
                          }
                        }),
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _buildThresholdCard extends StatelessWidget {
  const _buildThresholdCard({
    Key? key,
    required this.size,
    required ThresholdModel thresholdModel,
  })  : _thresholdModel = thresholdModel,
        super(key: key);

  final Size size;
  final ThresholdModel _thresholdModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.height * 0.25,
      // width: size.width * 0.5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: ColorsConstant.kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsConstant.kPrimaryColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ColorsConstant.kPrimaryColor, width: 2),
            ),
            child: Center(
              child: Text(
                "THRESHOLD",
                style: GoogleFonts.aBeeZee(
                  color: ColorsConstant.background2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Card(
              color: ColorsConstant.background2,
              elevation: 1,
              child: Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 10),
                      height: size.width * 0.1,
                      width: size.width * 0.08,
                      child: Image.asset(
                          "assets/images/temperature_threshold.png"),
                    ),
                    Text(
                      "TEMP ",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${_thresholdModel.temp}" + "\u2103",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )),
          Card(
              color: ColorsConstant.background2,
              elevation: 1,
              child: Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 10),
                      height: size.width * 0.1,
                      width: size.width * 0.08,
                      child: Image.asset("assets/images/soil_threshold.png"),
                    ),
                    Text(
                      "SOIL ",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${_thresholdModel.soil}%",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )),
          Card(
              color: ColorsConstant.background2,
              elevation: 1,
              child: Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 10),
                      height: size.width * 0.1,
                      width: size.width * 0.08,
                      child: Image.asset("assets/images/humid_threshold.png"),
                    ),
                    Text(
                      "HUM ",
                      style: GoogleFonts.aBeeZee(
                        color: ColorsConstant.textBlue2,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${_thresholdModel.humid}%",
                      style: GoogleFonts.aBeeZee(
                        color: ColorsConstant.textBlue2,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class _buildSensorCard extends StatelessWidget {
  const _buildSensorCard({
    Key? key,
    required this.size,
    required DHTModel dHTModel,
  })  : _dHTModel = dHTModel,
        super(key: key);

  final Size size;
  final DHTModel _dHTModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.height * 0.4,
      // width: size.width * 0.5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: ColorsConstant.kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsConstant.pinkPrimaryColor,
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: ColorsConstant.pinkPrimaryColor, width: 2),
            ),
            child: Center(
              child: Text(
                "SENSOR",
                style: GoogleFonts.aBeeZee(
                  color: ColorsConstant.background2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Card(
              color: ColorsConstant.background2,
              elevation: 1,
              child: Container(
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5, right: 10),
                        height: size.width * 0.1,
                        width: size.width * 0.08,
                        child:
                            SvgPicture.asset("assets/icons/temperature.svg")),
                    Text(
                      "TEMP ",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${_dHTModel.temp}".split(".")[0] + "\u2103",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )),
          Card(
              color: ColorsConstant.background2,
              elevation: 1,
              child: Container(
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5, right: 10),
                        height: size.width * 0.1,
                        width: size.width * 0.08,
                        child: SvgPicture.asset("assets/icons/soil.svg")),
                    Text(
                      "SOIL ",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${_dHTModel.soil}%",
                      style: GoogleFonts.aBeeZee(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )),
          Card(
              color: ColorsConstant.background2,
              elevation: 1,
              child: Container(
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5, right: 10),
                        height: size.width * 0.1,
                        width: size.width * 0.08,
                        child: SvgPicture.asset("assets/icons/humid.svg")),
                    Text(
                      "HUM ",
                      style: GoogleFonts.aBeeZee(
                        color: ColorsConstant.textBlue2,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${_dHTModel.humid}".split(".")[0] + "%",
                      style: GoogleFonts.aBeeZee(
                        color: ColorsConstant.textBlue2,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class _buildPumpCard extends StatelessWidget {
  const _buildPumpCard({
    Key? key,
    required this.size,
    required PumpModel pumpModel,
  })  : _pumpModel = pumpModel,
        super(key: key);

  final Size size;
  final PumpModel _pumpModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.5,
      width: size.width * 0.5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: ColorsConstant.kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsConstant.blueSecondaryColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: ColorsConstant.blueSecondaryColor, width: 2),
            ),
            child: Center(
              child: Text(
                "PUMP",
                style: GoogleFonts.aBeeZee(
                  color: ColorsConstant.textBlack1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 15, left: 15, bottom: 10, right: 20),
                child: WaterProgressIndicator(
                    size: size.height * 0.4,
                    progress: double.parse(_pumpModel.state) / 100,
                    width: 30,
                    primaryColor: ColorsConstant.bluePrimaryColor,
                    secondaryColor: ColorsConstant.blueSecondaryColor),
              ),
              Column(
                children: [
                  Card(
                    color: ColorsConstant.background2,
                    elevation: 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      width: size.width * 0.25,
                      child: Column(
                        children: [
                          Text(
                            "Capacity",
                            style: GoogleFonts.aBeeZee(
                              color: ColorsConstant.textBlue2,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.water_drop,
                                color: ColorsConstant.textBlue1,
                                size: 40,
                              ),
                              Text(
                                "100%",
                                style: GoogleFonts.aBeeZee(
                                  color: ColorsConstant.textBlue1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: ColorsConstant.background2,
                    elevation: 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      width: size.width * 0.25,
                      child: Column(
                        children: [
                          Text(
                            "Power",
                            style: GoogleFonts.aBeeZee(
                              color: ColorsConstant.textBlue2,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.water_outlined,
                                color: ColorsConstant.textBlue1,
                                size: 40,
                              ),
                              Text(
                                "${_pumpModel.state}%",
                                style: GoogleFonts.aBeeZee(
                                  color: ColorsConstant.textBlue1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: ColorsConstant.background2,
                    elevation: 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      width: size.width * 0.25,
                      child: Column(
                        children: [
                          Text(
                            "Mode",
                            style: GoogleFonts.aBeeZee(
                              color: ColorsConstant.textBlue2,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                size: 40,
                                Icons.heat_pump_outlined,
                                color: ColorsConstant.textBlue1,
                              ),
                              Text(
                                _pumpModel.control == "1" ? "Manual" : "Auto",
                                style: GoogleFonts.aBeeZee(
                                  color: ColorsConstant.textBlue1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
