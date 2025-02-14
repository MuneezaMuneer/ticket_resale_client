// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class ChatDetailScreen extends StatefulWidget {
  String receiverId;
  String hashKey;
  final bool isOpened;
  ChatDetailScreen({
    Key? key,
    required this.receiverId,
    required this.hashKey,
    required this.isOpened,
  }) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  TextEditingController chatController = TextEditingController();
  late Stream<UserModelClient> fetchUserData;
  @override
  void initState() {
    fetchUserData =
        FireStoreServicesClient.fetchUserData(userId: widget.receiverId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //  final double height = size.height;
    final double width = size.width;
    return PopScope(
      canPop: !widget.isOpened,
      onPopInvoked: (value) async {
        if (widget.isOpened) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.navigationScreen, (route) => false);
        }
      },
      child: StreamBuilder(
        stream: fetchUserData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData) {
            final userModel = snapshot.data;
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              child: Scaffold(
                appBar: CustomAppBarClient(
                  title: '${userModel!.displayName}',
                  isNotification: false,
                  isNetworkImage: true,
                  isOpenedFromDialog: widget.isOpened,
                  networkImage: userModel.photoUrl,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<List<MessageModel>>(
                          stream: FireStoreServicesClient.getMessagesChat(
                              widget.hashKey),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<MessageModel> messages = snapshot.data!;

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: GroupedListView<MessageModel, dynamic>(
                                  elements: messages,
                                  reverse: true,
                                  order: GroupedListOrder.DESC,
                                  groupBy: (element) {
                                    return AppUtils.convertDateTimeToMMMMDY(
                                        dateTime: element.time);
                                  },
                                  groupSeparatorBuilder: (groupByValue) =>
                                      Center(
                                          child: Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  color: AppColors.lightGrey),
                                              child: Center(
                                                  child: CustomText(
                                                title: groupByValue,
                                                color: AppColors.white,
                                              )))),
                                  itemBuilder: (context, dynamic element) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Align(
                                        alignment: element.userIDReceiver !=
                                                AuthServices.getCurrentUser.uid
                                            ? Alignment.topRight
                                            : Alignment.topLeft,
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minWidth: 40,
                                            maxWidth: width * 0.7,
                                          ),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(10),
                                              color: AppColors.paleGrey,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    softWrap: true,
                                                    title: '${element.message}',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  CustomText(
                                                    softWrap: true,
                                                    title: AppUtils
                                                        .convertDateTimeToOnlyTime(
                                                            element.time! ??
                                                                DateTime.now()),
                                                    color: AppColors.lightBlack
                                                        .withOpacity(0.6),
                                                    size: AppFontSize.xxsmall,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              log('Error loading messages: ${snapshot.error}');
                              return Center(
                                child: Text(
                                    'Error loading messages: ${snapshot.error}'),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      const Gap(30),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: CustomTextField(
                                controller: chatController,
                                hintText: 'Enter your message here',
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
                                    child: InkWell(
                                        onTap: () async {
                                          MessageModel messageModel =
                                              MessageModel(
                                            message: chatController.text,
                                            userIDReceiver: widget.receiverId,
                                            userIDSender:
                                                AuthServices.getCurrentUser.uid,
                                          );
                                          if (chatController.text.isNotEmpty) {
                                            await FireStoreServicesClient
                                                .createMessageChat(
                                                    messageModel: messageModel,
                                                    hashKey: widget.hashKey);
                                            chatController.text = '';
                                          }
                                        },
                                        child: Center(
                                            child: SvgPicture.asset(
                                                AppSvgs.send))),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                                flex: 2,
                                child: CustomButton(
                                  onPressed: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    CustomBottomSheet.showConfirmTicketsSheet(
                                        context: context,
                                        hashKey: widget.hashKey,
                                        userModel: userModel);
                                  },
                                  textColor: AppColors.white,
                                  textSize: AppFontSize.regular,
                                  gradient: customGradient,
                                  btnText: 'Buy',
                                  weight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold(body: Center(child: Text('No Data')));
          }
        },
      ),
    );
  }
}
