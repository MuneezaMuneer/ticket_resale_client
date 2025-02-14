import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarClient(title: 'Privacy Policy'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(40),
              CustomText(
                title: AppText.privacyPolicy,
                color: AppColors.brown,
                size: AppFontSize.regular,
                softWrap: true,
                textAlign: TextAlign.start,
                weight: FontWeight.w400,
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
