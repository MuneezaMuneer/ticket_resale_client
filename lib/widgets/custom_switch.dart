import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        activeColor: Colors.pink.shade200,
        thumbColor: AppColors.white,
        trackColor: AppColors.pastelBlue,
        value: false,
        onChanged: (bool value) {},
      ),
    );
  }
}
