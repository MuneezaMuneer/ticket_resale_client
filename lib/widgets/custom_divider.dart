import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/constants.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Divider(
        thickness: 1,
        color: AppColors.pastelBlue,
        endIndent: 15,
        indent: 15,
      ),
    );
  }
}
