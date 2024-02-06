import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/components/auth_background_view.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class HomeFirstScreen extends StatelessWidget {
  const HomeFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      body: AuthBackgroundView(
          imagePath: AppImages.concert,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  title: 'Happy Holiday Music Concert Golbal Village',
                  size: AppSize.large,
                  weight: FontWeight.w600,
                  color: AppColors.jetBlack,
                  textAlign: TextAlign.start,
                ),
                const Gap(10),
                Container(
                  height: height * 0.07,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    color: AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Gap(10),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: AppColors.paleGrey,
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SvgPicture.asset(
                                AppSvgs.clock,
                                height: 25,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: '25th Janurary 2024',
                                  color: AppColors.lightGrey.withOpacity(0.6),
                                  size: AppSize.xsmall,
                                  weight: FontWeight.w400,
                                ),
                                const CustomText(
                                  title: '8:00 AM - 12:00 AM',
                                  color: AppColors.jetBlack,
                                  size: AppSize.small,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
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
                      )
                    ],
                  ),
                ),
                const Gap(10),
                const CustomText(
                  title: 'About Event',
                  size: AppSize.xmedium,
                  weight: FontWeight.w600,
                  color: AppColors.jetBlack,
                ),
                const CustomText(
                  title:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                  size: AppSize.small,
                  weight: FontWeight.w400,
                  color: AppColors.lightGrey,
                ),
                const Gap(10),
                Container(
                  height: height * 0.06,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    color: AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Gap(10),
                          const CircleAvatar(
                            backgroundImage: AssetImage(AppImages.profile),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14, top: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: 'Post by',
                                  color: AppColors.lightGrey.withOpacity(0.6),
                                  size: AppSize.xsmall,
                                  weight: FontWeight.w400,
                                ),
                                CustomText(
                                  title: 'Cameron Walliamson',
                                  color: AppColors.lightGrey.withOpacity(0.8),
                                  size: 13,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
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
                          ))
                    ],
                  ),
                ),
                const Gap(25),
                Container(
                  height: height * 0.07,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    color: const Color(0XffF7F5FF),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Gap(10),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: AppColors.white, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(
                                AppSvgs.ticket,
                                height: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  title: 'VIP PLUS TICKET AVAILABLE',
                                  color: AppColors.jetBlack,
                                  size: AppSize.small,
                                  weight: FontWeight.w600,
                                ),
                                CustomText(
                                  title: 'VIP Seats + Exclusive braclets',
                                  color: AppColors.lightGrey.withOpacity(0.6),
                                  size: AppSize.xsmall,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: CustomText(
                          title: '\$ 500',
                          color: Color(0XffAC8AF7),
                          size: 20,
                          weight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
