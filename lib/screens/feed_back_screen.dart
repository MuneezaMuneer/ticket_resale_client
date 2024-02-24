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
    feedbackProvider = Provider.of<FeedbackProvider>(context, listen: false);
    super.initState();
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildForm(width),
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

Widget _buildForm(double width) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Consumer<FeedbackProvider>(
      builder: (context, feedbackProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeaderText('How was your experience?'),
            const Gap(10),
            buildButtonRow(
              width: width,
              values: [0, 1, 2],
              buttonTexts: ['Negative', 'Neutral', 'Positive'],
              onPressed: feedbackProvider.setExperience,
              selectedValue: feedbackProvider.getExperience,
            ),
            const Gap(20),
            buildHeaderText(
                'Did your ticket arrive (or was it available digitally) in a timely manner?'),
            const Gap(10),
            buildButtonRow(
              width: width,
              values: [
                3,
                4,
              ],
              buttonTexts: [
                'Yes',
                'No',
              ],
              onPressed: feedbackProvider.setTime,
              selectedValue: feedbackProvider.getTime,
            ),
            const Gap(20),
            buildHeaderText(
                'Was the information about the festival accurate and helpful?'),
            const Gap(10),
            buildButtonRow(
              width: width,
              values: [
                5,
                6,
              ],
              buttonTexts: [
                'Yes',
                'No',
              ],
              onPressed: feedbackProvider.setAccuracy,
              selectedValue: feedbackProvider.getAccuracy,
            ),
            const Gap(20),
            buildHeaderText(
                'How well did the seller communicate? Consider response time and clarity of information'),
            const Gap(10),
            buildButtonRow(
              width: width,
              values: [7, 8, 9],
              buttonTexts: ['Negative', 'Neutral', 'Positive'],
              onPressed: feedbackProvider.setBehave,
              selectedValue: feedbackProvider.getBehave,
            ),
          ],
        );
      },
    ),
  );
}

Text buildHeaderText(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: AppSize.medium,
        fontWeight: FontWeight.w600,
        color: AppColors.jetBlack.withOpacity(0.7)),
  );
}

Row buildButtonRow({
  required double width,
  required List<int> values,
  required List<String> buttonTexts,
  required void Function(int) onPressed,
  required int selectedValue,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(
      values.length,
      (index) => SizedBox(
        height: 40,
        width: width * 0.24,
        child: CustomButton(
          onPressed: () => onPressed(values[index]),
          btnText: buttonTexts[index],
          borderColor: AppColors.lightGrey.withOpacity(0.7),
          textColor: selectedValue == values[index]
              ? AppColors.white
              : AppColors.lightGrey,
          gradient:
              selectedValue == values[index] ? customGradient : whiteGradient,
          weight: FontWeight.w500,
          textSize: AppSize.regular,
        ),
      ),
    ),
  );
}
