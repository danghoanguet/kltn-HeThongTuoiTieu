import 'package:flutter/material.dart';

class DimensConstant {
  static const double designWidth = 375.0;
  static const double designHeight = 812.0;
  static double statusBarHeight = 0;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static const EdgeInsets defaultPadding = EdgeInsets.all(16);
  static const EdgeInsets hPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets vPadding = EdgeInsets.symmetric(vertical: 16);
  static BorderRadius defaultBorderRadius = BorderRadius.circular(10);
  static const double buttonHeight = 43;

  static void init(context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
