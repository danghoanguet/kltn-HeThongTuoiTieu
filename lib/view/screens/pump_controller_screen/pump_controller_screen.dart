import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kltn/common/constants/colors_constant.dart';
import 'package:kltn/view/screens/sensor_screen/components/humid_card_item.dart';

import '../../../data/model/PumpModel.dart';
import '../sensor_screen/components/temperature_card_item.dart';
import '../sensor_screen/components/soil_card_item.dart';
import '../sensor_screen/components/temperature_bar.dart';
import '../../widgets/water_progess_indicator.dart';
import 'components/mode_panel.dart';
import 'components/slider_panel.dart';
import 'components/temperature_slider.dart';
import 'components/title_panel.dart';

class PumpController extends StatelessWidget {
  final _database = FirebaseDatabase.instance.ref();

  bool _isManuel = false;
  bool _isPumpRunning = false;
  double _pumpValue = 0;

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: ColorsConstant.progressBarTrackColor,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset(
          "assets/images/water_pump.png",
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: Text(
        "Pump Controller",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              // topRight: Radius.circular(50.0),
              // topLeft: Radius.circular(50.0),
              ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorsConstant.borderColors,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50.0),
                topLeft: Radius.circular(50.0),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ColorsConstant.conBackgroundColor,
              ),
            ),
            child: StreamBuilder<DatabaseEvent>(
                stream: _database.child("CONTROL").onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final _pumpModel = PumpModel.fromRTDB(
                        Map<String, dynamic>.from(snapshot.data?.snapshot.value
                            as Map<dynamic, dynamic>));
                    _isManuel = _pumpModel.control == "0" ? false : true;
                    _pumpValue = double.parse(_pumpModel.state);
                    _isPumpRunning = _pumpModel.state != "0" ? true : false;
                    return Column(
                      children: [
                        Container(
                          width: 60.0,
                          height: 4.0,
                          margin: EdgeInsets.fromLTRB(0, 12.0, 0, 12.0),
                          decoration: BoxDecoration(
                            color: ColorsConstant.darkColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                        ),
                        Container(
                            height: size.height * 0.1,
                            child: TitlePanel(pumpModel: _pumpModel)),
                        Text(
                          "Pump Power",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                            color: ColorsConstant.mainTextColor,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          height: size.height * 0.35,
                          child: PumpControlSlider(pumpModel: _pumpModel),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "Water Capacity",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                            color: ColorsConstant.mainTextColor,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: size.width * 0.8,
                                child: WaterProgressIndicator(
                                    size: size.height * 0.05,
                                    progress: _pumpValue / 100,
                                    primaryColor:
                                        ColorsConstant.btnGradientEnd1,
                                    secondaryColor:
                                        ColorsConstant.btnGradientStart1)),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        //SliderPanel(pumpModel: _pumpModel),
                        // TemperatureBar(
                        //   value: 0.3,
                        // ),

                        ModePanel(
                          pumpModel: _pumpModel,
                        ),
                        SizedBox(height: 10.0),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
