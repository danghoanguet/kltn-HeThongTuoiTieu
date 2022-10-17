import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelItem extends StatelessWidget {
  final String label;
  final String imageUrl;
  final Color? color;

  const LabelItem(
      {Key? key, required this.label, required this.imageUrl, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Image.asset(
            imageUrl,
            height: 50,
          ),
        ),
        Flexible(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.peralta(
              color: color ?? Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
      ],
    );
  }
}
