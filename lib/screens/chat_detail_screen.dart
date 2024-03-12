// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/screens/screens.dart';
import 'package:ticket_resale/utils/app_utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

import '../models/message_model.dart';

class ChatDetailScreen extends StatelessWidget {
  String receiverId;
  String hashKey;
  UserModel userModel;
  ChatDetailScreen({
    Key? key,
    required this.receiverId,
    required this.hashKey,
    required this.userModel,
  }) : super(key: key);
  TextEditingController chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: userModel.displayName,
        isNotification: false,
        isNetworkImage: true,
        networkImage: userModel.photoUrl,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: FireStoreServices.getMessagesChat(hashKey),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<MessageModel> messages = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: GroupedListView<MessageModel, dynamic>(
                        elements: messages,
                        reverse: true,
                        order: GroupedListOrder.DESC,
                        groupBy: (element) {
                          return AppUtils.convertDateTimeToMMMMDY(
                              dateTime: element.time);
                        },
                        groupSeparatorBuilder: (groupByValue) => Center(
                            child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: AppColors.lightGrey),
                                child: Center(child: Text(groupByValue)))),
                        itemBuilder: (context, dynamic element) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                                        BorderRadiusDirectional.circular(10),
                                    color: AppColors.paleGrey,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
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
                                          size: AppSize.xxsmall,
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
                      child: Text('Error loading messages: ${snapshot.error}'),
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
                                MessageModel messageModel = MessageModel(
                                  message: chatController.text,
                                  userIDReceiver: receiverId,
                                  userIDSender: AuthServices.getCurrentUser.uid,
                                );
                                if (chatController.text.isNotEmpty) {
                                  await FireStoreServices.createMessageChat(
                                      messageModel: messageModel,
                                      hashKey: hashKey);
                                  chatController.text = '';
                                }
                              },
                              child: Center(
                                  child: SvgPicture.asset(AppSvgs.send))),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      onPressed: () async {
                        PaypalPaymentServices paypalServices =
                            PaypalPaymentServices();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PaymentScreen(
                              onFinish: (paymentId) async {
                                paypalServices
                                    .fetchPaymentDetails("$paymentId");
                                final snackBar = SnackBar(
                                  content:
                                      const Text("Payment done Successfully"),
                                  duration: const Duration(seconds: 5),
                                  action: SnackBarAction(
                                    label: 'Close',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            ),
                          ),
                        );
                      },
                      textColor: AppColors.white,
                      textSize: AppSize.regular,
                      gradient: customGradient,
                      btnText: 'Buy',
                      weight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
