import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/constants/colors_constant.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
  // const CustomBottomNavigatorBar({ Key? key }) : super(key: key);
  final bottomBarItem = [
    'home',
    'water_pump',
    'threshold',
    'about',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: bottomBarItem
            .map((e) => Image.asset(
                  'assets/images/$e.png',
                  color: ColorsConstant.textBlue2,
                ))
            .toList(),
      ),
    );
  }
}
