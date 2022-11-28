import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn/data/model/DHTModel.dart';
import 'package:kltn/data/model/PumpModel.dart';
import 'package:kltn/data/model/threshold_model.dart';
import 'package:kltn/view/screens/sensor_screen/sensor_screen_interface.dart';

import '../../../common/constants/colors_constant.dart';
import 'components/humid_card_item.dart';
import '../overview_screen/components/header_with_water_indicator.dart';
import '../../widgets/label_item.dart';
import 'components/temperature_card_item.dart';
import '../../widgets/sensor_water_item.dart';
import 'components/soil_card_item.dart';
import 'graph_screen.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({Key? key}) : super(key: key);

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen>
    implements SensorScreenInterface {
  final _database = FirebaseDatabase.instance.ref();
  final imageBackgroundUrl =
      "https://cdn.pixabay.com/photo/2016/09/05/15/07/concrete-1646788__340.jpg";
  int currentPageIndex = 0;
  @override
  void toggleScreen() {
    updateCurrentIndex();
  }

  void updateCurrentIndex() {
    setState(() {
      currentPageIndex = 0;
    });
  }

  @override
  void initState() {
    // _activateListener();
    super.initState();
  }
  //
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(
  //       "Set new threshold success",
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //           color: ColorsConstant.background,
  //           fontSize: 15,
  //           fontWeight: FontWeight.w500),
  //     ),
  //     duration: Duration(seconds: 2),
  //   ));
  //
  //   super.didChangeDependencies();
  // }

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
    final scaffold = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: buildAppBar(),
      body: IndexedStack(index: currentPageIndex, children: [
        Container(
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
                          // WidgetsBinding.instance.addPostFrameCallback(
                          //     (_) => _onReceiveSensorStats(scaffold));

                          print(
                              "${snapshot.data?.snapshot.value.toString()}\n");
                          final _dHTModel = DHTModel.fromRTDB(
                              Map<String, dynamic>.from(snapshot.data?.snapshot
                                  .value as Map<dynamic, dynamic>));

                          return StreamBuilder<DatabaseEvent>(
                              stream: _database.child("Threshold").onValue,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  // print(
                                  //     "${snapshot.data?.snapshot.value.toString()}\n");
                                  final _thresholdModel =
                                      ThresholdModel.fromRTDB(
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
                                        threshold: _thresholdModel.humid != "0"
                                            ? _thresholdModel.humid
                                            : "1",
                                      ),
                                      SizedBox(height: 20.0),
                                      SoilCardItem(
                                        value: _dHTModel.soil,
                                        threshold: _thresholdModel.soil != "0"
                                            ? _thresholdModel.soil
                                            : "1",
                                      ),
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
                TextButton(
                  onPressed: () {
                    setState(() {
                      currentPageIndex = 1;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(12),
                    foregroundColor: Colors.white,
                    // side: BorderSide(color: Colors.red, width: 1),
                    shadowColor: Colors.red,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    elevation: 2,
                  ),
                  child: Text(
                    "View Graph",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorsConstant.white,
                      // fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
        GraphScreen(
          interface: this,
        ),
      ]),
    );
  }

  void _onReceiveSensorStats(ScaffoldMessengerState scaffold) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    scaffold.showSnackBar(SnackBar(
      content: Text(
        "Updated Sensors Stats",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ColorsConstant.background,
            fontSize: 15,
            fontWeight: FontWeight.w500),
      ),
      duration: Duration(seconds: 2),
    ));
  }
}
