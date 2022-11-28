import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/constants/colors_constant.dart';

class WarningItem extends StatefulWidget {
  const WarningItem({
    Key? key,
  }) : super(key: key);

  @override
  State<WarningItem> createState() => _WarningItemState();
}

class _WarningItemState extends State<WarningItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

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
                Icons.warning,
                color: ColorsConstant.yellowPrimaryColor,
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Warning",
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
                                "assets/images/temperature.png",
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Text(
                                "When temperature reach or greater than temperature threshold, plant need watering (\u2103)",
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
                                  color: ColorsConstant.bluePrimaryColor
                                      .withOpacity(0.5),
                                  width: 2,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: ColorsConstant.borderColors,
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/water.png",
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Text(
                                "When humid % smaller or equal than humid threshold %, plant need watering",
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
                                "When soil % smaller or equal than soil threshold %, plant need watering",
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
