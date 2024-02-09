import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

import '../components/components.dart';


class HomeDetailScreen extends StatelessWidget {
  const HomeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      body: AppBackground(
          imagePath: AppImages.concert,
          isBackButton: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 28, right: 28, top: 40, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: 'Happy Holiday Music Concert Golbal Village',
                    size: AppSize.large,
                    weight: FontWeight.w600,
                    softWrap: true,
                    color: AppColors.jetBlack,
                    textAlign: TextAlign.start,
                  ),
                  const Gap(10),
                  _tileContainer(
                      height: height * 0.07,
                      width: width * 0.9,
                      isSvg: true,
                      imagePath: AppSvgs.clock,
                      backgroundColor: AppColors.white,
                      avatarBg: AppColors.paleGrey,
                      title: '25th Janurary 2024',
                      titleColor: AppColors.lightGrey.withOpacity(0.6),
                      titleSize: AppSize.xsmall,
                      titleWeight: FontWeight.w400,
                      subTitle: '8:00 AM - 12:00 AM',
                      subTitleColor: AppColors.jetBlack,
                      subTitleSize: AppSize.small,
                      subTitleWeight: FontWeight.w600,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: AppColors.vibrantGreen,
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppSvgs.man),
                          ),
                        ),
                      )),
                  const Gap(10),
                  const CustomText(
                    title: 'About Event',
                    size: AppSize.regular,
                    weight: FontWeight.w600,
                    color: AppColors.jetBlack,
                  ),
                  const CustomText(
                    title:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                    size: AppSize.small,
                    softWrap: true,
                    weight: FontWeight.w400,
                    color: AppColors.lightGrey,
                  ),
                  const Gap(10),
                  _tileContainer(
                      height: height * 0.07,
                      width: width * 0.9,
                      imagePath: AppImages.profile,
                      backgroundColor: AppColors.white,
                      avatarBg: AppColors.paleGrey,
                      title: 'Post by',
                      titleColor: AppColors.lightGrey.withOpacity(0.6),
                      titleSize: AppSize.xsmall,
                      titleWeight: FontWeight.w400,
                      subTitle: 'Cameron Walliamson',
                      subTitleColor: AppColors.lightGrey.withOpacity(0.8),
                      subTitleSize: 13,
                      subTitleWeight: FontWeight.w600,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppSvgs.verified),
                              const Gap(3),
                              const CustomText(
                                title: 'Level 3 Varified',
                                color: AppColors.yellow,
                                size: AppSize.xxsmall,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ))),
                  const Gap(25),
                  _tileContainer(
                      height: height * 0.07,
                      width: width * 0.9,
                      isSvg: true,
                      imagePath: AppSvgs.ticket,
                      backgroundColor: const Color(0XffF7F5FF),
                      avatarBg: AppColors.white,
                      title: 'VIP PLUS TICKET AVAILABLE',
                      titleColor: AppColors.jetBlack,
                      titleSize: AppSize.small,
                      titleWeight: FontWeight.w600,
                      subTitle: 'VIP Seats + Exclusive braclets',
                      subTitleColor: AppColors.lightGrey.withOpacity(0.6),
                      subTitleSize: AppSize.xsmall,
                      subTitleWeight: FontWeight.w400,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: CustomText(
                          title: '\$ 500',
                          color: Color(0XffAC8AF7),
                          size: 18,
                          weight: FontWeight.w600,
                        ),
                      )),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.07,
                    width: width * 0.9,
                    child: CustomButton(
                      onPressed: () {},
                      textColor: AppColors.white,
                      textSize: AppSize.regular,
                      btnText: 'Start Conversation',
                      gradient: customGradient,
                      weight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _tileContainer({
    double? height,
    double? width,
    String? imagePath,
    bool isSvg = false,
    Color? backgroundColor,
    Color? avatarBg,
    String? title,
    FontWeight? titleWeight,
    Color? titleColor,
    double? titleSize,
    String? subTitle,
    double? subTitleSize,
    FontWeight? subTitleWeight,
    Color? subTitleColor,
    required Widget child,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(56), color: backgroundColor),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: avatarBg,
                  radius: 15,
                  child: isSvg
                      ? SvgPicture.asset(
                          "$imagePath",
                          height: 25,
                        )
                      : Image.asset(
                          '$imagePath',
                          fit: BoxFit.cover,
                        )),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: '$title',
                      color: titleColor,
                      size: titleSize,
                      weight: titleWeight,
                    ),
                    CustomText(
                      title: '$subTitle',
                      color: subTitleColor,
                      size: subTitleSize,
                      weight: subTitleWeight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          child: child,
        )
      ]),
    );
  }
}
