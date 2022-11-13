import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/view/screens/sensor_screen/components/humid_graph.dart';
import 'package:kltn/view/screens/sensor_screen/sensor_screen_interface.dart';

import '../../../common/constants/colors_constant.dart';
import '../../../data/model/DHTModel.dart';
import 'components/soil_graph.dart';
import 'components/temperature_graph.dart';

class GraphScreen extends StatefulWidget {
  final SensorScreenInterface interface;
  const GraphScreen({Key? key, required this.interface}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final _database = FirebaseDatabase.instance.ref();
  var tempChartData = <LiveData>[];
  var humidChartData = <LiveData>[];
  var soilChartData = <LiveData>[];
  BorderRadius get borderRadius => BorderRadius.circular(20);
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
        "Sensor Graph",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          // vertical: 20,
        ),
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
        child: StreamBuilder<DatabaseEvent>(
            stream: _database.child("DHT").onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final _dHTModel = DHTModel.fromRTDB(Map<String, dynamic>.from(
                    snapshot.data?.snapshot.value as Map<dynamic, dynamic>));
                DateTime now = DateTime.now();
                String formattedDate = DateFormat('kk:mm:ss').format(now);
                tempChartData.add(LiveData(now, double.parse(_dHTModel.temp)));
                humidChartData
                    .add(LiveData(now, double.parse(_dHTModel.humid)));
                soilChartData.add(LiveData(now, double.parse(_dHTModel.soil)));
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          widget.interface.toggleScreen();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          foregroundColor: Colors.white,
                          // side: BorderSide(color: Colors.red, width: 1),
                          shadowColor: Colors.red,
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          elevation: 2,
                        ),
                        child: Text(
                          "Return",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsConstant.white,
                            // fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 300,
                        child: TemperatureGraphItem(
                          chartData: tempChartData,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 300,
                        child: HumidGraphItem(
                          chartData: humidChartData,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 300,
                        child: SoilGraphItem(
                          chartData: soilChartData,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

class LiveData {
  LiveData(this.time, this.data);
  final DateTime time;
  final double data;
}
