// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

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
        children: [
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Text(
              'Unread',
              style: _textStyle(),
            ),
          ),
          const Gap(20),
          Expanded(
            child: Container(
                decoration: BoxDecoration(color: AppColors.white, boxShadow: [
                  BoxShadow(
                      color: AppColors.blueViolet.withOpacity(0.4),
                      blurRadius: 10)
                ]),
                child: _builderWidget(FontWeight.w600, AppColors.yellow,
                    stream: unreadnotification)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Read',
                  style: _textStyle(),
                ),
                InkWell(
                  onTap: () {
                    isDelete.value = true;
                    FireStoreServicesClient.deleteReadNotifications(
                      name: 'client_notifications',
                    ).then((_) {
                      isDelete.value = false;
                    });
                  },
                  child: const Text(
                    'Clear All',
                    style: TextStyle(
                        color: AppColors.red,
                        fontSize: AppSize.medium,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Expanded(
            child: ValueListenableBuilder<bool>(
              valueListenable: isDelete,
              builder: (context, deleting, _) {
                return deleting
                    ? const Center(child: CupertinoActivityIndicator())
                    : _builderWidget(
                        FontWeight.w300,
                        AppColors.vibrantGreen,
                        stream: readnotification,
                      );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _builderWidget(final FontWeight weight, final Color containerColor,
      {required Stream<List<NotificationModel>> stream}) {
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
                  onTap: () {
                    FireStoreServicesClient.updateNotifications(
                        docId: notifications[index].docId,
                        name: 'client_notifications');
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
                              size: AppSize.medium,
                              weight: weight,
                              color: AppColors.jetBlack,
                            ),
                            CustomText(
                              title: notifications[index].body,
                              size: AppSize.medium,
                              weight: FontWeight.w300,
                              softWrap: true,
                              color: AppColors.jetBlack.withOpacity(0.7),
                            )
                          ]),
                      subtitle: CustomText(
                        title: AppUtils.formatTimeStamp(
                            notifications[index].time!),
                        size: AppSize.small,
                        weight: FontWeight.w400,
                        color: AppColors.jetBlack.withOpacity(0.4),
                      )),
                );
              },
            );
          } else {
            return const Center(child: Text('No Notifications'));
          }
        } else {
          return const Center(child: Text('No Notifications'));
        }
      },
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
        color: AppColors.jetBlack,
        fontSize: AppSize.medium,
        fontWeight: FontWeight.w600);
  }
}
