import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/app_colors.dart';

LinearGradient customGradient = const LinearGradient(
    colors: [AppColors.purple, AppColors.blueViolet],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);
LinearGradient lightGradient = LinearGradient(colors: [
  AppColors.purple.withOpacity(0.1),
  AppColors.blueViolet.withOpacity(0.1)
], begin: Alignment.topLeft, end: Alignment.bottomRight);
LinearGradient whiteGradient = const LinearGradient(
    colors: [AppColors.white, AppColors.white],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);
