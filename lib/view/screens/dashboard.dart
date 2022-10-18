import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kltn/view/screens/about_screen.dart';
import 'package:kltn/view/screens/home_screen.dart';
import 'package:kltn/view/screens/pump_screen.dart';
import 'package:kltn/view/screens/threshold_screen.dart';

import '../../common/constants/assets_constant.dart';
import '../../common/constants/colors_constant.dart';
import '../widgets/custom_appbar.dart';
import 'over_view_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBar(),
      appBar: buildAppBar(),
      body: IndexedStack(
        index: currentPageIndex,
        children: const <Widget>[
          OverViewScreen(),
          SensorScreen(),
          PumpScreen(),
          ThresholdScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 10 * 2,
          right: 10 * 2,
        ),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -10),
              blurRadius: 35,
              color: ColorsConstant.kPrimaryColor.withOpacity(0.38),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            currentIndex: currentPageIndex,
            elevation: 2,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            selectedItemColor: ColorsConstant.kPrimaryColor,
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorsConstant.white,
            unselectedItemColor: ColorsConstant.gray1,
            onTap: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/overview.png",
                  color: currentPageIndex == 0
                      ? ColorsConstant.kPrimaryColor
                      : ColorsConstant.gray1,
                ),
                label: "Overview",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/sensor.png",
                  color: currentPageIndex == 1
                      ? ColorsConstant.kPrimaryColor
                      : ColorsConstant.gray1,
                ),
                label: "Sensor",
              ),
              // BottomNavigationBarItem(
              //   icon: SvgPicture.asset(
              //     AssetsConstant.icCircle,
              //     color: currentPageIndex == 1
              //         ? ColorsConstant.textBlue2
              //         : ColorsConstant.gray1,
              //   ),
              //   label: S.of(context).circle,
              // ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/water_pump.png",
                  color: currentPageIndex == 2
                      ? ColorsConstant.kPrimaryColor
                      : ColorsConstant.gray1,
                ),
                label: "Pump",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/threshold.png",
                  color: currentPageIndex == 3
                      ? ColorsConstant.kPrimaryColor
                      : ColorsConstant.gray1,
                ),
                label: "Threshold",
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: ColorsConstant.kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/menu.svg",
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
