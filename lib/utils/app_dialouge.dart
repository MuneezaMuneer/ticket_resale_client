import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/app_routes.dart';
import 'package:ticket_resale/constants/app_colors.dart';
import 'package:ticket_resale/constants/app_images.dart';
import 'package:ticket_resale/constants/app_textsize.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/providers/bottom_sheet_provider.dart';
import 'package:ticket_resale/utils/notification_services.dart';
import 'package:ticket_resale/widgets/widgets.dart';

deleteDialog({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        backgroundColor: AppColors.white,
        titlePadding: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
        title: Column(
          children: [
            SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  AppImages.personBold,
                  fit: BoxFit.cover,
                )),
            const CustomText(
              title: 'Delete Account',
              color: AppColors.jetBlack,
              size: AppSize.large,
              weight: FontWeight.w900,
            ),
            const Gap(20),
            CustomText(
              title: 'Are you sure to delete your account.',
              color: AppColors.jetBlack.withOpacity(0.8),
              size: AppSize.medium,
              weight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            CustomText(
              title: 'Account will be permanently deleted.',
              color: AppColors.jetBlack.withOpacity(0.8),
              size: AppSize.medium,
              weight: FontWeight.w400,
              textAlign: TextAlign.center,
            )
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  btnText: 'Cancel',
                  backgroundColor: AppColors.white,
                  borderColor: AppColors.jetBlack,
                  textColor: AppColors.jetBlack,
                  weight: FontWeight.w700,
                  textSize: AppSize.regular,
                ),
              ),
              SizedBox(
                height: 50,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    AuthServices.deleteUserAccount().then((user) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.logIn, (route) => false);
                    });
                  },
                  btnText: 'Delete',
                  backgroundColor: AppColors.raddishPink,
                  borderColor: AppColors.raddishPink,
                  textColor: AppColors.white,
                  weight: FontWeight.w900,
                  textSize: AppSize.regular,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

sellerRatingDialog(
    {required BuildContext context,
    required String networkImage,
    required String name,
    required String userId}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        titlePadding: EdgeInsets.zero,
        backgroundColor: AppColors.white,
        title: Column(
          children: [
            const Gap(20),
            Stack(
              children: [
                SizedBox(
                    height: 140,
                    width: 140,
                    child: AuthServices.getCurrentUser.photoURL != null &&
                            AuthServices.getCurrentUser.photoURL!.isNotEmpty &&
                            networkImage != 'null'
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: networkImage,
                              placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(
                                color: AppColors.blueViolet,
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const CircleAvatar(
                            backgroundImage:
                                AssetImage(AppImages.profileImage))),
                Positioned(
                  left: 90,
                  top: 70,
                  child: ProfileLevelImage(
                      profileLevelsFuture:
                          FireStoreServicesClient.fetchProfileLevels(
                              userId: userId)),
                ),
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            CustomText(
              title: name,
              weight: FontWeight.w600,
              size: AppSize.large,
              color: AppColors.jetBlack,
            ),
            const SizedBox(
              height: 5,
            ),
             CustomRow(userId: userId,),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: AppColors.lightGrey.withOpacity(0.6),
            ),
            const Gap(20),
            const CustomText(
              title: 'Detailed Seller Ratings',
              color: AppColors.jetBlack,
              size: AppSize.regular,
              weight: FontWeight.w700,
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: StreamBuilder(
                stream: FireStoreServicesClient.fetchFeedback(userId: userId),
                builder: (context, snapshot) {
                  return FutureBuilder<Map<String, dynamic>>(
                    future: FireStoreServicesClient.calculateAverages(
                        snapshot.data),
                    builder: (context, ratingSsnapshot) {
                      if (ratingSsnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CupertinoActivityIndicator();
                      } else if (ratingSsnapshot.hasData) {
                        final Map<String, dynamic> averages =
                            ratingSsnapshot.data!;
                        final double averageRating = averages['rating'] ?? 0.0;
                        final String averageExperience =
                            averages['experience'] ?? '';
                        final String averageArrivalTime =
                            averages['arrival_time'] ?? '';
                        final String averageCommunicationResponse =
                            averages['communication_response'] ?? '';
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  title: 'Avg. ratings?',
                                  color: AppColors.lightGrey,
                                  size: 11,
                                  weight: FontWeight.w600,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppSvgs.fillStar,
                                      height: 12,
                                    ),
                                    const Gap(5),
                                    CustomText(
                                      title: averageRating.toStringAsFixed(1),
                                      weight: FontWeight.w500,
                                      color: AppColors.jetBlack,
                                      size: AppSize.small,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Gap(10),
                            buildTile(
                                leadingTitle: 'Avg. experience with buyers?',
                                trailingTitle: averageExperience),
                            const Gap(10),
                            buildTile(
                                leadingTitle: 'Avg. ticket arrival time?',
                                trailingTitle: averageArrivalTime),
                            const Gap(10),
                            buildTile(
                                leadingTitle:
                                    'Avg. communication & response time',
                                trailingTitle: averageCommunicationResponse),
                            const Gap(10),
                            buildTile(
                                leadingTitle: 'Total Transactions',
                                trailingTitle: '23 transactions'),
                            const Gap(40),
                            CustomButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              btnText: 'Cancel',
                              backgroundColor: AppColors.white,
                              borderColor: AppColors.jetBlack,
                              textColor: AppColors.jetBlack,
                              weight: FontWeight.w800,
                              textSize: AppSize.regular,
                            ),
                            const Gap(20),
                          ],
                        );
                      } else {
                        return Text('No data');
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

ticketSellDialog({
  required BuildContext context,
  required String ticketImage,
  required String offeredPrice,
  required String buyerImage,
  required String buyerId,
  required String buyerName,
  required String hashKey,
  required String docId,
  required String offerId,
  required MessageModel messageModel,
  required TicketsSoldModel soldModel,
  required UserModelClient userModel,
  required NotificationModel notificationModel,
  required String token,
  required String title,
  required String body,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer<BottomSheetProvider>(
        builder: (context, loadingProvider, child) {
          return AlertDialog.adaptive(
            backgroundColor: AppColors.white,
            titlePadding:
                const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 0),
            title: Column(
              children: [
                const Gap(10),
                CircleAvatar(
                  backgroundImage: NetworkImage(ticketImage),
                  radius: 90,
                ),
                const CustomText(
                  title: 'Are you sure?',
                  color: AppColors.jetBlack,
                  size: AppSize.verylarge,
                  weight: FontWeight.w700,
                ),
                CustomText(
                  title:
                      'Are you sure you want to sell this ticket on below mentioned details.',
                  color: AppColors.jetBlack.withOpacity(0.8),
                  maxLines: 2,
                  size: AppSize.medium,
                  softWrap: true,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      title: 'Price offered',
                      size: AppSize.regular,
                      weight: FontWeight.w400,
                      color: AppColors.jetBlack,
                    ),
                    CustomText(
                      title: offeredPrice,
                      size: AppSize.regular,
                      weight: FontWeight.w400,
                      color: AppColors.blueViolet,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      title: 'Buyer',
                      size: AppSize.regular,
                      weight: FontWeight.w400,
                      color: AppColors.jetBlack,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(buyerImage),
                          ),
                        ),
                        const Gap(10),
                        CustomText(
                          title: buyerName,
                          size: AppSize.intermediate,
                          weight: FontWeight.w400,
                          color: AppColors.jetBlack,
                        )
                      ],
                    ),
                  ],
                ),
                const Gap(20)
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 110,
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      btnText: 'Cancel',
                      backgroundColor: AppColors.white,
                      borderColor: AppColors.jetBlack,
                      textColor: AppColors.jetBlack,
                      weight: FontWeight.w700,
                      textSize: AppSize.regular,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 110,
                    child: CustomButton(
                      onPressed: () async {
                        loadingProvider.setLoading(true);
                        await FireStoreServicesClient.createMessageChat(
                                messageModel: messageModel, hashKey: hashKey)
                            .then((value) async {
                          await FireStoreServicesClient.makeConnection(
                                  userIDReceiver: messageModel.userIDReceiver!)
                              .then((value) async {
                            await FireStoreServicesClient.updateCommentsData(
                                docId: docId, offerId: offerId);
                          }).then((value) async {
                            await FireStoreServicesClient.saveSoldTicketsData(
                                soldModel: soldModel,
                                hashKey: hashKey,
                                buyerUid: buyerId,
                                sellerUid: AuthServices.getCurrentUser.uid);
                          }).then((value) async {
                            await NotificationServices.sendNotification(
                                token: token,
                                title: title,
                                body: body,
                                data:
                                    notificationModel.toMapForNotifications());
                          }).then((value) {
                            FireStoreServicesClient.storeNotifications(
                                notificationModel: notificationModel,
                                name: 'client_notifications');
                            loadingProvider.setLoading(false);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.chatDetailScreen,
                              (route) => false,
                              arguments: {
                                'receiverId': messageModel.userIDReceiver,
                                'hashKey': hashKey,
                                'userModel': userModel,
                                'isOpened': true,
                                'offeredPrice': offeredPrice
                              },
                            );
                          });
                        });
                      },
                      textColor: AppColors.white,
                      textSize: AppSize.medium,
                      btnText: 'Confirm',
                      loading: loadingProvider.isLoading,
                      gradient: customGradient,
                      weight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ],
          );
        },
      );
    },
  );
}

Widget buildTile(
    {required String leadingTitle, required String trailingTitle}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        title: leadingTitle,
        color: AppColors.lightGrey,
        size: 11,
        weight: FontWeight.w600,
      ),
      CustomText(
        title: trailingTitle,
        weight: FontWeight.w500,
        color: AppColors.jetBlack,
        size: AppSize.small,
      )
    ],
  );
}
