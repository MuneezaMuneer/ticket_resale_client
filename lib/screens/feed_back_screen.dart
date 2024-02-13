import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/providers/providers.dart';

import 'package:ticket_resale/widgets/widgets.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  late FeedbackProvider feedbackProvider;
  ValueNotifier<int> selectedStarsNotifier = ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();
    feedbackProvider = Provider.of<FeedbackProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
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
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Consumer<FeedbackProvider>(
                    builder: (context, feedbackProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How was you experience?',
                            style: _buildStyle(),
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 40,
                                width: width * 0.24,
                                child: CustomButton(
                                  onPressed: () {
                                    feedbackProvider.setExperience(0);
                                  },
                                  btnText: 'Negative',
                                  borderColor:
                                      AppColors.lightGrey.withOpacity(0.7),
                                  textColor: feedbackProvider.getExperience == 0
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  gradient: feedbackProvider.getExperience == 0
                                      ? customGradient
                                      : whiteGradient,
                                  weight: FontWeight.w500,
                                  textSize: AppSize.regular,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: width * 0.24,
                                child: CustomButton(
                                  onPressed: () {
                                    feedbackProvider.setExperience(1);
                                  },
                                  btnText: 'Neutral',
                                  borderColor:
                                      AppColors.lightGrey.withOpacity(0.7),
                                  textColor: feedbackProvider.getExperience == 1
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  gradient: feedbackProvider.getExperience == 1
                                      ? customGradient
                                      : whiteGradient,
                                  weight: FontWeight.w500,
                                  textSize: AppSize.regular,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: width * 0.24,
                                child: CustomButton(
                                  onPressed: () {
                                    feedbackProvider.setExperience(2);
                                  },
                                  btnText: 'Positive',
                                  borderColor:
                                      AppColors.lightGrey.withOpacity(0.7),
                                  textColor: feedbackProvider.getExperience == 2
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  gradient: feedbackProvider.getExperience == 2
                                      ? customGradient
                                      : whiteGradient,
                                  weight: FontWeight.w500,
                                  textSize: AppSize.regular,
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          Text(
                            'Did your ticket arrive (or was it available digitally) in a timely manner?',
                            style: _buildStyle(),
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: width * 0.24,
                                child: CustomButton(
                                  onPressed: () {
                                    feedbackProvider.setTime(3);
                                  },
                                  btnText: 'Yes',
                                  borderColor:
                                      AppColors.lightGrey.withOpacity(0.7),
                                  textColor: feedbackProvider.getTime == 3
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  gradient: feedbackProvider.getTime == 3
                                      ? customGradient
                                      : whiteGradient,
                                  weight: FontWeight.w500,
                                  textSize: AppSize.regular,
                                ),
                              ),
                              const Gap(27),
                              SizedBox(
                                height: 40,
                                width: width * 0.24,
                                child: CustomButton(
                                  onPressed: () {
                                    feedbackProvider.setTime(4);
                                  },
                                  btnText: 'No',
                                  borderColor:
                                      AppColors.lightGrey.withOpacity(0.7),
                                  textColor: feedbackProvider.getTime == 4
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  gradient: feedbackProvider.getTime == 4
                                      ? customGradient
                                      : whiteGradient,
                                  textSize: AppSize.regular,
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          Text(
                            'Was the information about the festival (line-up, dates, venue, etc.) accurate and helpful?',
                            style: _buildStyle(),
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: width * 0.24,
                                child: CustomButton(
                                  onPressed: () {
                                    feedbackProvider.setAccuracy(5);
                                  },
                                  btnText: 'Yes',
                                  textColor: feedbackProvider.getAccuracy == 5
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  gradient: feedbackProvider.getAccuracy == 5
                                      ? customGradient
                                      : whiteGradient,
                                  borderColor:
                                      AppColors.lightGrey.withOpacity(0.7),
                                  weight: FontWeight.w500,
                                  textSize: AppSize.regular,
                                ),
                              ),
                              const Gap(27),
                              SizedBox(
                                height: 40,
                                width: width * 0.24,
                                child: CustomButton(
                                  onPressed: () {
                                    feedbackProvider.setAccuracy(6);
                                  },
                                  btnText: 'No',
                                  textColor: feedbackProvider.getAccuracy == 6
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  gradient: feedbackProvider.getAccuracy == 6
                                      ? customGradient
                                      : whiteGradient,
                                  borderColor:
                                      AppColors.lightGrey.withOpacity(0.7),
                                  weight: FontWeight.w500,
                                  textSize: AppSize.regular,
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          Text(
                            'How well did the seller communicate? Consider response time and clarity of information',
                            style: _buildStyle(),
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 40,
                                width: width * 0.24,
                                child: CustomButton(
                                  onPressed: () {
                                    feedbackProvider.setBehave(7);
                                  },
                                  btnText: 'Negative',
                                  borderColor:
                                      AppColors.lightGrey.withOpacity(0.7),
                                  textColor: feedbackProvider.getBehave == 7
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  gradient: feedbackProvider.getBehave == 7
                                      ? customGradient
                                      : whiteGradient,
                                  weight: FontWeight.w500,
                                  textSize: AppSize.regular,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: width * 0.24,
                                child: CustomButton(
                                  onPressed: () {
                                    feedbackProvider.setBehave(8);
                                  },
                                  btnText: 'Neutral',
                                  borderColor:
                                      AppColors.lightGrey.withOpacity(0.7),
                                  textColor: feedbackProvider.getBehave == 8
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  gradient: feedbackProvider.getBehave == 8
                                      ? customGradient
                                      : whiteGradient,
                                  weight: FontWeight.w500,
                                  textSize: AppSize.regular,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: width * 0.24,
                                child: CustomButton(
                                  onPressed: () {
                                    feedbackProvider.setBehave(9);
                                  },
                                  btnText: 'Positive',
                                  borderColor:
                                      AppColors.lightGrey.withOpacity(0.7),
                                  textColor: feedbackProvider.getBehave == 9
                                      ? AppColors.white
                                      : AppColors.lightGrey,
                                  gradient: feedbackProvider.getBehave == 9
                                      ? customGradient
                                      : whiteGradient,
                                  weight: FontWeight.w500,
                                  textSize: AppSize.regular,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
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
                          buildStar(1),
                          const Gap(10),
                          buildStar(2),
                          const Gap(10),
                          buildStar(3),
                          const Gap(10),
                          buildStar(4),
                          const Gap(10),
                          buildStar(5),
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
                        hintStyle: TextStyle(color: AppColors.silver),
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

  TextStyle _buildStyle() {
    return TextStyle(
        fontSize: AppSize.medium,
        fontWeight: FontWeight.w600,
        color: AppColors.jetBlack.withOpacity(0.7));
  }

  Widget buildStar(int starNumber) {
    return GestureDetector(
      onTap: () {
        selectedStarsNotifier.value = starNumber;
      },
      child: ValueListenableBuilder<int>(
        valueListenable: selectedStarsNotifier,
        builder: (context, selectedStars, child) {
          return starNumber <= selectedStars
              ? SvgPicture.asset(AppSvgs.fillStar)
              : SvgPicture.asset(AppSvgs.star);
        },
      ),
    );
  }
}
