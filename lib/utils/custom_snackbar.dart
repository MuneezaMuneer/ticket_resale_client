import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/constants.dart';
class SnackBarHelper {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.blueViolet,
        content: Text(
          message,
          style: const TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
