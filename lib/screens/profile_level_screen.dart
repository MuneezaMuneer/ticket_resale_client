import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class ProfileLevelScreen extends StatelessWidget {
  const ProfileLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: AppColors.white.withOpacity(0.2),
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              SizedBox(
                height: 140,
                width: 140,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "${FirebaseAuth.instance.currentUser!.photoURL}"),
                ),
              ),
              Positioned(
                  left: 90, top: 70, child: SvgPicture.asset(AppSvgs.levelOne))
            ],
          ),
          const SizedBox(
            height: 13,
          ),
          CustomText(
            title: '${FirebaseAuth.instance.currentUser!.displayName}',
            weight: FontWeight.w600,
            size: AppSize.large,
            color: AppColors.jetBlack,
          ),
          const SizedBox(
            height: 5,
          ),
          const CustomRow(),
          const SizedBox(
            height: 3,
          ),
          const Gap(40),
          Expanded(
            child: Container(
              width: width,
              decoration: const BoxDecoration(
                  color: AppColors.paleGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      title: 'Your Profile Level',
                      size: AppSize.large,
                      weight: FontWeight.w600,
                      color: AppColors.jetBlack,
                    ),
                    CustomText(
                      title:
                          'Complete below mentioned steps to get higher trust level badge for you profile.',
                      size: AppSize.medium,
                      weight: FontWeight.w400,
                      softWrap: true,
                      color: AppColors.jetBlack.withOpacity(0.7),
                    ),
                    const Gap(7),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(20),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.feedbackScreen);
                              },
                              child: _buildContainer(
                                  AppSvgs.levelOne,
                                  'Verify your email',
                                  'Level 1 verified',
                                  width,
                                  AppColors.yellow,
                                  AppColors.yellow),
                            ),
                            _buildContainer(
                                AppSvgs.levelTwo,
                                'Verify your Phone No',
                                'Level 2 verified',
                                width,
                                AppColors.yellow,
                                AppColors.yellow),
                            _buildContainer(
                                AppSvgs.levelThree,
                                'Connect you PayPal',
                                'Verify for Level 3',
                                width,
                                AppColors.blueViolet,
                                AppColors.blueViolet),
                            _buildContainer(
                                AppSvgs.levelFour,
                                'Add Instagram profile',
                                'Verify for Level 4',
                                width,
                                AppColors.blueViolet,
                                AppColors.blueViolet),
                            _buildContainer(
                                AppSvgs.levelFive,
                                'Post your 1st Ticket',
                                'Verify for Level 5',
                                width,
                                AppColors.blueViolet,
                                AppColors.blueViolet),
                            _buildContainer(
                                AppSvgs.levelSix,
                                'Make your 1st transaction',
                                'Verify for Level 6',
                                width,
                                AppColors.blueViolet,
                                AppColors.blueViolet),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContainer(String svgPath, String title, String leveltext,
      double width, Color textColor, Color svgColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 55,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(43),
            color: AppColors.white,
            border: Border.all(color: AppColors.yellow)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: width < 370 ? 2 : 5,
                ),
                SizedBox(
                    height: 30, width: 30, child: SvgPicture.asset(svgPath)),
                SizedBox(
                  width: width < 370 ? 0 : 2,
                ),
                CustomText(
                  title: title,
                  size: AppSize.intermediate,
                  weight: FontWeight.w400,
                ),
                SizedBox(
                  width: width < 370 ? 0 : 5,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: width < 370 ? 0 : 5,
                ),
                SvgPicture.asset(
                  AppSvgs.verified,
                  colorFilter: ColorFilter.mode(svgColor, BlendMode.srcIn),
                ),
                SizedBox(
                  width: width < 370 ? 0 : 5,
                ),
                CustomText(
                  title: leveltext,
                  size: AppSize.verySmall,
                  weight: FontWeight.w400,
                  color: textColor,
                ),
                SizedBox(
                  width: width < 370 ? 5 : 9,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
