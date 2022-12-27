import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn/common/constants/dimens_constant.dart';

import '../../../../common/constants/colors_constant.dart';

class SetVPDItem extends StatefulWidget {
  final min;
  final max;
  final soil;
  final temp;
  final humid;
  const SetVPDItem({
    Key? key,
    required this.min,
    required this.max,
    required this.soil,
    required this.temp,
    required this.humid,
  }) : super(key: key);

  @override
  State<SetVPDItem> createState() => _SetVPDItemState();
}

class _SetVPDItemState extends State<SetVPDItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  double calculateVPD(double temp, double rh) {
    return ((610.7 * pow(10, (7.5 * temp / (237.3 + temp)))) /
        1000 *
        (1 - rh / 100));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 800,
      ),
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        // height: size.height * 0.2,
        padding: EdgeInsets.only(top: 5, left: 15, right: 15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(20.0, 20.0),
              color: ColorsConstant.progressShadowColor,
              blurRadius: 70.0,
            ),
            BoxShadow(
              offset: Offset(-20.0, -20.0),
              color: ColorsConstant.progressShadowColor2,
              blurRadius: 70.0,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: ColorsConstant.progressBarBackground,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Column(children: [
          Row(
            children: [
              Icon(
                Icons.grass,
                color: ColorsConstant.kPrimaryColor,
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "How to set",
                style: TextStyle(
                  color: ColorsConstant.borderTextFieldColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: ColorsConstant.borderTextFieldColor,
                ),
                onPressed: () {
                  setState(() {
                    !_isExpanded
                        ? _controller.forward()
                        : _controller.reverse();
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ],
          ),
          //if (_isExpanded)
          AnimatedContainer(
            duration: Duration(milliseconds: 800),
            curve: Curves.fastOutSlowIn,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            //height: min(widget.orders.products.length * 20 + 40, 100),
            constraints: BoxConstraints(
              maxHeight: _isExpanded ? 300 : 0,
            ),
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    child: Column(
                      children: [
                        // Row(
                        //   children: [
                        //     Container(
                        //       padding: EdgeInsets.only(
                        //         top: 5,
                        //         bottom: 5,
                        //       ),
                        //       height: size.width * 0.12,
                        //       width: size.width * 0.12,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(12),
                        //         border: Border.all(
                        //           color: ColorsConstant.red.withOpacity(0.5),
                        //           width: 2,
                        //         ),
                        //         gradient: LinearGradient(
                        //           begin: Alignment.topCenter,
                        //           end: Alignment.bottomCenter,
                        //           colors: ColorsConstant.borderColors,
                        //         ),
                        //       ),
                        //       child: Image.asset(
                        //         "assets/images/tomato.png",
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 15,
                        //     ),
                        //     Flexible(
                        //       child: Text(
                        //         "Tomatoes need moderate soil moisture because if you overdo it with watering they quickly form a powerful vegetative mass and fewer fruits",
                        //         style: GoogleFonts.aBeeZee(
                        //           color: ColorsConstant.borderTextFieldColor,
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 15,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              height: size.width * 0.12,
                              width: size.width * 0.12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: ColorsConstant.red.withOpacity(0.5),
                                  width: 2,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: ColorsConstant.borderColors,
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/tomato.png",
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Text(
                                "Vapor Pressure Deficit (VPD) helps you identify the correct range of temperature and humidity to aim for in your grow space. Ideal vpd range is ${DimensConstant.vpdMin}~${DimensConstant.vpdMax}(kPa)",
                                style: GoogleFonts.aBeeZee(
                                  color: ColorsConstant.borderTextFieldColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              height: size.width * 0.12,
                              width: size.width * 0.12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.blue.withOpacity(0.5),
                                  width: 2,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: ColorsConstant.borderColors,
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/temperature.png",
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Text(
                                "Case 1: If vpd in range or vpd lower than vpd min, pump on if soil lower than soil threshold\nCase 2: If vpd greater than vpd max pump on",
                                style: GoogleFonts.aBeeZee(
                                  color: ColorsConstant.borderTextFieldColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              height: size.width * 0.12,
                              width: size.width * 0.12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.brown.withOpacity(0.9),
                                  width: 2,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: ColorsConstant.borderColors,
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/soil_threshold.png",
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Text(
                                "VPD min: ${widget.min}(kPa)\nVPD max: ${widget.max}(kPa)\nSoil: ${widget.soil}%",
                                style: GoogleFonts.aBeeZee(
                                  color: ColorsConstant.borderTextFieldColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
