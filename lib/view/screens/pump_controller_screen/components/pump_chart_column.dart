import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../common/constants/colors_constant.dart';

class ChartColumn extends StatefulWidget {
  final List<ChartData> data;
  final List<ChartData> data2;
  ChartColumn({Key? key, required this.data, required this.data2})
      : super(key: key);

  @override
  _ChartColumnState createState() => _ChartColumnState();
}

class _ChartColumnState extends State<ChartColumn> {
  late List<ChartData> data1;
  late List<ChartData> data2;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    // data1 = [
    //   ChartData('JAN', 0),
    //   ChartData('FEB', 0),
    //   ChartData('MAR', 0),
    //   ChartData('APR', 0),
    //   ChartData('MAY', 0),
    //   ChartData('JUN', 0),
    //   ChartData('JULY', 0),
    //   ChartData('AUG', 0),
    //   ChartData('SEP', 0),
    //   ChartData('OCT', 1.5),
    //   ChartData('NOV', 1),
    //   ChartData('DEC', 0),
    // ];
    // data2 = [
    //   ChartData('JAN', 10),
    //   ChartData('FEB', 20),
    //   ChartData('MAR', 30),
    //   ChartData('APR', 15),
    //   ChartData('MAY', 22),
    //   ChartData('JUN', 35),
    //   ChartData('JULY', 5),
    //   ChartData('AUG', 12),
    //   ChartData('SEP', 18),
    //   ChartData('OCT', 20),
    //   ChartData('NOV', 4),
    //   ChartData('DEC', 32),
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        enableSideBySideSeriesPlacement: false,
        title: ChartTitle(
          text: "Pump Status",
          textStyle: TextStyle(color: ColorsConstant.blueSecondaryColor),
        ),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          textStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        tooltipBehavior: _tooltip,
        series: <ColumnSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
            width: 0.5,
            borderRadius: BorderRadius.circular(10),
            dataSource: widget.data,
            enableTooltip: true,
            name: 'Water(L)',
            dataLabelSettings: DataLabelSettings(
              isVisible: false,
            ),
            color: Color.fromRGBO(8, 142, 255, 1),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
          ColumnSeries<ChartData, String>(
            borderRadius: BorderRadius.circular(10),
            width: 0.3,
            dataSource: widget.data2,
            enableTooltip: true,
            name: 'Time (Minutes)',
            dataLabelSettings: DataLabelSettings(
              isVisible: false,
            ),
            color: Colors.red,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
        ],
        primaryXAxis: CategoryAxis(
          labelStyle: TextStyle(color: Colors.white),
        ),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          labelFormat: '{value}',
          labelStyle: TextStyle(
            color: ColorsConstant.bluePrimaryColor,
            fontWeight: FontWeight.bold,
          ),
          // title: AxisTitle(
          //     alignment: ChartAlignment.center,
          //     text: 'Water capacity (L)',
          //     textStyle: TextStyle(color: Colors.white)),
          // minimum: 0,
          // maximum: 40,
          //interval: 10,
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
