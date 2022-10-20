import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final Widget child;
  final Function(bool) onTab;
  final double? width;
  final double? height;

  final bool isOn;

  ToggleButton({
    Key? key,
    required this.isOn,
    required this.child,
    required this.onTab,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  // @override
  // void initState() {
  //   this.isOn = this.widget.isOn ?? true;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.widget.width ?? 180.0,
      height: this.widget.height ?? 180.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.isOn == true
              ? "assets/images/button_on.png"
              : "assets/images/button_off.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        onTap: () async {
          widget.onTab(widget.isOn);
        },
        child: Align(
          alignment: Alignment.center,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              widget.isOn == true ? Colors.white : Colors.grey.withOpacity(0.4),
              BlendMode.modulate,
            ),
            child: this.widget.child,
          ),
        ),
      ),
    );
  }
}
