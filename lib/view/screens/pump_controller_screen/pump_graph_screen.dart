import 'package:flutter/material.dart';
import 'package:kltn/data/model/pump.dart';
import 'package:kltn/view/screens/pump_controller_screen/pump_graph_interface.dart';

import '../../../common/constants/colors_constant.dart';
import '../../../services/database.dart';
import '../test_chart2.dart';
import '../test_chart5.dart';
import 'components/pump_chart_column.dart';

class PumpGraphScreen extends StatelessWidget {
  final PumpGraphInterface interface;

  final _dbFirestore = FirestoreDatabase(uid: 'LC8T8ufP8mN2SL0DTbLpqSQ3PRG2');

  PumpGraphScreen({super.key, required this.interface});

  @override
  Widget build(BuildContext context) {
    // print("pumpGraphScreen build run");
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
                  ChartData('JAN', jan * 0.116 / 2),
                  ChartData('FEB', feb * 0.116 / 2),
                  ChartData('MAR', mar * 0.116 / 2),
                  ChartData('APR', apr * 0.116 / 2),
                  ChartData('MAY', may * 0.116 / 2),
                  ChartData('JUN', jun * 0.116 / 2),
                  ChartData('JULY', jul * 0.116 / 2),
                  ChartData('AUG', aug * 0.116 / 2),
                  ChartData('SEP', sep * 0.116 / 2),
                  ChartData('OCT', oct * 0.116 / 2),
                  ChartData('NOV', nov * 0.116 / 2),
                  ChartData('DEC', dec * 0.116 / 2),
                ];
                data2 = [
                  ChartData('JAN', jan * 3 / 60 / 2),
                  ChartData('FEB', feb * 3 / 60 / 2),
                  ChartData('MAR', mar * 3 / 60 / 2),
                  ChartData('APR', apr * 3 / 60 / 2),
                  ChartData('MAY', may * 3 / 60 / 2),
                  ChartData('JUN', jun * 3 / 60 / 2),
                  ChartData('JULY', jul * 3 / 60 / 2),
                  ChartData('AUG', aug * 3 / 60 / 2),
                  ChartData('SEP', sep * 3 / 60 / 2),
                  ChartData('OCT', oct * 3 / 60 / 2),
                  ChartData('NOV', nov * 3 / 60 / 2),
                  ChartData('DEC', dec * 3 / 60 / 2),
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
