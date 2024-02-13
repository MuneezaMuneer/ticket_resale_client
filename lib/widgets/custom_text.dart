import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final Color? color;
  final int? maxLines;
  final double? size;
  final TextAlign? textAlign;
  final bool softWrap;
  final FontWeight? weight;
  const CustomText(
      {super.key,
      this.title,
      this.color,
      this.size,
      this.weight,
      this.textAlign,
      this.softWrap = false,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      maxLines: maxLines,
      softWrap: softWrap,
      textAlign: textAlign,
      style: TextStyle(fontSize: size, fontWeight: weight, color: color),
    );
  }
}
