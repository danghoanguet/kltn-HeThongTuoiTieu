import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kltn/common/constants/colors_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../common/constants/dimens_constant.dart';
import '../graph_screen.dart';

class HumidGraphItem extends StatefulWidget {
  HumidGraphItem({
    Key? key,
    required this.chartData,
  }) : super(key: key);
  final List<LiveData> chartData;
  @override
  _HumidGraphItemState createState() => _HumidGraphItemState();
}

class _HumidGraphItemState extends State<HumidGraphItem> {
  ChartSeriesController? _chartSeriesController;
  final _database = FirebaseDatabase.instance.ref();
  TooltipBehavior _tooltipBehavior =
      TooltipBehavior(enable: true, shouldAlwaysShow: true);
  TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
    // chartData = getChartData();
    // Timer.periodic(const Duration(seconds: 2), updateDataSource);
    _trackballBehavior = TrackballBehavior(
        enable: true,
        lineColor: Colors.white,
        activationMode: ActivationMode.longPress,
        tooltipSettings: const InteractiveTooltip(format: 'point.x : point.y'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ColorsConstant.blueSecondaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: SfCartesianChart(
            title: ChartTitle(text: "Humid data"),
            legend: Legend(isVisible: true, position: LegendPosition.bottom),
            tooltipBehavior: _tooltipBehavior,
            trackballBehavior: _trackballBehavior,
            series: <SplineSeries<LiveData, DateTime>>[
              SplineSeries<LiveData, DateTime>(
                name: "Humid %",
                onRendererCreated: (ChartSeriesController controller) {
                  _chartSeriesController = controller;
                  if (widget.chartData.length == DimensConstant.numberOfX) {
                    widget.chartData.removeAt(0);
                    // _chartSeriesController?.updateDataSource(
                    //     addedDataIndex: widget.chartData.length - 1,
                    //     removedDataIndex: 0);
                  }
                  // _chartSeriesController?.updateDataSource(
                  //     addedDataIndex: widget.chartData.length - 1);
                },
                dataSource: widget.chartData,
                color: ColorsConstant.blueSecondaryColor,
                width: 4,
                xValueMapper: (LiveData data, _) => data.time,
                yValueMapper: (LiveData data, _) => data.data,
                dataLabelSettings: DataLabelSettings(
                  isVisible: false,
                ),
                enableTooltip: true,
                markerSettings:
                    const MarkerSettings(isVisible: true, width: 5, height: 5),
                // animationDuration: 2500,
              )
            ],
            primaryXAxis: DateTimeCategoryAxis(
                majorGridLines: const MajorGridLines(width: 0.7),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 3,
                intervalType: DateTimeIntervalType.minutes,
                labelStyle: TextStyle(color: Colors.white),
                title: AxisTitle(text: 'Time')),
            primaryYAxis: NumericAxis(
                // numberFormat: NumberFormat("\u2103"),
                // visibleMaximum: 100,
                // visibleMinimum: 0,
                desiredIntervals: 2,
                decimalPlaces: 1,
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
                labelFormat: '{value}%',
                labelStyle: TextStyle(
                  color: ColorsConstant.btnGradientEnd1.withOpacity(1),
                  fontWeight: FontWeight.bold,
                ),
                title: AxisTitle(
                    alignment: ChartAlignment.center, text: 'Humid (%)'))));
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
