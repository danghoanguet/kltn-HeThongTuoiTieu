import 'package:flutter/material.dart';
import 'package:kltn/common/constants/colors_constant.dart';
import 'package:kltn/view/widgets/water_progess_indicator.dart';

class SensorWaterItem extends StatelessWidget {
  final String label;
  final Color primaryColor;
  final Color secondaryColor;
  final Color textColor;
  final double size;
  final double value;
  final double threshold;
  const SensorWaterItem(
      {Key? key,
      required this.label,
      required this.size,
      required this.primaryColor,
      required this.secondaryColor,
      required this.textColor,
      required this.value,
      required this.threshold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = value / threshold;
    return Column(
      children: [
        WaterProgressIndicator(
            size: size,
            progress: progress,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor),
        const SizedBox(
          height: 15,
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        ),
        Text(
          "${value.round()}/${threshold.round()}",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: textColor),
        ),
      ],
    );
  }
}
