import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

// ignore: must_be_immutable
class CustomSwitch extends StatelessWidget {
  CustomSwitch({
    super.key,
  });
  ValueNotifier<bool> notificationVisibility = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: ValueListenableBuilder<bool>(
        builder: (context, isVisible, child) => CupertinoSwitch(
          activeColor: AppColors.blueViolet,
          thumbColor: Colors.white,
          trackColor: AppColors.pastelBlue,
          value: isVisible,
          onChanged: (bool value) {
            notificationVisibility.value = !notificationVisibility.value;
          },
        ),
        valueListenable: notificationVisibility,
      ),
    );
  }
}
