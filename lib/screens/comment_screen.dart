import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/components/app_background_view.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/utils/app_dialouge.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      body: AppBackGround(
          imagePath: AppImages.concert,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 28, right: 28, top: 20, bottom: 20),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: 'Comments',
                        size: AppSize.xmedium,
                        color: AppColors.jetBlack,
                        weight: FontWeight.w600,
                      ),
                      Row(
                        children: [
                          CustomText(
                            title: 'Subcribe to comments',
                            size: AppSize.medium,
                            weight: FontWeight.w400,
                            color: AppColors.lightGrey,
                          ),
                          CustomSwitch()
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                      height: height * 0.4,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 6),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(AppImages.profile),
                                ),
                                const Gap(20),
                                SizedBox(
                                  width: width * 0.53,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const CustomText(
                                            title: 'Lucy Lure',
                                            size: AppSize.intermediate,
                                            weight: FontWeight.w600,
                                            color: AppColors.jetBlack,
                                          ),
                                          const Gap(15),
                                          Container(
                                            height: 5,
                                            width: 5,
                                            decoration: BoxDecoration(
                                                color: AppColors.lightGrey
                                                    .withOpacity(0.7),
                                                shape: BoxShape.circle),
                                          ),
                                          const Gap(5),
                                          CustomText(
                                            title: '2 mintues ago',
                                            size: AppSize.medium,
                                            weight: FontWeight.w400,
                                            color: AppColors.lightGrey
                                                .withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                      const CustomText(
                                        title:
                                            'Sed ut est eget dolor finibus mattis maximus hendrerit ex.',
                                        size: AppSize.intermediate,
                                        weight: FontWeight.w400,
                                        color: AppColors.lightGrey,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(5),
                                Expanded(
                                  child: SizedBox(
                                    height: height * 0.04,
                                    width: width * 0.15,
                                    child: CustomButton(
                                      onPressed: () {
                                        ticketSellDialog(context: context);
                                      },
                                      textColor: AppColors.white,
                                      textSize: AppSize.medium,
                                      btnText: 'Sell',
                                      gradient: customGradient,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )),
                  const Gap(15),
                  SizedBox(
                    height: height * 0.07,
                    width: width * 0.9,
                    child: CustomTextField(
                      borderColor: AppColors.silver.withOpacity(0.3),
                      hintText: 'Enter your comment here',
                      fillColor: AppColors.white,
                      isFilled: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: customGradient,
                          ),
                          child: Center(child: SvgPicture.asset(AppSvgs.send)),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.lightGrey),
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      const Gap(10),
                      const CustomText(
                        title: 'I need help (Alert Rave Trade Staff)',
                        color: AppColors.lightGrey,
                        weight: FontWeight.w400,
                        size: AppSize.medium,
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
