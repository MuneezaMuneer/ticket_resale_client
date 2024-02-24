import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/utils/app_dialouge.dart';
import 'package:ticket_resale/widgets/widgets.dart';
import '../components/components.dart';

class HomeDetailSecondScreen extends StatefulWidget {
  const HomeDetailSecondScreen({super.key});

  @override
  State<HomeDetailSecondScreen> createState() => _HomeDetailSecondScreenState();
}

class _HomeDetailSecondScreenState extends State<HomeDetailSecondScreen> {
  ValueNotifier<bool> isTileSelected = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: AppColors.pastelBlue.withOpacity(0.3),
      body: AppBackground(
        imagePath: AppImages.concert,
        isBackButton: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 23, top: 20, bottom: 20, right: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: CustomText(
                          title: ' Holiday Music Concert Golbal Village',
                          size: AppSize.large,
                          weight: FontWeight.w600,
                          softWrap: true,
                          color: AppColors.jetBlack,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SvgPicture.asset(
                        AppSvgs.share,
                        alignment: Alignment.centerRight,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  const Gap(10),
                  Container(
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56),
                        border: Border.all(color: AppColors.white),
                        color: AppColors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColors.paleGrey,
                                radius: 17,
                                backgroundImage:
                                    AssetImage(AppImages.profileImage),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                ),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Featured DJ : ',
                                      style: TextStyle(
                                          color: AppColors.lightGrey
                                              .withOpacity(0.6),
                                          fontSize: AppSize.xsmall,
                                          fontWeight: FontWeight.w400)),
                                  const TextSpan(
                                      text: 'Martin Garrix',
                                      style: TextStyle(
                                          color: AppColors.blueViolet,
                                          fontSize: AppSize.medium,
                                          fontWeight: FontWeight.w600)),
                                ])),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  _tileContainer(
                      height: height * 0.08,
                      width: width * 0.9,
                      isSvg: true,
                      imagePath: AppSvgs.clock,
                      backgroundColor: AppColors.white,
                      avatarBg: AppColors.paleGrey,
                      containerBorderColor: AppColors.white,
                      title: '25th Janurary 2024',
                      titleColor: AppColors.lightGrey.withOpacity(0.6),
                      titleSize: AppSize.xsmall,
                      titleWeight: FontWeight.w400,
                      subTitle: '8:00 AM - 12:00 AM',
                      subTitleColor: AppColors.jetBlack,
                      subTitleSize: AppSize.small,
                      subTitleWeight: FontWeight.w600,
                      child: const SizedBox.shrink()),
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
                    size: AppSize.medium,
                    softWrap: true,
                    weight: FontWeight.w400,
                    color: AppColors.lightGrey,
                  ),
                  const Gap(20),
                  const CustomText(
                    title: 'Available Tickets',
                    size: AppSize.regular,
                    weight: FontWeight.w600,
                    color: AppColors.jetBlack,
                  ),
                  const Gap(7),
                  ValueListenableBuilder(
                    valueListenable: isTileSelected,
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          isTileSelected.value = true;
                          // isFirstTileSelected.value =
                          //     !isFirstTileSelected.value;
                          // isSecondTileSelected.value = false;
                        },
                        child: _tileContainer(
                          height: height * 0.08,
                          width: width * 0.9,
                          containerBorderColor: isTileSelected.value
                              ? AppColors.blueViolet.withOpacity(0.8)
                              : const Color(0XffF7F5FF),
                          isSvg: true,
                          imagePath: AppSvgs.ticket,
                          backgroundColor: const Color(0XffF7F5FF),
                          avatarBg: AppColors.white,
                          title: 'PREMIUM TICKET AVAILABLE',
                          titleColor: AppColors.jetBlack,
                          titleSize: AppSize.small,
                          titleWeight: FontWeight.w600,
                          subTitle: 'Premium Seats',
                          subTitleColor: AppColors.lightGrey.withOpacity(0.6),
                          subTitleSize: AppSize.xsmall,
                          subTitleWeight: FontWeight.w400,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: CustomText(
                              title: '\$ 500',
                              color: Color(0XffAC8AF7),
                              size: 18,
                              weight: FontWeight.w900,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(25),
                  ValueListenableBuilder(
                    valueListenable: isTileSelected,
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          isTileSelected.value = true;
                          // isSecondTileSelected.value =
                          //     !isSecondTileSelected.value;
                          // isFirstTileSelected.value = false;
                        },
                        child: _tileContainer(
                          height: height * 0.08,
                          width: width * 0.9,
                          containerBorderColor: isTileSelected.value
                              ? AppColors.blueViolet.withOpacity(0.8)
                              : const Color(0XffF7F5FF),
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
                              title: '\$ 400',
                              color: Color(0XffAC8AF7),
                              size: 18,
                              weight: FontWeight.w900,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(25),
                  Container(
                    height: height * 0.1,
                    width: width,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Gap(7),
                        const CircleAvatar(
                            backgroundImage: AssetImage(AppImages.profile)),
                        const Gap(9),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: width > 370 ? 14 : 5,
                            ),
                            CustomText(
                              title: 'Sell by',
                              size: AppSize.verySmall,
                              weight: FontWeight.w300,
                              color: AppColors.lightBlack.withOpacity(0.7),
                            ),
                            Row(
                              children: [
                                CustomText(
                                  title: 'Cameron Williamson ',
                                  size: AppSize.intermediate,
                                  weight: FontWeight.w600,
                                  color: AppColors.lightBlack.withOpacity(0.5),
                                ),
                                CustomText(
                                  title: '(',
                                  color: AppColors.lightBlack.withOpacity(0.7),
                                ),
                                SvgPicture.asset(
                                  AppSvgs.fillStar,
                                  height: 13,
                                ),
                                CustomText(
                                  title: '4.7 )',
                                  color: AppColors.lightBlack.withOpacity(0.7),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: width > 370 ? 4 : 0,
                            ),
                            const Row(
                              children: [
                                CustomText(
                                    title: '23',
                                    size: AppSize.intermediate,
                                    weight: FontWeight.w500),
                                Gap(2),
                                CustomText(
                                  title: 'Ticket Sold',
                                  size: AppSize.xxsmall,
                                  weight: FontWeight.w400,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width > 370 ? width * 0.15 : width * 0.11,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SvgPicture.asset(AppSvgs.levelThree),
                            ))
                      ],
                    ),
                  ),
                  const Gap(25),
                  ValueListenableBuilder(
                    valueListenable: isTileSelected,
                    builder: (context, value, child) {
                      return SizedBox(
                        child: value
                            ? CustomTextField(
                                hintText: 'Offer you price',
                                hintStyle: TextStyle(
                                    color:
                                        AppColors.lightBlack.withOpacity(0.5)),
                                fillColor: AppColors.white,
                                suffixIcon: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SvgPicture.asset(
                                      AppSvgs.dollarSign,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isTileSelected,
                    builder: (context, value, child) {
                      return SizedBox(
                          height: height * 0.07,
                          width: width * 0.9,
                          child: CustomButton(
                            onPressed: () {
                              // Navigator.pushNamed(
                              //     context, AppRoutes.commentScreen);
                              ticketSellDialog(context: context);
                            },
                            textColor: AppColors.white,
                            textSize: AppSize.regular,
                            btnText: 'Start Conversation',
                            gradient: isTileSelected.value
                                ? customGradient
                                : lightGradient,
                            weight: FontWeight.w700,
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tileContainer({
    double? height,
    double? width,
    Color? containerBorderColor,
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
          border: Border.all(color: containerBorderColor!),
          borderRadius: BorderRadius.circular(56),
          color: backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                  padding: const EdgeInsets.only(left: 8, top: 13),
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
        ],
      ),
    );
  }
}
