import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn/data/model/DHTModel.dart';
import 'package:kltn/data/model/PumpModel.dart';
import 'package:kltn/data/model/threshold_model.dart';

import '../../common/constants/colors_constant.dart';
import '../widgets/label_item.dart';
import '../widgets/sensor_water_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _database = FirebaseDatabase.instance.ref();
  final imageBackgroundUrl =
      "https://cdn.pixabay.com/photo/2016/09/05/15/07/concrete-1646788__340.jpg";
  String _nhietDo = "0";
  String _doAM = "0";
  String _doAmDat = "0";
  bool _isManuel = false;
  bool _isPumpRunning = false;

  String _wifiStatus = "Disconnected";
  String _ipAddress = "";
  String _wifiName = "";
  String _wifiPassword = "";

  double _pumpValue = 0;
  double _pumpInitalValue = 0;

  bool _isValidate = false;

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
    // _database.child("DHT/Độ ẩm").onValue.listen((event) {
    //   final String doAm = event.snapshot.value.toString();
    //   setState(() {
    //     _doAM = doAm;
    //   });
    // });
    // _database.child("DHT/Độ ẩm đất").onValue.listen((event) {
    //   final String doAmDat = event.snapshot.value.toString();
    //   setState(() {
    //     _doAmDat = doAmDat;
    //   });
    // });
    // _database.child("CONTROL/Manual").onValue.listen((event) {
    //   final String isManuel = event.snapshot.value.toString();
    //   setState(() {
    //     _isManuel = isManuel == "0" ? false : true;
    //   });
    // });
    // _database.child("Wifi/Status").onValue.listen((event) {
    //   final String wifiStatus = event.snapshot.value.toString();
    //   setState(() {
    //     _wifiStatus = wifiStatus;
    //   });
    // });
    // _database.child("Wifi/IP").onValue.listen((event) {
    //   final String ipAddress = event.snapshot.value.toString();
    //   setState(() {
    //     _ipAddress = ipAddress;
    //   });
    // });
    // _database.child("Wifi/Name").onValue.listen((event) {
    //   final String wifiName = event.snapshot.value.toString();
    //   setState(() {
    //     _wifiName = wifiName;
    //   });
    // });
    // _database.child("Wifi/Password").onValue.listen((event) {
    //   final String wifiPassword = event.snapshot.value.toString();
    //   setState(() {
    //     _wifiPassword = wifiPassword;
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
    return SingleChildScrollView(
      child: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage(imageBackgroundUrl),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            LabelItem(
                label: "TRẠNG THÁI MÔI TRƯỜNG",
                imageUrl: "assets/images/plane.png"),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.lightGreen),
                borderRadius: BorderRadius.circular(12),
              ),
              child: StreamBuilder<DatabaseEvent>(
                  stream: _database.child("DHT").onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("${snapshot.data?.snapshot.value.toString()}\n");
                      final _dHTModel = DHTModel.fromRTDB(
                          Map<String, dynamic>.from(snapshot
                              .data?.snapshot.value as Map<dynamic, dynamic>));

                      return StreamBuilder<DatabaseEvent>(
                          stream: _database.child("Threshold").onValue,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final _thresholdModel = ThresholdModel.fromRTDB(
                                  Map<String, dynamic>.from(snapshot
                                      .data
                                      ?.snapshot
                                      .value as Map<dynamic, dynamic>));

                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SensorWaterItem(
                                          label: "Nhiệt độ",
                                          size: constraints.maxWidth / 3 - 30,
                                          primaryColor:
                                              ColorsConstant.pinkPrimaryColor,
                                          secondaryColor:
                                              ColorsConstant.pinkSecondaryColor,
                                          textColor: Colors.deepOrange,
                                          value: (double.parse(
                                              _dHTModel.temp.split(".")[0])),
                                          threshold: double.parse(
                                              _thresholdModel.temp)),
                                      SensorWaterItem(
                                          label: "Độ ẩm",
                                          size: constraints.maxWidth / 3 - 30,
                                          primaryColor:
                                              ColorsConstant.bluePrimaryColor,
                                          secondaryColor:
                                              ColorsConstant.blueSecondaryColor,
                                          textColor: Colors.blueAccent,
                                          value: (double.parse(
                                              _dHTModel.humid.split(".")[0])),
                                          threshold: double.parse(
                                              _thresholdModel.humid)),
                                      SensorWaterItem(
                                          label: "Độ ẩm đất",
                                          size: constraints.maxWidth / 3 - 30,
                                          primaryColor:
                                              ColorsConstant.yellowPrimaryColor,
                                          secondaryColor: ColorsConstant
                                              .yellowSecondaryColor,
                                          textColor: Colors.brown,
                                          value: (double.parse(
                                              _dHTModel.soil.split(".")[0])),
                                          threshold: double.parse(
                                              _thresholdModel.soil)),
                                    ],
                                  );
                                },
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
            SizedBox(
              height: 40,
            ),
            LabelItem(
              label: "ĐIỀU KHIỂN BƠM NƯỚC",
              imageUrl: "assets/images/pump.png",
              color: Colors.blueAccent,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
              ),
              child: StreamBuilder<DatabaseEvent>(
                  stream: _database.child("CONTROL").onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final _pumpModel = PumpModel.fromRTDB(
                          Map<String, dynamic>.from(snapshot
                              .data?.snapshot.value as Map<dynamic, dynamic>));
                      _isManuel = _pumpModel.control == "0" ? false : true;
                      _pumpValue = double.parse(_pumpModel.state);
                      _isPumpRunning = _pumpModel.state != "0" ? true : false;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                " BƠM THỦ CÔNG",
                                style: GoogleFonts.slabo13px(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Switch(
                                // This bool value toggles the switch.
                                value: _isManuel,
                                activeColor: Colors.blue,
                                onChanged: (bool value) async {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    _isManuel = value;
                                    print("isManuel: $_isManuel\n");
                                  });
                                  DatabaseReference _refControl =
                                      FirebaseDatabase.instance.ref("CONTROL");
                                  await _refControl.set({
                                    "Manual": _isManuel == false ? "0" : "1",
                                    "State": "0"
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "BƠM TỰ ĐỘNG",
                                style: GoogleFonts.slabo13px(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Switch(
                                // This bool value toggles the switch.
                                value: !_isManuel,
                                activeColor: Colors.blue,
                                onChanged: (bool value) async {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    _isManuel = !value;
                                    print("isManuel: $_isManuel\n");
                                  });
                                  DatabaseReference _refControl =
                                      FirebaseDatabase.instance.ref("CONTROL");
                                  await _refControl.update({
                                    "Manual": _isManuel == false ? "0" : "1",
                                    "State": "0"
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_pumpModel.control == "1")
                                Slider(
                                  min: 0.0,
                                  max: 100.0,
                                  divisions: 10,
                                  value: _pumpValue,
                                  label: "${_pumpValue.toString()}",
                                  onChanged: (value) {
                                    setState(() {
                                      _pumpValue = value;
                                      print("_pumpValue: $_pumpValue");
                                    });
                                  },
                                  onChangeEnd: (value) async {
                                    if (value != 0.0)
                                      setState(() {
                                        _isPumpRunning = true;
                                      });
                                    else
                                      setState(() {
                                        _isPumpRunning = false;
                                      });
                                    DatabaseReference _refControl =
                                        FirebaseDatabase.instance
                                            .ref("CONTROL");
                                    await _refControl.update(
                                        {"State": value.round().toString()});
                                  },
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Công suất: ${_pumpValue.toString()}/100%',
                                    style: GoogleFonts.slabo13px(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  // if (_pumpModel.control == "1")

                                  Switch(
                                    // This bool value toggles the switch.
                                    value: _isPumpRunning,
                                    activeColor: Colors.blue,
                                    onChanged: _pumpModel.control == "1"
                                        ? (bool value) async {
                                            // This is called when the user toggles the switch.
                                            setState(() {
                                              _isPumpRunning = value;
                                              print(
                                                  "_isPumpRunning: $_isPumpRunning\n");
                                            });
                                            DatabaseReference _refControl =
                                                FirebaseDatabase.instance
                                                    .ref("CONTROL");
                                            await _refControl.set({
                                              "Manual": _isManuel == false
                                                  ? "0"
                                                  : "1",
                                              "State":
                                                  _isPumpRunning ? "50" : "0"
                                            });
                                          }
                                        : (bool value) {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            SizedBox(
              height: 40,
            ),
            LabelItem(
              label: "ĐẶT ĐIỀU KIỆN TƯỚI",
              imageUrl: "assets/images/stat.png",
              color: Colors.redAccent,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: TextField(
                onChanged: (_) => isValidated(),
                controller: _nhietDoController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 3, color: Colors.deepOrange),
                  ),
                  labelText: 'NHIỆT ĐỘ',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: TextField(
                onChanged: (_) => isValidated(),
                controller: _doAmController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 3, color: Colors.lightBlue),
                  ),
                  labelText: 'ĐỘ ẨM',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: TextField(
                onChanged: (_) => isValidated(),
                onEditingComplete: _onSave,
                controller: _doAmDatController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 3, color: Colors.brown),
                  ),
                  labelText: 'ĐỘ ẨM ĐẤT',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _isValidate == true ? _onSave : null,
                child: Text("LƯU")),
          ],
        ),
      ),
    );
  }

  void _onSave() async {
    print(
        "${_nhietDoController.text == "" ? 0 : _nhietDoController.text}\n${_doAmController.text == "" ? 0 : _doAmController.text}\n${_doAmDatController.text == "" ? 0 : _doAmDatController.text}\n$_isManuel\n");

    DatabaseReference _refThreshold =
        FirebaseDatabase.instance.ref("Threshold");
    await _refThreshold.set({
      "HUM": _doAmController.text == "0" || int.parse(_doAmController.text) == 0
          ? "1"
          : _doAmController.text.toString(),
      "TEMP": _nhietDoController.text == "0" ||
              int.parse(_nhietDoController.text) == 0
          ? "1"
          : _nhietDoController.text.toString(),
      "SOIL": _doAmDatController.text == "0" ||
              int.parse(_doAmDatController.text) == 0
          ? "1"
          : _doAmDatController.text.toString()
    });
    setState(() {
      _nhietDoController.clear();
      _doAmDatController.clear();
      _doAmController.clear();
      _isValidate = false;
    });
  }

  void isValidated() {
    setState(() {
      _isValidate = _nhietDoController.text.isNotEmpty &&
          _doAmController.text.isNotEmpty &&
          _doAmDatController.text.isNotEmpty;
    });
  }
}
