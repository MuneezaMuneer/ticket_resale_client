// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CommentScreen extends StatefulWidget {
  final EventModalClient eventModal;
  final TicketModelClient ticketModal;
  final String price;

  const CommentScreen({
    Key? key,
    required this.eventModal,
    required this.ticketModal,
    required this.price,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ValueNotifier<bool> isDataSend = ValueNotifier<bool>(true);
  late Stream<List<CommentModel>> commentData;
  late String commentUserID;
  @override
  void initState() {
    super.initState();
    commentUserID = '';
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SwitchProvider>(context, listen: false).loadPreferences();
    });
    priceController.text = widget.price.trim();
    commentData = FireStoreServicesClient.fetchCommentsData(
        docId: widget.ticketModal.docId!);
  }

  @override
  void dispose() {
    commentController.dispose();
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
        isBackButton: true,
        isAssetImage: false,
        isCommentScreen: true,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: StreamBuilder(
              stream: FireStoreServicesClient.fetchUserData(
                  userId: widget.ticketModal.uid!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final ticketUserData = snapshot.data;
                  return StreamBuilder(
                    stream: commentData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data is List<CommentModel> &&
                          snapshot.data != null) {
                        final commentData = snapshot.data;
                        for (var comment in commentData!) {
                          commentUserID = comment.userId!;
                        }
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomText(
                                        title: 'Comments',
                                        size: AppFontSize.regular,
                                        color: AppColors.jetBlack,
                                        weight: FontWeight.w600,
                                      ),
                                      Row(
                                        children: [
                                          const CustomText(
                                            title: 'Subscribe to comments',
                                            size: AppFontSize.medium,
                                            weight: FontWeight.w400,
                                            color: AppColors.lightGrey,
                                          ),
                                          Consumer<SwitchProvider>(
                                            builder:
                                                (context, provider, child) {
                                              return Transform.scale(
                                                scale: 0.8,
                                                child: CupertinoSwitch(
                                                  activeColor:
                                                      AppColors.blueViolet,
                                                  thumbColor: Colors.white,
                                                  trackColor:
                                                      AppColors.pastelBlue,
                                                  value: provider.getComment,
                                                  onChanged: (bool value) {
                                                    provider.setComment(value);
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // commentData!.isEmpty
                            //     ? const Expanded(
                            //         child:
                            //             Center(child: Text('No Comment Here')))
                            //     :
                            Expanded(
                                child: ListView.builder(
                              itemCount: commentData.length,
                              itemBuilder: (context, index) {
                                Duration difference = DateTime.now()
                                    .difference(commentData[index].time!);
                                bool isExpired = difference.inHours > 3;

                                return StreamBuilder(
                                  stream: FireStoreServicesClient.fetchUserData(
                                      userId: commentUserID),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final userData = snapshot.data;
                                      bool isCurrentUserTicket =
                                          AuthServices.getCurrentUser.uid ==
                                              widget.ticketModal.uid;
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            userData!.photoUrl != null &&
                                                    userData.photoUrl !=
                                                        "null" &&
                                                    Uri.parse(
                                                            userData.photoUrl!)
                                                        .isAbsolute
                                                ? CustomDisplayStoryImage(
                                                    height: 43,
                                                    width: 43,
                                                    imageUrl:
                                                        '${userData.photoUrl}')
                                                : const CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        AppImages
                                                            .profileImage)),
                                            const Gap(7),
                                            Expanded(
                                              flex: 9,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CustomText(
                                                        title:
                                                            '${userData.displayName}',
                                                        size: AppFontSize
                                                            .intermediate,
                                                        weight: FontWeight.w600,
                                                        color:
                                                            AppColors.jetBlack,
                                                      ),
                                                      const Gap(5),
                                                      Container(
                                                        height: 5,
                                                        width: 5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .lightGrey
                                                              .withOpacity(0.7),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Gap(3),
                                                      CustomText(
                                                        title: AppUtils
                                                            .formatTimeAgo(
                                                                (commentData[
                                                                        index]
                                                                    .time!)),
                                                        size:
                                                            AppFontSize.xxsmall,
                                                        weight: FontWeight.w400,
                                                        color: AppColors
                                                            .lightGrey
                                                            .withOpacity(0.7),
                                                      ),
                                                    ],
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        const TextSpan(
                                                          text:
                                                              'Offered Price is',
                                                          style: TextStyle(
                                                            letterSpacing: 0.5,
                                                            color: AppColors
                                                                .lightGrey,
                                                            fontSize:
                                                                AppFontSize
                                                                    .small,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        const WidgetSpan(
                                                          child: SizedBox(
                                                              width: 5.0),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              commentData[index]
                                                                  .offerPrice,
                                                          style:
                                                              const TextStyle(
                                                            letterSpacing: 0.5,
                                                            color: AppColors
                                                                .lightBlack,
                                                            fontSize:
                                                                AppFontSize
                                                                    .small,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  CustomText(
                                                    title: commentData[index]
                                                        .comment,
                                                    size: AppFontSize
                                                        .intermediate,
                                                    weight: FontWeight.w400,
                                                    color: AppColors.lightGrey,
                                                    softWrap: true,
                                                  ),
                                                  const Gap(3),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: isCurrentUserTicket
                                                  ? isExpired
                                                      ? SizedBox(
                                                          height: height * 0.04,
                                                          child: CustomButton(
                                                            onPressed: () {},
                                                            textColor:
                                                                AppColors.white,
                                                            textSize:
                                                                AppFontSize
                                                                    .medium,
                                                            btnText: 'Expired',
                                                            gradient:
                                                                customGradient,
                                                            weight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: height * 0.04,
                                                          child: CustomButton(
                                                            onPressed: () {
                                                              String? hashKey =
                                                                  FireStoreServicesClient.getMessagesHashCodeID(
                                                                      userIDReceiver:
                                                                          userData
                                                                              .id!);
                                                              MessageModel
                                                                  messageModel =
                                                                  MessageModel(
                                                                message:
                                                                    "Hey, I hope you are good.You have to pay the '\$${commentData[index].offerPrice}' to purchase the '${widget.ticketModal.ticketType} TICKET' for festival '${widget.eventModal.eventName}'",
                                                                userIDReceiver:
                                                                    userData.id,
                                                                userIDSender:
                                                                    AuthServices
                                                                        .getCurrentUser
                                                                        .uid,
                                                              );
                                                              NotificationModel
                                                                  notificationModel =
                                                                  NotificationModel(
                                                                title:
                                                                    'Offer Accepted',
                                                                body:
                                                                    "Your offered price'\$${commentData[index].offerPrice}' for '${widget.ticketModal.ticketType} TICKET' is confirmed for festival '${widget.eventModal.eventName}'",
                                                                userId:
                                                                    userData.id,
                                                                id: AuthServices
                                                                    .getCurrentUser
                                                                    .uid,
                                                                status:
                                                                    'Unread',
                                                                notificationType:
                                                                    'offer_confirm',
                                                              );
                                                              TicketsSoldModel
                                                                  soldModel =
                                                                  TicketsSoldModel(
                                                                status:
                                                                    'Unpaid',
                                                                ticketPrice:
                                                                    commentData[
                                                                            index]
                                                                        .offerPrice,
                                                                ticketImage: widget
                                                                    .ticketModal
                                                                    .imageUrl,
                                                                ticketName: widget
                                                                    .ticketModal
                                                                    .ticketType,
                                                                buyerUid:
                                                                    '${userData.id}',
                                                              );
                                                              commentData[index]
                                                                          .status ==
                                                                      'Sell'
                                                                  ? ticketSellDialog(
                                                                      docId:
                                                                          '${widget.ticketModal.docId}',
                                                                      offerId:
                                                                          '${commentData[index].offerId}',
                                                                      context:
                                                                          context,
                                                                      ticketImage:
                                                                          '${widget.ticketModal.imageUrl}',
                                                                      offeredPrice:
                                                                          '${commentData[index].offerPrice}',
                                                                      buyerImage:
                                                                          '${userData.photoUrl}',
                                                                      buyerName:
                                                                          '${userData.displayName}',
                                                                      messageModel:
                                                                          messageModel,
                                                                      userModel:
                                                                          userData,
                                                                      hashKey:
                                                                          hashKey,
                                                                      soldModel:
                                                                          soldModel,
                                                                      buyerId:
                                                                          '${userData.id}',
                                                                      token:
                                                                          '${userData.fcmToken}',
                                                                      title:
                                                                          'Offer Accepted',
                                                                      body:
                                                                          "Your offered price'\$${commentData[index].offerPrice}' for '${widget.ticketModal.ticketType} TICKET' is confirmed for festival '${widget.eventModal.eventName}'",
                                                                      notificationModel:
                                                                          notificationModel)
                                                                  : Navigator.pushNamedAndRemoveUntil(
                                                                      context,
                                                                      AppRoutes
                                                                          .chatDetailScreen,
                                                                      (route) =>
                                                                          false,
                                                                      arguments: {
                                                                          'receiverId':
                                                                              messageModel.userIDReceiver,
                                                                          'hashKey':
                                                                              hashKey,
                                                                          'userModel':
                                                                              userData,
                                                                          'isOpened':
                                                                              true,
                                                                          'offeredPrice':
                                                                              commentData[index].offerPrice
                                                                        });
                                                            },
                                                            textColor:
                                                                AppColors.white,
                                                            textSize:
                                                                AppFontSize
                                                                    .medium,
                                                            btnText:
                                                                commentData[
                                                                        index]
                                                                    .status,
                                                            gradient:
                                                                customGradient,
                                                            weight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                  : const SizedBox.shrink(),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CupertinoActivityIndicator(),
                                      );
                                    }
                                  },
                                );
                              },
                            )),
                            const Gap(15),
                            SizedBox(
                                child:
                                    AuthServices.getCurrentUser.uid !=
                                            widget.ticketModal.uid
                                        ? Align(
                                            alignment:
                                                AlignmentDirectional.bottomEnd,
                                            child: ValueListenableBuilder<bool>(
                                              valueListenable: isDataSend,
                                              builder: (context, value, child) {
                                                return SizedBox(
                                                  child: value
                                                      ? Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Expanded(
                                                                  child:
                                                                      CustomTextField(
                                                                    readOnly:
                                                                        true,
                                                                    hintText:
                                                                        'Offered price is:',
                                                                    fillColor:
                                                                        AppColors
                                                                            .white,
                                                                    isFilled:
                                                                        true,
                                                                  ),
                                                                ),
                                                                const Gap(15),
                                                                Expanded(
                                                                  child:
                                                                      CustomTextField(
                                                                    controller:
                                                                        priceController,
                                                                    fillColor:
                                                                        AppColors
                                                                            .white,
                                                                    isFilled:
                                                                        true,
                                                                    keyBoardType:
                                                                        TextInputType
                                                                            .number,
                                                                    inputFormatters: <TextInputFormatter>[
                                                                      FilteringTextInputFormatter
                                                                          .allow(
                                                                              RegExp(r'[0-9]')),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Gap(15),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.9,
                                                              child:
                                                                  CustomTextField(
                                                                controller:
                                                                    commentController,
                                                                hintText:
                                                                    'Enter your comment here',
                                                                fillColor:
                                                                    AppColors
                                                                        .white,
                                                                isFilled: true,
                                                                suffixIcon:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    height: 35,
                                                                    width: 35,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      gradient:
                                                                          customGradient,
                                                                    ),
                                                                    child: InkWell(
                                                                        onTap: () async {
                                                                          CommentModel commentModel = CommentModel(
                                                                              comment: commentController.text,
                                                                              userId: AuthServices.getCurrentUser.uid,
                                                                              time: DateTime.now(),
                                                                              status: 'Sell',
                                                                              offerPrice: priceController.text);
                                                                          await FireStoreServicesClient.createChatSystem(
                                                                              commentModel: commentModel,
                                                                              docId: widget.ticketModal.docId!);
                                                                          await NotificationServices.sendNotification(
                                                                              token: ticketUserData!.fcmToken!,
                                                                              title: 'Offered Price',
                                                                              body: '${AuthServices.getCurrentUser.displayName} offered a price "${priceController.text}" for event "${widget.eventModal.eventName}"',
                                                                              data: {});

                                                                          isDataSend.value =
                                                                              false;
                                                                          commentController.text =
                                                                              '';
                                                                          priceController.text =
                                                                              '';
                                                                        },
                                                                        child: Center(child: SvgPicture.asset(AppSvgs.send))),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : const Center(
                                                          child: CustomText(
                                                            title:
                                                                'Your offer is submitted',
                                                            size: AppFontSize
                                                                .regular,
                                                            color: AppColors
                                                                .jetBlack,
                                                          ),
                                                        ),
                                                );
                                              },
                                            ),
                                          )
                                        : const SizedBox.shrink()),
                            const Gap(10),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(
                                          color: AppColors.lightGrey),
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                const Gap(10),
                                const CustomText(
                                  title: 'I need help (Alert Rave Trade Staff)',
                                  color: AppColors.lightGrey,
                                  weight: FontWeight.w400,
                                  size: AppFontSize.medium,
                                )
                              ],
                            )
                          ],
                        );
                      } else {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                    },
                  );
                } else {
                  return SizedBox();
                }
              },
            )),
      ),
    );
  }
}
