import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/common/constants/colors_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../graph_screen.dart';

class TemperatureGraphItem extends StatefulWidget {
  TemperatureGraphItem({
    Key? key,
    required this.chartData,
  }) : super(key: key);
  final List<LiveData> chartData;
  @override
  _TemperatureGraphItemState createState() => _TemperatureGraphItemState();
}

class _TemperatureGraphItemState extends State<TemperatureGraphItem> {
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
        color: ColorsConstant.pinkSecondaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: SfCartesianChart(
        title: ChartTitle(text: "Temperature data"),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: _tooltipBehavior,
        series: <SplineSeries<LiveData, DateTime>>[
          SplineSeries<LiveData, DateTime>(
              name: "Temperature \u2103",
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
              color: const Color.fromRGBO(192, 108, 132, 1),
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
          title: AxisTitle(text: 'Time'),
          labelStyle: TextStyle(color: Colors.white),
        ),
        primaryYAxis: NumericAxis(
          // numberFormat: NumberFormat("\u2103"),
          //interval: 5,
          // visibleMaximum: 60,
          // visibleMinimum: 0,
          desiredIntervals: 2,
          decimalPlaces: 1,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          labelFormat: '{value}\u2103',
          labelStyle: TextStyle(
            color: ColorsConstant.textPink,
            fontWeight: FontWeight.bold,
          ),
          title: AxisTitle(
              alignment: ChartAlignment.center, text: 'Temperature (\u2103)'),
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
