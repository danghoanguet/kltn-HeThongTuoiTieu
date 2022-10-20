import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn/data/model/DHTModel.dart';
import 'package:kltn/data/model/PumpModel.dart';
import 'package:kltn/data/model/threshold_model.dart';

import '../../common/constants/colors_constant.dart';
import '../widgets/humid_card_item.dart';
import '../widgets/header_with_seachbox.dart';
import '../widgets/label_item.dart';
import '../widgets/temperature_card_item.dart';
import '../widgets/sensor_water_item.dart';
import '../widgets/soil_card_item.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({Key? key}) : super(key: key);

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
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
      backgroundColor: ColorsConstant.progressBarTrackColor,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset(
          "assets/images/sensor.png",
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: Text(
        "Sensor Stats",
      ),
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
            children: [
              // HeaderWithSearchBox(size: size),
              Container(
                //height: size.height - AppBar().preferredSize.height,
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  // border:
                  //     Border.all(width: 4, color: ColorsConstant.kPrimaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: StreamBuilder<DatabaseEvent>(
                    stream: _database.child("DHT").onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("${snapshot.data?.snapshot.value.toString()}\n");
                        final _dHTModel = DHTModel.fromRTDB(
                            Map<String, dynamic>.from(snapshot.data?.snapshot
                                .value as Map<dynamic, dynamic>));

                        return StreamBuilder<DatabaseEvent>(
                            stream: _database.child("Threshold").onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final _thresholdModel = ThresholdModel.fromRTDB(
                                    Map<String, dynamic>.from(snapshot
                                        .data
                                        ?.snapshot
                                        .value as Map<dynamic, dynamic>));

                                // return LayoutBuilder(
                                //   builder: (context, constraints) {
                                //     return Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         SensorWaterItem(
                                //             label: "Temperature",
                                //             size: constraints.maxWidth / 3 - 30,
                                //             primaryColor:
                                //                 ColorsConstant.pinkPrimaryColor,
                                //             secondaryColor:
                                //                 ColorsConstant.pinkSecondaryColor,
                                //             textColor: Colors.deepOrange,
                                //             value: (double.parse(
                                //                 _dHTModel.temp.split(".")[0])),
                                //             threshold: double.parse(
                                //                 _thresholdModel.temp)),
                                //         SensorWaterItem(
                                //             label: "Humid",
                                //             size: constraints.maxWidth / 3 - 30,
                                //             primaryColor:
                                //                 ColorsConstant.bluePrimaryColor,
                                //             secondaryColor:
                                //                 ColorsConstant.blueSecondaryColor,
                                //             textColor: Colors.blueAccent,
                                //             value: (double.parse(
                                //                 _dHTModel.humid.split(".")[0])),
                                //             threshold: double.parse(
                                //                 _thresholdModel.humid)),
                                //         SensorWaterItem(
                                //             label: "Soil",
                                //             size: constraints.maxWidth / 3 - 30,
                                //             primaryColor:
                                //                 ColorsConstant.yellowPrimaryColor,
                                //             secondaryColor: ColorsConstant
                                //                 .yellowSecondaryColor,
                                //             textColor: Colors.brown,
                                //             value: (double.parse(
                                //                 _dHTModel.soil.split(".")[0])),
                                //             threshold: double.parse(
                                //                 _thresholdModel.soil)),
                                //       ],
                                //     );
                                //   },
                                // );
                                return Column(
                                  children: [
                                    TemperatureCardItem(
                                      value: _dHTModel.temp,
                                      threshold: _thresholdModel.temp,
                                    ),
                                    SizedBox(height: 20.0),
                                    HumidCardItem(
                                      value: _dHTModel.humid,
                                      threshold: _thresholdModel.humid,
                                    ),
                                    SizedBox(height: 20.0),
                                    SoilCardItem(
                                      value: _dHTModel.soil,
                                      threshold: _thresholdModel.soil,
                                    ),
                                    SizedBox(height: 20.0),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
