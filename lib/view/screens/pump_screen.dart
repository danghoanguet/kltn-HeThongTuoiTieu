import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/model/PumpModel.dart';
import '../widgets/label_item.dart';

class PumpScreen extends StatefulWidget {
  const PumpScreen({Key? key}) : super(key: key);

  @override
  State<PumpScreen> createState() => _PumpScreenState();
}

class _PumpScreenState extends State<PumpScreen> {
  final _database = FirebaseDatabase.instance.ref();
  bool _isManuel = false;
  bool _isPumpRunning = false;
  double _pumpValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          LabelItem(
            label: "PUMP CONTROLLER",
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
                        Map<String, dynamic>.from(snapshot.data?.snapshot.value
                            as Map<dynamic, dynamic>));
                    _isManuel = _pumpModel.control == "0" ? false : true;
                    _pumpValue = double.parse(_pumpModel.state);
                    _isPumpRunning = _pumpModel.state != "0" ? true : false;
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "MANUAL     ",
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
                              "AUTOMATIC",
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
                                      FirebaseDatabase.instance.ref("CONTROL");
                                  await _refControl.update(
                                      {"State": value.round().toString()});
                                },
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Power: ${_pumpValue.toString()}/100%',
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
                                            "Manual":
                                                _isManuel == false ? "0" : "1",
                                            "State": _isPumpRunning ? "50" : "0"
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
        ],
      ),
    );
  }
}
