import 'package:flutter/material.dart';

import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/custom_text.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 160,
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: AppColors.amber,
            size: 20,
          ),
          CustomText(
            title: '4.7 ',
            weight: FontWeight.w600,
            size: AppSize.large,
            color: AppColors.charcoal,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: CustomText(
              title: '(23 Transactions) ',
              weight: FontWeight.w400,
              size: AppSize.small,
              color: AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}
