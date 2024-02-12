import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: AppColors.pastelBlue.withOpacity(0.3),
      appBar: const CustomAppBar(
        title: 'Feedback',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const Gap(25),
                SizedBox(
                  width: width * 0.64,
                  child: const CustomText(
                    softWrap: true,
                    title: 'Give Feedback on your recent purchase with',
                    size: AppSize.large,
                    weight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    color: AppColors.jetBlack,
                  ),
                ),
                const Gap(25),
                const SizedBox(
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(AppImages.profile),
                  ),
                ),
                const Gap(10),
                const CustomText(
                  title: 'Leslie Alexander',
                  size: 18,
                  weight: FontWeight.w600,
                  color: AppColors.jetBlack,
                ),
                tileColumn('How was you experience?', 'Negative', 'Neutral',
                    'Positive', width * 0.24),
                tileColumn(
                    'Did your ticket arrive (or was it available digitally) in a timely manner?',
                    'Yes',
                    'No',
                    '',
                    width * 0.24,
                    isPositive: false),
                tileColumn(
                    'Was the information about the festival (line-up, dates, venue, etc.) accurate and helpful?',
                    'Yes',
                    'No',
                    '',
                    width * 0.24,
                    isPositive: false),
                tileColumn(
                    'How well did the seller communicate? Consider response time and clarity of information',
                    'Negative',
                    'Neutral',
                    'Positive',
                    width * 0.24),
                SizedBox(
                  height: height * 0.4,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * 0.36,
              decoration: const BoxDecoration(
                  color: AppColors.paleGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: CustomText(
                          title: 'Rate your overall experience',
                          size: AppSize.medium,
                          color: AppColors.jetBlack,
                          weight: FontWeight.w900,
                        ),
                      ),
                      Center(
                        child: CustomText(
                          title: 'What do you think of this purchase',
                          size: AppSize.medium,
                          color: AppColors.jetBlack.withOpacity(0.5),
                          weight: FontWeight.w400,
                        ),
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppSvgs.fillStar),
                          const Gap(10),
                          SvgPicture.asset(AppSvgs.fillStar),
                          const Gap(10),
                          SvgPicture.asset(AppSvgs.fillStar),
                          const Gap(10),
                          SvgPicture.asset(AppSvgs.fillStar),
                          const Gap(10),
                          SvgPicture.asset(AppSvgs.star),
                          const Gap(10),
                        ],
                      ),
                      const Gap(20),
                      const CustomText(
                        title: 'Comment',
                        size: AppSize.medium,
                        weight: FontWeight.w600,
                      ),
                      const Gap(10),
                      const CustomTextField(
                        fillColor: AppColors.white,
                        maxLines: 5,
                        isFilled: true,
                        hintText: 'Enter your comment here',
                        isCommentField: true,
                      ),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      SizedBox(
                        height: height * 0.07,
                        width: width * 0.9,
                        child: CustomButton(
                          onPressed: () {},
                          textColor: AppColors.white,
                          textSize: AppSize.regular,
                          btnText: 'Submit',
                          gradient: customGradient,
                          weight: FontWeight.w700,
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tileColumn(
      String title, String text1, String text2, String text3, double width,
      {bool isPositive = true}) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: title,
            size: AppSize.medium,
            softWrap: true,
            weight: FontWeight.w600,
            color: AppColors.jetBlack.withOpacity(0.7),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
                width: width,
                child: CustomButton(
                  onPressed: () {},
                  btnText: text1,
                  backgroundColor: AppColors.white,
                  borderColor: AppColors.lightGrey.withOpacity(0.7),
                  textColor: AppColors.lightGrey,
                  weight: FontWeight.w500,
                  textSize: AppSize.regular,
                ),
              ),
              SizedBox(
                height: 40,
                width: width,
                child: CustomButton(
                  onPressed: () {},
                  btnText: text2,
                  backgroundColor: AppColors.white,
                  borderColor: AppColors.lightGrey.withOpacity(0.7),
                  textColor: AppColors.lightGrey,
                  weight: FontWeight.w500,
                  textSize: AppSize.regular,
                ),
              ),
              SizedBox(
                  height: 40,
                  width: width,
                  child: isPositive
                      ? CustomButton(
                          onPressed: () {},
                          textColor: AppColors.white,
                          textSize: AppSize.medium,
                          btnText: text3,
                          gradient: customGradient,
                          weight: FontWeight.w600,
                        )
                      : const SizedBox.shrink())
            ],
          )
        ],
      ),
    );
  }
}
