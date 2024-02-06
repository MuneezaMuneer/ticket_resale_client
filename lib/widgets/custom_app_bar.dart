import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/app_colors.dart';
import 'package:ticket_resale/constants/app_textsize.dart';
import 'package:ticket_resale/widgets/custom_gradient.dart';
import 'package:ticket_resale/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  const CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Container(
      height: height * 0.12,
      width: width,
      decoration: BoxDecoration(
          gradient: customGradient,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                    size: 18,
                  ),
                  const Gap(10),
                  CustomText(
                    title: '$title',
                    weight: FontWeight.w600,
                    size: AppSize.xmedium,
                    color: AppColors.white,
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.menu,
                color: AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
