import 'package:flutter/material.dart';
import 'package:kltn/data/model/pump.dart';
import 'package:kltn/view/screens/pump_controller_screen/pump_graph_interface.dart';

import '../../../common/constants/assets_constant.dart';
import '../../../common/constants/colors_constant.dart';
import '../../../services/database.dart';
import '../test_chart2.dart';
import '../test_chart5.dart';
import 'components/pump_chart_column.dart';

class PumpGraphScreen extends StatelessWidget {
  final PumpGraphInterface interface;

  final _dbFirestore = FirestoreDatabase(uid: AssetsConstant.uid);
  final pumpPower = 0.116;
  final pumpTime = 3;
  PumpGraphScreen({super.key, required this.interface});

  @override
  Widget build(BuildContext context) {
    // print("pumpGraphScreen build run");

    return Scaffold(
      body: Container(
        height: double.infinity,
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
        child: StreamBuilder<List<Pump>>(
            stream: _dbFirestore.pumpsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ChartData> data = [];
                List<ChartData> data2 = [];
                double jan = 0;
                double feb = 0;
                double mar = 0;
                double apr = 0;
                double may = 0;
                double jun = 0;
                double jul = 0;
                double aug = 0;
                double sep = 0;
                double oct = 0;
                double nov = 0;
                double dec = 0;
                snapshot.data?.forEach((pump) {
                  switch (pump.month) {
                    case "1":
                      jan++;
                      break;
                    case "2":
                      feb++;
                      break;
                    case "3":
                      mar++;
                      break;
                    case "4":
                      apr++;
                      break;
                    case "5":
                      may++;
                      break;
                    case '6':
                      jun++;
                      break;
                    case "7":
                      jul++;
                      break;
                    case "8":
                      aug++;
                      break;
                    case "9":
                      sep++;
                      break;
                    case "10":
                      oct++;
                      break;
                    case "11":
                      nov++;
                      break;
                    case "12":
                      dec++;
                      break;
                  }
                });
                data = [
                  ChartData('JAN', jan * pumpPower),
                  ChartData('FEB', feb * pumpPower),
                  ChartData('MAR', mar * pumpPower),
                  ChartData('APR', apr * pumpPower),
                  ChartData('MAY', may * pumpPower),
                  ChartData('JUN', jun * pumpPower),
                  ChartData('JULY', jul * pumpPower),
                  ChartData('AUG', aug * pumpPower),
                  ChartData('SEP', sep * pumpPower),
                  ChartData('OCT', oct * pumpPower),
                  ChartData('NOV', nov * pumpPower),
                  ChartData('DEC', dec * pumpPower),
                ];
                data2 = [
                  ChartData('JAN', jan * pumpTime / 60),
                  ChartData('FEB', feb * pumpTime / 60),
                  ChartData('MAR', mar * pumpTime / 60),
                  ChartData('APR', apr * pumpTime / 60),
                  ChartData('MAY', may * pumpTime / 60),
                  ChartData('JUN', jun * pumpTime / 60),
                  ChartData('JULY', jul * pumpTime / 60),
                  ChartData('AUG', aug * pumpTime / 60),
                  ChartData('SEP', sep * pumpTime / 60),
                  ChartData('OCT', oct * pumpTime / 60),
                  ChartData('NOV', nov * pumpTime / 60),
                  ChartData('DEC', dec * pumpTime / 60),
                ];
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // LineChartSample2(),
                      // LineChartSample5(),
                      Container(
                        height: 500,
                        child: ChartColumn(
                          data: data,
                          data2: data2,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          interface.toggleScreen();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          foregroundColor: Colors.white,
                          // side: BorderSide(color: Colors.red, width: 1),
                          shadowColor: Colors.blue.shade800,
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
