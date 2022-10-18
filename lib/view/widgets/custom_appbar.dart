import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kltn/common/constants/colors_constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // const CustomAppBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => {},
              icon: SvgPicture.asset("assets/icons/menu.svg"),
            ),
            CircleAvatar(
              backgroundColor: ColorsConstant.background,
              backgroundImage: AssetImage("assets/images/plane.png"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
