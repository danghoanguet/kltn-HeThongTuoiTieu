import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/common/constants/colors_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../graph_screen.dart';

class SoilGraphItem extends StatefulWidget {
  SoilGraphItem({
    Key? key,
    required this.chartData,
  }) : super(key: key);
  final List<LiveData> chartData;
  @override
  _SoilGraphItemState createState() => _SoilGraphItemState();
}

class _SoilGraphItemState extends State<SoilGraphItem> {
  ChartSeriesController? _chartSeriesController;
  final _database = FirebaseDatabase.instance.ref();
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  void initState() {
    // chartData = getChartData();
    // Timer.periodic(const Duration(seconds: 2), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(139, 69, 19, 1).withOpacity(0.3),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: SfCartesianChart(
        title: ChartTitle(
            text: "Soil data",
            textStyle: TextStyle(
              color: Colors.white,
            )),
        legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            textStyle: TextStyle(
              color: Colors.white,
            )),
        tooltipBehavior: _tooltipBehavior,
        series: <SplineSeries<LiveData, DateTime>>[
          SplineSeries<LiveData, DateTime>(
              name: "Soil %",
              onRendererCreated: (ChartSeriesController controller) {
                _chartSeriesController = controller;
                if (widget.chartData.length == 15) {
                  widget.chartData.removeAt(0);
                  // _chartSeriesController?.updateDataSource(
                  //     addedDataIndex: widget.chartData.length - 1,
                  //     removedDataIndex: 0);
                }
                // _chartSeriesController?.updateDataSource(
                //     addedDataIndex: widget.chartData.length - 1);
              },
              dataSource: widget.chartData,
              color: Colors.red,
              width: 3,
              xValueMapper: (LiveData data, _) => data.time,
              yValueMapper: (LiveData data, _) => data.data,
              dataLabelSettings: DataLabelSettings(
                isVisible: false,
              ),
              enableTooltip: true)
        ],
        primaryXAxis: DateTimeCategoryAxis(
          majorGridLines: const MajorGridLines(width: 0.7),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 3,
          intervalType: DateTimeIntervalType.minutes,
          labelStyle: TextStyle(color: Colors.white),
          title: AxisTitle(
            text: 'Time',
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        primaryYAxis: NumericAxis(
          // numberFormat: NumberFormat("\u2103"),
          labelFormat: '{value}%',
          labelStyle: TextStyle(
            color: Color.fromRGBO(220, 177, 144, 1).withOpacity(1),
            fontWeight: FontWeight.bold,
          ),
          // visibleMaximum: 100,
          // visibleMinimum: 0,
          desiredIntervals: 2,
          decimalPlaces: 1,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          title: AxisTitle(
              alignment: ChartAlignment.center,
              text: 'Soil (%)',
              textStyle: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

// int time = 0;
// void updateDataSource(Timer timer) async {
//   final ref = FirebaseDatabase.instance.ref();
//   final snapshot = await ref.child('DHT').get();
//   if (snapshot.exists) {
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('kk:mm').format(now);
//     //chartData.add(LiveData(formattedDate, snapshot.value));
//     if (chartData.length == 15) {
//       chartData.removeAt(0);
//       _chartSeriesController?.updateDataSource(
//           addedDataIndex: chartData.length - 1, removedDataIndex: 0);
//     }
//     _chartSeriesController?.updateDataSource(
//         addedDataIndex: chartData.length - 1);
//     print("data: ${snapshot.value.toString()}");
//   } else {
//     print('No data available.');
//   }
// }

}
