import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/constants/colors_constant.dart';
import '../../../../data/model/WifiModel.dart';

class WifiCard extends StatelessWidget {
  const WifiCard({
    Key? key,
    required this.size,
    required WifiModel wifiModel,
  })  : _wifiModel = wifiModel,
        super(key: key);

  final Size size;
  final WifiModel _wifiModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 3, color: ColorsConstant.yellowPrimaryColor),
        // image: DecorationImage(
        //   image: AssetImage("assets/images/image_1.png"),
        //   fit: BoxFit.fill,
        // ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: ColorsConstant.yellowPrimaryColor.withOpacity(0.5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsConstant.yellowPrimaryColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: ColorsConstant.yellowPrimaryColor, width: 2),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  "CONNECT",
                  style: GoogleFonts.adventPro(
                    color: ColorsConstant.background2,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
            decoration: BoxDecoration(
                // color: ColorsConstant.background2,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                // Container(
                //   margin: EdgeInsets.only(left: 5, right: 10, top: 5),
                //   height: size.width * 0.1,
                //   width: size.width * 0.08,
                //   child: SvgPicture.asset("assets/icons/icon_2.svg"),
                // ),
                Text(
                  "Network: ",
                  style: GoogleFonts.aBeeZee(
                    color: ColorsConstant.yellowPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Flexible(
                  child: Text(
                    "${_wifiModel.wifiName}",
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 5, right: 5),
            decoration: BoxDecoration(
                // color: ColorsConstant.background2,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                // Container(
                //   margin: EdgeInsets.only(left: 5, right: 10, top: 5),
                //   height: size.width * 0.1,
                //   width: size.width * 0.08,
                //   child: SvgPicture.asset("assets/icons/icon_4.svg"),
                // ),
                Text(
                  "IP: ",
                  style: GoogleFonts.aBeeZee(
                    color: ColorsConstant.yellowPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Flexible(
                  child: Text(
                    "${_wifiModel.wifiIpAddress}",
                    style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
            decoration: BoxDecoration(
                // color: ColorsConstant.background2,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                // Container(
                //   margin: EdgeInsets.only(left: 5, right: 10, top: 5),
                //   height: size.width * 0.1,
                //   width: size.width * 0.08,
                //   child: SvgPicture.asset("assets/icons/icon_3.svg"),
                // ),
                Text(
                  "Status: ",
                  style: GoogleFonts.aBeeZee(
                    color: ColorsConstant.yellowPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Flexible(
                  child: Text(
                    "${_wifiModel.wifiStatus}",
                    style: GoogleFonts.aBeeZee(
                      color: ColorsConstant.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
