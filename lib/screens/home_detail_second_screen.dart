// ignore_for_file: must_be_immutable, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';
import '../components/components.dart';
import '../models/models.dart';

class HomeDetailSecondScreen extends StatefulWidget {
  EventModalClient eventModal;
  TicketModelClient ticketModel;
  HomeDetailSecondScreen({
    Key? key,
    required this.eventModal,
    required this.ticketModel,
  }) : super(key: key);
  @override
  State<HomeDetailSecondScreen> createState() => _HomeDetailSecondScreenState();
}

class _HomeDetailSecondScreenState extends State<HomeDetailSecondScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController priceController = TextEditingController();
  late String networkImage;
  late String name;

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

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
          padding:
              const EdgeInsets.only(left: 15, top: 10, bottom: 20, right: 15),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 30),
                    child: CustomText(
                      title: widget.eventModal.eventName,
                      size: AppSize.large,
                      weight: FontWeight.w600,
                      softWrap: true,
                      color: AppColors.jetBlack,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const Gap(40),
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
                                padding: const EdgeInsets.only(
                                    left: 12, top: 7, bottom: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title:
                                          '${AppUtils.formatDatee(widget.eventModal.date!)}, ${widget.eventModal.time}',
                                      color:
                                          AppColors.lightGrey.withOpacity(0.6),
                                      size: AppSize.xsmall,
                                      weight: FontWeight.w400,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: 'at ',
                                            style: TextStyle(
                                                color: AppColors.lightGrey
                                                    .withOpacity(0.6),
                                                letterSpacing: 0.8,
                                                fontSize: AppSize.xsmall,
                                                fontWeight: FontWeight.w400)),
                                        TextSpan(
                                            text:
                                                '${widget.eventModal.location}',
                                            style: const TextStyle(
                                                color: AppColors.jetBlack,
                                                overflow: TextOverflow.ellipsis,
                                                letterSpacing: 0.8,
                                                fontSize: AppSize.small,
                                                fontWeight: FontWeight.w600)),
                                      ])),
                                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        title: 'Available Tickets',
                        size: AppSize.regular,
                        weight: FontWeight.w600,
                        color: AppColors.jetBlack,
                      ),
                      InkWell(
                        onTap: () {
                      
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: CustomText(
                            title: 'Feedback',
                            size: AppSize.medium,
                            weight: FontWeight.w400,
                            color: AppColors.jetBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(25),
                  _tileContainer(
                    height: height * 0.08,
                    width: width * 0.9,
                    containerBorderColor: AppColors.blueViolet.withOpacity(0.8),
                    imagePath: widget.ticketModel.imageUrl,
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
                      padding: const EdgeInsets.only(right: 7),
                      child: CustomText(
                        title: '${widget.ticketModel.price}',
                        color: const Color(0XffAC8AF7),
                        size: 18,
                        weight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Gap(25),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      Future.delayed(const Duration(milliseconds: 300), () {
                        sellerRatingDialog(
                            context: context,
                            networkImage: networkImage,
                            name: name);
                      });
                    },
                    child: StreamBuilder(
                      stream: FireStoreServicesClient.fetchUserData(
                          userId: widget.ticketModel.uid!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final userData = snapshot.data!;
                          networkImage = '${userData.photoUrl}';
                          name = userData.displayName!;
                          return Container(
                              height: height * 0.1,
                              width: width,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Gap(7),
                                  SizedBox(
                                    child: (userData.photoUrl != null) &&
                                            userData.photoUrl != 'null'
                                        ? CustomDisplayStoryImage(
                                            imageUrl: '${userData.photoUrl}',
                                            height: 45,
                                            width: 45,
                                          )
                                        : CircleAvatar(
                                            backgroundImage: const AssetImage(
                                                AppImages.profileImage)),
                                  ),
                                  const Gap(9),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: width > 370 ? 14 : 5,
                                      ),
                                      CustomText(
                                        title: 'Sell by',
                                        size: AppSize.verySmall,
                                        weight: FontWeight.w300,
                                        color: AppColors.lightBlack
                                            .withOpacity(0.7),
                                      ),
                                      Row(
                                        children: [
                                          CustomText(
                                            title: '${userData.displayName}',
                                            size: AppSize.intermediate,
                                            weight: FontWeight.w600,
                                            color: AppColors.lightBlack
                                                .withOpacity(0.5),
                                          ),
                                          CustomText(
                                            title: '(',
                                            color: AppColors.lightBlack
                                                .withOpacity(0.7),
                                          ),
                                          SvgPicture.asset(
                                            AppSvgs.fillStar,
                                            height: 13,
                                          ),
                                          CustomText(
                                            title: '4.7 )',
                                            color: AppColors.lightBlack
                                                .withOpacity(0.7),
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
                                    width: width > 370
                                        ? width * 0.15
                                        : width * 0.11,
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SvgPicture.asset(
                                            AppSvgs.levelThree),
                                      ))
                                ],
                              ));
                        } else {
                          return const Text('');
                        }
                      },
                    ),
                  ),
                  const Gap(25),
                  SizedBox(
                    child: AuthServices.getCurrentUser.uid !=
                            widget.ticketModel.uid
                        ? StreamBuilder(
                            stream:
                                FireStoreServicesClient.fetchCommentUserLength(
                                    docId: widget.ticketModel.docId!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int length = snapshot.data!;

                                if (length > 0) {
                                  return const SizedBox.shrink();
                                } else {
                                  return CustomTextField(
                                    controller: priceController,
                                    hintText: 'Offer your price',
                                    hintStyle: TextStyle(
                                        color: AppColors.lightBlack
                                            .withOpacity(0.5)),
                                    fillColor: AppColors.white,
                                    keyBoardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    suffixIcon: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: SvgPicture.asset(
                                          AppSvgs.dollarSign,
                                        ),
                                      ),
                                    ),
                                    validator: (price) {
                                      if (price == null || price.isEmpty) {
                                        return 'Please enter price';
                                      } else {
                                        return null;
                                      }
                                    },
                                  );
                                }
                              } else {
                                return const CupertinoActivityIndicator();
                              }
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  SizedBox(
                      height: height * 0.07,
                      width: width * 0.9,
                      child: CustomButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Navigator.popAndPushNamed(
                              context,
                              AppRoutes.commentScreen,
                              arguments: {
                                'eventModal': widget.eventModal,
                                'ticketModal': widget.ticketModel,
                                'price': priceController.text.trim()
                              },
                            );
                          }
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
    Color? backgroundColor,
    Color? avatarBg,
    String? imagePath,
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
                SizedBox(
                    child: (imagePath != null) && imagePath != 'null'
                        ? CustomDisplayStoryImage(
                            imageUrl: imagePath,
                            height: 35,
                            width: 35,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                const AssetImage(AppImages.profileImage))),
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
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: SizedBox(
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
