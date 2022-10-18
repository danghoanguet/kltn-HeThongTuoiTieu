import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kltn/common/constants/colors_constant.dart';
import 'package:kltn/view/widgets/water_progess_indicator.dart';
import '../../common/constants/dimens_constant.dart';

class HeaderWithSearchBox extends StatelessWidget {
  HeaderWithSearchBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: DimensConstant.kDefaultPadding * 1.5),
      // It will cover 20% of our total height
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: DimensConstant.kDefaultPadding,
              right: DimensConstant.kDefaultPadding,
              bottom: 36 + DimensConstant.kDefaultPadding,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: ColorsConstant.kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Hi Hoang!',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Image.asset("assets/images/logo.png")
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  horizontal: DimensConstant.kDefaultPadding),
              // padding: EdgeInsets.symmetric(
              //     horizontal: DimensConstant.kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: ColorsConstant.kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                      child: WaterProgressIndicator(
                          size: 54,
                          progress: 0.5,
                          primaryColor: ColorsConstant.kPrimaryColor,
                          secondaryColor: ColorsConstant.greenSecondaryColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
