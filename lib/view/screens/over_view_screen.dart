import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn/data/model/DHTModel.dart';
import 'package:kltn/data/model/PumpModel.dart';
import 'package:kltn/data/model/threshold_model.dart';

import '../../common/constants/colors_constant.dart';
import '../../data/model/WifiModel.dart';
import '../widgets/wifi_card.dart';
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

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: ColorsConstant.kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/menu.svg",
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: Text(
        'Hi Hoang!',
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [Image.asset("assets/images/logo.png")],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorsConstant.conBackgroundColor,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWithSearchBox(size: size),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                                  Map<String, dynamic>.from(snapshot
                                      .data
                                      ?.snapshot
                                      .value as Map<dynamic, dynamic>));

                              //PUMP ITEM
                              return _buildPumpCard(
                                  size: size, pumpModel: _pumpModel);
                            }
                          }),
                      StreamBuilder<DatabaseEvent>(
                        stream: _database.child("Wifi").onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data?.snapshot.value);
                            final wifiModel = WifiModel.fromRTDB(
                                Map<String, dynamic>.from(snapshot.data
                                    ?.snapshot.value as Map<dynamic, dynamic>));
                            print("status: ${wifiModel.wifiStatus}\n");
                            return WifiCard(size: size, wifiModel: wifiModel);
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
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
                                  Map<String, dynamic>.from(snapshot
                                      .data
                                      ?.snapshot
                                      .value as Map<dynamic, dynamic>));
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
                                  Map<String, dynamic>.from(snapshot
                                      .data
                                      ?.snapshot
                                      .value as Map<dynamic, dynamic>));
                              return _buildThresholdCard(
                                  size: size, thresholdModel: _thresholdModel);
                            }
                          }),
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
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
      width: size.width * 0.5,
      margin: EdgeInsets.only(right: 15, top: 15),
      padding: EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 3, color: ColorsConstant.kPrimaryColor),
        // image: DecorationImage(
        //   image: AssetImage("assets/images/plant4.jpeg"),
        //   fit: BoxFit.fill,
        // ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: ColorsConstant.kPrimaryColor.withOpacity(0.7),
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
              child: FittedBox(
                child: Text(
                  "THRESHOLD",
                  style: GoogleFonts.adventPro(
                    color: ColorsConstant.background2,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          //TODO:
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
            decoration: BoxDecoration(
                //color: ColorsConstant.background2,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10, top: 5),
                  height: size.width * 0.1,
                  width: size.width * 0.08,
                  child: SvgPicture.asset("assets/icons/icon_2.svg"),
                ),
                Text(
                  "TEMP ",
                  style: GoogleFonts.aBeeZee(
                    color: ColorsConstant.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Flexible(
                  child: Text(
                    "${_thresholdModel.temp}" + "\u2103",
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 5, right: 5),
            decoration: BoxDecoration(
                //color: ColorsConstant.background2,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10, top: 5),
                  height: size.width * 0.1,
                  width: size.width * 0.08,
                  child: SvgPicture.asset("assets/icons/icon_4.svg"),
                ),
                Text(
                  "SOIL ",
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Flexible(
                  child: Text(
                    "${_thresholdModel.soil}%",
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
            decoration: BoxDecoration(
                // color: ColorsConstant.background2,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10, top: 5),
                  height: size.width * 0.1,
                  width: size.width * 0.08,
                  child: SvgPicture.asset("assets/icons/icon_3.svg"),
                ),
                Text(
                  "HUM ",
                  style: GoogleFonts.aBeeZee(
                    color: ColorsConstant.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Flexible(
                  child: Text(
                    "${_thresholdModel.humid}%",
                    style: GoogleFonts.aBeeZee(
                      color: ColorsConstant.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
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
      // height: size.height * 0.3,
      width: size.width * 0.5,

      margin: EdgeInsets.only(
        right: 15,
      ),
      padding: EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 3, color: ColorsConstant.red),
        // image: DecorationImage(
        //   image: AssetImage("assets/images/plant5.jpeg"),
        //   fit: BoxFit.fill,
        // ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: ColorsConstant.red.withOpacity(0.5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsConstant.red,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ColorsConstant.red, width: 2),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  "SENSOR",
                  style: GoogleFonts.adventPro(
                    color: ColorsConstant.background2,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          //TODO:
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
            decoration: BoxDecoration(
                //color: ColorsConstant.background2,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 3, top: 5),
                  height: size.width * 0.1,
                  width: size.width * 0.1,
                  child: SvgPicture.asset(
                    "assets/svgs/temperature.svg",
                    color: Colors.red,
                  ),
                ),
                Text(
                  "TEMP ",
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Flexible(
                  child: Text(
                    "${_dHTModel.temp}".split(".")[0] + "\u2103",
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 5, right: 5),
            decoration: BoxDecoration(
                //color: ColorsConstant.background2,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                    height: size.width * 0.1,
                    width: size.width * 0.08,
                    child: SvgPicture.asset(
                      "assets/icons/soil.svg",
                      color: Colors.red,
                    )),
                Text(
                  "SOIL ",
                  style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Flexible(
                  child: Text(
                    "${_dHTModel.soil}%",
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
            decoration: BoxDecoration(
                //color: ColorsConstant.background2,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                    height: size.width * 0.1,
                    width: size.width * 0.08,
                    child: SvgPicture.asset(
                      "assets/svgs/page_three_dry.svg",
                      color: Colors.red,
                    )),
                Text(
                  "HUM ",
                  style: GoogleFonts.aBeeZee(
                    color: ColorsConstant.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Flexible(
                  child: Text(
                    "${_dHTModel.humid}".split(".")[0] + "%",
                    style: GoogleFonts.aBeeZee(
                      color: ColorsConstant.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
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
      // height: size.height * 0.3,
      width: size.width * 0.5,
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage("assets/images/image_1.png"),
        //   fit: BoxFit.fill,
        // ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 3, color: ColorsConstant.bluePrimaryColor),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: ColorsConstant.bluePrimaryColor.withOpacity(0.7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsConstant.bluePrimaryColor,
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: ColorsConstant.bluePrimaryColor, width: 2),
            ),
            child: Center(
              child: Text(
                "PUMP",
                style: GoogleFonts.adventPro(
                  color: ColorsConstant.background2,
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
                    size: size.height * 0.3,
                    progress: double.parse(_pumpModel.state) / 100,
                    width: 30,
                    primaryColor: ColorsConstant.bluePrimaryColor,
                    secondaryColor: ColorsConstant.blueSecondaryColor),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: size.width * 0.25,
                        child: Column(
                          children: [
                            Text(
                              "Capacity",
                              style: GoogleFonts.aBeeZee(
                                color: ColorsConstant.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.water_drop,
                                  color: ColorsConstant.textBlue1,
                                  size: 40,
                                ),
                                Flexible(
                                  child: Text(
                                    "100%",
                                    style: GoogleFonts.aBeeZee(
                                      color: ColorsConstant.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: size.width * 0.25,
                        child: Column(
                          children: [
                            Text(
                              "Power",
                              style: GoogleFonts.aBeeZee(
                                color: ColorsConstant.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.settings_power_sharp,
                                  color: ColorsConstant.textBlue1,
                                  size: 40,
                                ),
                                Flexible(
                                  child: Text(
                                    "${_pumpModel.state}%",
                                    style: GoogleFonts.aBeeZee(
                                      color: ColorsConstant.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: size.width * 0.25,
                        child: Column(
                          children: [
                            Text(
                              "Mode",
                              style: GoogleFonts.aBeeZee(
                                color: ColorsConstant.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  size: 40,
                                  Icons.flash_on,
                                  color: ColorsConstant.textBlue1,
                                ),
                                Flexible(
                                  child: Text(
                                    _pumpModel.control == "1"
                                        ? "Manual"
                                        : "Auto",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.aBeeZee(
                                      color: ColorsConstant.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: ColorsConstant.kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/menu.svg",
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
