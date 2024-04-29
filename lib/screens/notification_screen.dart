import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isRead = false;
  late Stream<List<NotificationModel>> readnotification;
  late Stream<List<NotificationModel>> unreadnotification;
  ValueNotifier<bool> isDelete = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    readnotification =
        FireStoreServicesClient.fetchNotifications(status: 'read');
    unreadnotification =
        FireStoreServicesClient.fetchNotifications(status: 'Unread');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 234, 248),
      appBar: const CustomAppBarClient(
        title: 'Notification',
        isNotification: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const Gap(20), Expanded(child: notificationTiles())],
      ),
    );
  }

  Widget notificationTiles() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: 'UnRead Notification',
              ),
              Tab(text: 'Read Notification'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: _builderWidget(stream: unreadnotification),
                ),
                Stack(
                  children: [
                    Positioned(
                      right: 28,
                      top: 8,
                      child: GestureDetector(
                        onTap: () {
                          isDelete.value = true;
                          FireStoreServicesClient.deleteReadNotifications(
                            name: 'client_notifications',
                          ).then((_) {
                            isDelete.value = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CustomText(
                            title: 'Clear All',
                            size: AppFontSize.medium,
                            weight: FontWeight.w600,
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isDelete,
                        builder: (context, deleting, _) {
                          return deleting
                              ? const Center(
                                  child: CupertinoActivityIndicator())
                              : _builderWidget(
                                  stream: readnotification,
                                );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _builderWidget({required Stream<List<NotificationModel>> stream}) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasData) {
          final notifications = snapshot.data;
          if (notifications != null && notifications.isNotEmpty) {
            return ListView.builder(
              itemCount: notifications.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    if (notifications[index].status == 'Unread') {
                      FireStoreServicesClient.updateNotifications(
                          docId: notifications[index].docId,
                          name: 'client_notifications');
                    }
                    if (notifications[index].notificationType ==
                            'ticket_listing' &&
                        notifications[index].status == 'Unread') {
                      Navigator.popAndPushNamed(
                          context, AppRoutes.detailFirstScreen,
                          arguments: notifications[index].id);
                    } else if (notifications[index].notificationType ==
                            'offer_confirm' &&
                        notifications[index].status == 'Unread') {
                      Navigator.of(context).popAndPushNamed(
                        AppRoutes.chatDetailScreen,
                        arguments: {
                          'receiverId': notifications[index].userId,
                          'hashKey':
                              FireStoreServicesClient.getMessagesHashCodeID(
                                  userIDReceiver: notifications[index].id!),
                          'isOpened': false,
                        },
                      );
                    } else if (notifications[index].notificationType ==
                            'paid' &&
                        notifications[index].status == 'Unread') {
                      log('---id - ${notifications[index].id} --  userid ${notifications[index].userId} --  current id ${AuthServices.getCurrentUser.uid}');
                      UserModelClient userModel =
                          await FireStoreServicesClient.fetchDataOfUser(
                              userId: notifications[index].userId!);
                      CustomBottomSheet.showConfirmTicketsSheet(
                          // ignore: use_build_context_synchronously
                          context: context,
                          hashKey:
                              FireStoreServicesClient.getMessagesHashCodeID(
                                  userIDReceiver: notifications[index].id!),
                          //  id: {'seller_uid': notifications[index].userId},
                          userModel: userModel);
                    }
                  },
                  child: ListTile(
                      leading: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: notifications[index].status == 'Unread'
                                ? AppColors.red
                                : AppColors.blue),
                      ),
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: notifications[index].title,
                              size: AppFontSize.medium,
                              weight: FontWeight.w600,
                              color: AppColors.jetBlack,
                            ),
                            CustomText(
                              title: notifications[index].body,
                              size: AppFontSize.medium,
                              weight: FontWeight.w300,
                              softWrap: true,
                              color: AppColors.jetBlack.withOpacity(0.7),
                            )
                          ]),
                      subtitle: CustomText(
                        title: AppUtils.formatTimeStamp(
                            notifications[index].time!),
                        size: AppFontSize.small,
                        weight: FontWeight.w400,
                        color: AppColors.jetBlack.withOpacity(0.4),
                      )),
                );
              },
            );
          } else {
            return const Center(child: Text('No Notification'));
          }
        } else {
          return const Center(child: Text('No Notification'));
        }
      },
    );
  }
}
