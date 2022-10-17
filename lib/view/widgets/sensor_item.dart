import 'package:flutter/material.dart';

class SensorItem extends StatelessWidget {
  final String label;
  final String stat;
  final Color color;
  final String imageUrl;

  const SensorItem(
      {Key? key,
      required this.label,
      required this.stat,
      required this.color,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            height: 80,
            width: 70,
            child: Center(
              child: Text(
                stat,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: color),
        )
      ],
    );
  }
}
