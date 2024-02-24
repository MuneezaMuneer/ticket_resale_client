// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';

import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

import '../components/components.dart';

class HomeDetailFirstScreen extends StatelessWidget {
  String id;
  String festivalName;
  HomeDetailFirstScreen({
    Key? key,
    required this.id,
    required this.festivalName,
  }) : super(key: key);

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
              padding: const EdgeInsets.only(left: 23, top: 20, right: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: festivalName,
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
                  const Gap(15),
                  Container(
                    height: height * 0.08,
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
                              CircleAvatar(
                                  backgroundColor: AppColors.paleGrey,
                                  radius: 20,
                                  child: SvgPicture.asset(
                                    AppSvgs.clock,
                                    height: 30,
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title: '25th Jan 2024, 08:00pm -11:00pm',
                                      color:
                                          AppColors.lightGrey.withOpacity(0.6),
                                      size: AppSize.xsmall,
                                      weight: FontWeight.w400,
                                    ),
                                    const Gap(5),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: 'at ',
                                          style: TextStyle(
                                              color: AppColors.lightGrey
                                                  .withOpacity(0.6),
                                              fontSize: AppSize.xsmall,
                                              fontWeight: FontWeight.w400)),
                                      const TextSpan(
                                          text: 'at Global Village Dubai, UAE',
                                          style: TextStyle(
                                              color: AppColors.jetBlack,
                                              fontSize: AppSize.small,
                                              fontWeight: FontWeight.w600)),
                                    ])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  const CustomText(
                    title: 'About Event',
                    size: AppSize.regular,
                    weight: FontWeight.w600,
                    color: AppColors.jetBlack,
                  ),
                  CustomText(
                    title: id,
                    size: AppSize.medium,
                    softWrap: true,
                    weight: FontWeight.w400,
                    color: AppColors.lightGrey,
                  ),
                  const Gap(20),
                  const CustomText(
                    title: 'Tickets Available by Sellers',
                    size: AppSize.regular,
                    weight: FontWeight.w600,
                    color: AppColors.jetBlack,
                  ),
                  const Gap(15),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemExtent: 140,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.detailSecondScreen);
                          },
                          child: _tileContainer(
                            title: 'VIP PLUS TICKET AVAILABLE',
                            subTitle: 'VIP Seats + Exclusive braclets',
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tileContainer({
    String? title,
    String? subTitle,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.blueViolet)),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0XffF7F5FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: CircleAvatar(
                              backgroundColor: AppColors.white,
                              radius: 20,
                              child: SvgPicture.asset(
                                AppSvgs.ticket,
                                height: 25,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: '$title',
                                color: AppColors.jetBlack,
                                size: AppSize.small,
                                weight: FontWeight.w600,
                              ),
                              CustomText(
                                title: '$subTitle',
                                color: AppColors.lightGrey.withOpacity(0.6),
                                size: AppSize.xsmall,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: CustomText(
                      title: '\$ 500',
                      color: Color(0XffAC8AF7),
                      size: 18,
                      weight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(AppImages.profile),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: 'Sell by',
                                color: AppColors.lightBlack.withOpacity(0.7),
                                size: AppSize.verySmall,
                                weight: FontWeight.w300,
                              ),
                              CustomText(
                                title: 'Ralph Edwards',
                                color: AppColors.lightBlack.withOpacity(0.6),
                                size: AppSize.intermediate,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SvgPicture.asset(AppSvgs.levelFour))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
