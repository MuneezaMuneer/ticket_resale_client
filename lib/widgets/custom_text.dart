import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final TextStyle? style;
  final TextAlign? textAlign;
  final FontWeight? weight;
  const CustomText(
      {super.key,
      this.style,
      required this.title,
      this.color,
      this.size,
      this.weight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(fontSize: size, fontWeight: weight, color: color),
    );
  }
}
