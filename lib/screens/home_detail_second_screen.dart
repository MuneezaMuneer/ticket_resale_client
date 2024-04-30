// ignore_for_file: must_be_immutable, use_build_context_synchronously, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';
import '../models/models.dart';

class HomeDetailSecondScreen extends StatefulWidget {
  String eventId;
  String ticketId;
  String ticketUserId;
  HomeDetailSecondScreen({
    Key? key,
    required this.ticketUserId,
    required this.eventId,
    required this.ticketId,
  }) : super(key: key);
  @override
  State<HomeDetailSecondScreen> createState() => _HomeDetailSecondScreenState();
}

class _HomeDetailSecondScreenState extends State<HomeDetailSecondScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  late Stream<List<TicketModelClient>> displayTickets;
  late Stream<EventModalClient> fetchEvents;
  late String networkImage;
  late String userId;
  late String name;
  late Map<String, dynamic> averages;
  late double averageRating;
  late String averageExperience;
  late String averageArrivalTime;
  late String averageCommunicationResponse;
  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    displayTickets =
        FireStoreServicesClient.fetchTicketsData(docID: widget.eventId);
    fetchEvents = FireStoreServicesClient.fetchEventDataBasedOnId(
        eventId: widget.eventId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: AppColors.pastelBlue.withOpacity(0.3),
      body: StreamBuilder(
        stream: fetchEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData) {
            final EventModalClient? eventData = snapshot.data;
            return StreamBuilder(
              stream: displayTickets,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (snapshot.hasData) {
                  final ticketData = snapshot.data;

                  return AppBackground(
                    networkImage: '${eventData!.imageUrl}',
                    isAssetImage: false,
                    isBackButton: true,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 10, bottom: 20, right: 15),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 30),
                                child: CustomText(
                                  title: '${eventData.eventName}',
                                  size: AppFontSize.large,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: AppColors.paleGrey,
                                            radius: 17,
                                            backgroundImage: AssetImage(
                                                AppImages.profileImage),
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
                                                      fontSize:
                                                          AppFontSize.xsmall,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              TextSpan(
                                                  text: '${eventData.djName}',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.blueViolet,
                                                      fontSize:
                                                          AppFontSize.medium,
                                                      fontWeight:
                                                          FontWeight.w600)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  AppColors.paleGrey,
                                              radius: 20,
                                              child: SvgPicture.asset(
                                                AppSvgs.clock,
                                                height: 30,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12, top: 7, bottom: 7),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  title:
                                                      '${AppUtils.formatDatee('${eventData.date}')}, ${eventData.time}',
                                                  color: AppColors.lightGrey
                                                      .withOpacity(0.6),
                                                  size: AppFontSize.xsmall,
                                                  weight: FontWeight.w400,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.65,
                                                  child: RichText(
                                                      text: TextSpan(children: [
                                                    TextSpan(
                                                        text: 'at ',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .lightGrey
                                                                .withOpacity(
                                                                    0.6),
                                                            letterSpacing: 0.8,
                                                            fontSize:
                                                                AppFontSize
                                                                    .xsmall,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                    TextSpan(
                                                        text:
                                                            '${eventData.location}',
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .jetBlack,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            letterSpacing: 0.8,
                                                            fontSize:
                                                                AppFontSize
                                                                    .small,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
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
                                size: AppFontSize.regular,
                                weight: FontWeight.w600,
                                color: AppColors.jetBlack,
                              ),
                              CustomText(
                                title: '${eventData.description}',
                                size: AppFontSize.medium,
                                softWrap: true,
                                weight: FontWeight.w400,
                                color: AppColors.lightGrey,
                              ),
                              const Gap(20),
                              const CustomText(
                                title: 'Available Tickets',
                                size: AppFontSize.regular,
                                weight: FontWeight.w600,
                                color: AppColors.jetBlack,
                              ),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  clipBehavior: Clip.hardEdge,
                                  shrinkWrap: false,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: ticketData!.length,
                                  itemBuilder: (context, index) {
                                    return _tileContainer(
                                      height: height * 0.08,
                                      width: width * 0.9,
                                      containerBorderColor:
                                          AppColors.blueViolet.withOpacity(0.8),
                                      imagePath:
                                          '${ticketData[index].imageUrl}',
                                      backgroundColor: const Color(0XffF7F5FF),
                                      avatarBg: AppColors.white,
                                      title:
                                          '${ticketData[index].ticketType} TICKET AVAILABLE',
                                      titleColor: AppColors.jetBlack,
                                      titleSize: AppFontSize.small,
                                      titleWeight: FontWeight.w600,
                                      subTitle:
                                          'VIP Seats + Exclusive braclets',
                                      subTitleColor:
                                          AppColors.lightGrey.withOpacity(0.6),
                                      subTitleSize: AppFontSize.xsmall,
                                      subTitleWeight: FontWeight.w400,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 7),
                                        child: CustomText(
                                          title: '${ticketData[index].price}',
                                          color: const Color(0XffAC8AF7),
                                          size: 18,
                                          weight: FontWeight.w900,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Gap(25),
                              GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();

                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {
                                    sellerRatingDialog(
                                      context: context,
                                      networkImage: networkImage,
                                      name: name,
                                      userId: userId,
                                    );
                                  });
                                },
                                child: StreamBuilder(
                                  stream: FireStoreServicesClient.fetchUserData(
                                      userId: widget.ticketUserId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final userData = snapshot.data!;
                                      networkImage = userData.photoUrl ?? '';
                                      name = userData.displayName ?? '';
                                      userId = userData.id ?? '';

                                      return StreamBuilder(
                                        stream: FireStoreServicesClient
                                            .fetchFeedback(userId: userId),
                                        builder: (context, ratingSnapshot) {
                                          if (ratingSnapshot.hasData) {
                                            return FutureBuilder<
                                                Map<String, dynamic>>(
                                              future: FireStoreServicesClient
                                                  .calculateAverages(
                                                      ratingSnapshot.data),
                                              builder: (context,
                                                  averageRatingSnapshot) {
                                                if (averageRatingSnapshot
                                                    .hasData) {
                                                  averages =
                                                      averageRatingSnapshot
                                                          .data!;
                                                  averageRating =
                                                      averages['rating'] ?? 0.0;
                                                  averageExperience =
                                                      averages['experience'] ??
                                                          '';
                                                  averageArrivalTime = averages[
                                                          'arrival_time'] ??
                                                      '';
                                                  averageCommunicationResponse =
                                                      averages[
                                                              'communication_response'] ??
                                                          '';

                                                  return Container(
                                                    height: height * 0.1,
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Gap(10),
                                                        SizedBox(
                                                          child: userData.photoUrl !=
                                                                      null &&
                                                                  userData
                                                                      .photoUrl!
                                                                      .isNotEmpty
                                                              ? CustomDisplayStoryImage(
                                                                  imageUrl: userData
                                                                      .photoUrl!,
                                                                  height: 45,
                                                                  width: 45,
                                                                )
                                                              : CircleAvatar(
                                                                  backgroundImage:
                                                                      const AssetImage(
                                                                          AppImages
                                                                              .profileImage),
                                                                ),
                                                        ),
                                                        const Gap(15),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  width > 370
                                                                      ? 14
                                                                      : 5,
                                                            ),
                                                            CustomText(
                                                              title: 'Sell by',
                                                              size: AppFontSize
                                                                  .verySmall,
                                                              weight: FontWeight
                                                                  .w300,
                                                              color: AppColors
                                                                  .lightBlack
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            Row(
                                                              children: [
                                                                CustomText(
                                                                  title: userData
                                                                      .displayName!,
                                                                  size: AppFontSize
                                                                      .intermediate,
                                                                  weight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .lightBlack
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                                CustomText(
                                                                  title: '(',
                                                                  color: AppColors
                                                                      .lightBlack
                                                                      .withOpacity(
                                                                          0.7),
                                                                ),
                                                                SvgPicture
                                                                    .asset(
                                                                  AppSvgs
                                                                      .fillStar,
                                                                  height: 13,
                                                                ),
                                                                CustomText(
                                                                  title: averageRating
                                                                      .toStringAsFixed(
                                                                          1),
                                                                  color: AppColors
                                                                      .lightBlack
                                                                      .withOpacity(
                                                                          0.7),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  width > 370
                                                                      ? 4
                                                                      : 0,
                                                            ),
                                                            Row(
                                                              children: [
                                                                CustomText(
                                                                  title: '23',
                                                                  size: AppFontSize
                                                                      .intermediate,
                                                                  weight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                                const Gap(2),
                                                                CustomText(
                                                                  title:
                                                                      'Ticket Sold',
                                                                  size: AppFontSize
                                                                      .xxsmall,
                                                                  weight:
                                                                      FontWeight
                                                                          .w400,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 45),
                                                          child: SizedBox(
                                                            height: 45,
                                                            width: 45,
                                                            child: ProfileLevelImage(
                                                                profileLevelsFuture:
                                                                    FireStoreServicesClient
                                                                        .fetchProfileLevels(
                                                                            userId:
                                                                                userData.id!)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                } else if (averageRatingSnapshot
                                                    .hasError) {
                                                  return Text(
                                                      'Error: ${averageRatingSnapshot.error}');
                                                } else {
                                                  return Text('');
                                                }
                                              },
                                            );
                                          } else {
                                            return CupertinoActivityIndicator();
                                          }
                                        },
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return const Text('');
                                    }
                                  },
                                ),
                              ),
                              const Gap(25),
                              SizedBox(
                                child: AuthServices.getCurrentUser.uid !=
                                        widget.ticketId
                                    ? StreamBuilder(
                                        stream: FireStoreServicesClient
                                            .fetchCommentUserLength(
                                                docId: widget.ticketId),
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
                                                keyBoardType:
                                                    TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                ],
                                                suffixIcon: InkWell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: SvgPicture.asset(
                                                      AppSvgs.dollarSign,
                                                    ),
                                                  ),
                                                ),
                                                validator: (price) {
                                                  if (price == null ||
                                                      price.isEmpty) {
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
                                            // 'eventModal': widget.eventModal,
                                            //   'ticketModal': widget.ticketModel,
                                            'price': priceController.text.trim()
                                          },
                                        );
                                      }
                                    },
                                    textColor: AppColors.white,
                                    textSize: AppFontSize.regular,
                                    btnText: 'Start Conversation',
                                    gradient: customGradient,
                                    weight: FontWeight.w700,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text('No Ticket Yet'),
                  );
                }
              },
            );
          } else {
            return const Center(child: Text('No Event Yet'));
          }
        },
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
