import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/constants/colors_constant.dart';

class WaterProgressIndicator extends StatefulWidget {
  final double size;
  final double progress;
  final Color primaryColor;
  final Color secondaryColor;

  const WaterProgressIndicator({
    Key? key,
    required this.size,
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WaterProgressIndicatorState();
}

class _WaterProgressIndicatorState extends State<WaterProgressIndicator> {
  BorderRadius get borderRadius => BorderRadius.circular(widget.size / 2);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: ColorsConstant.white,
          borderRadius: borderRadius,
          border: Border.all(color: widget.primaryColor, width: 2),
        ),
        child: Stack(
          children: [
            WaveWidget(
              value: widget.progress,
              color: widget.secondaryColor,
              animationDuration: 4,
            ),
            WaveWidget(
              value: widget.progress,
              color: widget.primaryColor,
              animationDuration: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class WaveWidget extends StatefulWidget {
  final double? value;
  final Color color;
  final int animationDuration;

  const WaveWidget({
    Key? key,
    required this.value,
    required this.color,
    required this.animationDuration,
  }) : super(key: key);

  @override
  State<WaveWidget> createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
      builder: (context, child) => ClipPath(
        clipper: WaveClipper(
          animationValue: _animationController.value,
          value: widget.value,
        ),
        child: Container(color: widget.color),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animationValue;
  final double? value;

  WaveClipper({
    required this.animationValue,
    required this.value,
  });

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addPolygon(_generateVerticalWavePath(size), false)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..close();
    return path;
  }

  List<Offset> _generateVerticalWavePath(Size size) {
    final waveList = <Offset>[];
    final dividendY = 0.00005 * 1.sw * 1.sh;
    for (int i = 0; i < size.width; i++) {
      final waveHeight = (size.height / dividendY);
      final dy = math.sin((animationValue * 360 - i) % 360 * (math.pi / 45)) *
              waveHeight +
          (size.height - (size.height * value!));
      waveList.add(Offset(i.toDouble(), dy));
    }
    return waveList;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animationValue != oldClipper.animationValue;
}
