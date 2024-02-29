// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';

import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/auth_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

import '../components/components.dart';

class HomeDetailSecondScreen extends StatefulWidget {
  EventModal eventModal;
  TicketModel ticketModel;
  HomeDetailSecondScreen({
    Key? key,
    required this.eventModal,
    required this.ticketModel,
  }) : super(key: key);

  @override
  State<HomeDetailSecondScreen> createState() => _HomeDetailSecondScreenState();
}

class _HomeDetailSecondScreenState extends State<HomeDetailSecondScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: AppColors.pastelBlue.withOpacity(0.3),
      body: AppBackground(
        networkImage: widget.eventModal.imageUrl,
        isAssetImage: false,
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
                      Expanded(
                        child: CustomText(
                          title: widget.eventModal.festivalName,
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
                                      title: '${AppUtils.formatDate(
                                        widget.eventModal.date!,
                                      )}, ${widget.eventModal.time}',
                                      color:
                                          AppColors.lightGrey.withOpacity(0.6),
                                      size: AppSize.xsmall,
                                      weight: FontWeight.w400,
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: 'at ',
                                          style: TextStyle(
                                              color: AppColors.lightGrey
                                                  .withOpacity(0.6),
                                              fontSize: AppSize.xsmall,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: '${widget.eventModal.city}',
                                          style: const TextStyle(
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
                    title: widget.eventModal.description,
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
                  const Gap(25),
                  _tileContainer(
                    height: height * 0.08,
                    width: width * 0.9,
                    containerBorderColor: AppColors.blueViolet.withOpacity(0.8),
                    isSvg: true,
                    imagePath: AppSvgs.ticket,
                    backgroundColor: const Color(0XffF7F5FF),
                    avatarBg: AppColors.white,
                    title: '${widget.ticketModel.ticketType} TICKET AVAILABLE',
                    titleColor: AppColors.jetBlack,
                    titleSize: AppSize.small,
                    titleWeight: FontWeight.w600,
                    subTitle: 'VIP Seats + Exclusive braclets',
                    subTitleColor: AppColors.lightGrey.withOpacity(0.6),
                    subTitleSize: AppSize.xsmall,
                    subTitleWeight: FontWeight.w400,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: CustomText(
                        title: '\$ ${widget.ticketModel.price}',
                        color: const Color(0XffAC8AF7),
                        size: 18,
                        weight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Gap(25),
                  GestureDetector(
                    onTap: () {
                      sellerRatingDialog(context: context);
                    },
                    child: Container(
                      height: height * 0.1,
                      width: width,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Gap(7),
                          CircleAvatar(
                              backgroundImage:
                                  widget.ticketModel.imageUrl != null &&
                                          widget.ticketModel.imageUrl != 'null'
                                      ? NetworkImage(
                                          '${widget.ticketModel.imageUrl}')
                                      : const AssetImage(AppImages.profileImage)
                                          as ImageProvider),
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
                                    title:
                                        AuthServices.getCurrentUser.displayName,
                                    size: AppSize.intermediate,
                                    weight: FontWeight.w600,
                                    color:
                                        AppColors.lightBlack.withOpacity(0.5),
                                  ),
                                  CustomText(
                                    title: '(',
                                    color:
                                        AppColors.lightBlack.withOpacity(0.7),
                                  ),
                                  SvgPicture.asset(
                                    AppSvgs.fillStar,
                                    height: 13,
                                  ),
                                  CustomText(
                                    title: '4.7 )',
                                    color:
                                        AppColors.lightBlack.withOpacity(0.7),
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
                  ),
                  const Gap(25),
                  CustomTextField(
                    hintText: 'Offer you price',
                    hintStyle:
                        TextStyle(color: AppColors.lightBlack.withOpacity(0.5)),
                    fillColor: AppColors.white,
                    keyBoardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    suffixIcon: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          AppSvgs.dollarSign,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  SizedBox(
                      height: height * 0.07,
                      width: width * 0.9,
                      child: CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.commentScreen,
                            arguments: widget.eventModal.docId,
                          );
                        },
                        textColor: AppColors.white,
                        textSize: AppSize.regular,
                        btnText: 'Start Conversation',
                        gradient: customGradient,
                        weight: FontWeight.w700,
                      ))
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
                  padding: const EdgeInsets.only(left: 13, top: 13),
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
