import 'package:flutter/material.dart';

import '../../../../common/constants/colors_constant.dart';
import '../../../../data/model/PumpModel.dart';
import '../../../widgets/toggle_button.dart';

class ModeOption extends StatelessWidget {
  final String name;
  final Widget icon;
  final Function(bool) onTab;
  final bool isOn;

  const ModeOption(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onTab,
      required this.isOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(
            color: ColorsConstant.lightTextColor,
            fontWeight: FontWeight.w900,
            fontSize: 16.0,
          ),
        ),
        Container(
          width: 85.0,
          height: 85.0,
          margin: EdgeInsets.only(top: 0.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -30.0,
                right: -30.0,
                left: -30.0,
                bottom: -30.0,
                child: ToggleButton(
                  onTab: (bool) async {
                    onTab(bool);
                  },
                  // width: 50,
                  // height: 50,
                  child: this.icon,
                  isOn: isOn,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
