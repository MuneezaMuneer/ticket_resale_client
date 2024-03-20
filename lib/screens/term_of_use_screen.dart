import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarClient(
        title: 'Terms of Use',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(40),
              CustomText(
                title: TermOfUseText.termOfUse,
                color: AppColors.brown,
                size: AppSize.regular,
                softWrap: true,
                textAlign: TextAlign.start,
                weight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
