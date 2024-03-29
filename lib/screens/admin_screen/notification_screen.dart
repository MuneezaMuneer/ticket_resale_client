import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/models/notification_model.dart';
import 'package:ticket_resale/utils/app_utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';
import '../../db_services/db_services.dart';
import '../../providers/providers.dart';

class AdminNotification extends StatefulWidget {
  const AdminNotification({super.key});
  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  late NavigationProvider navigationProvider;

  ValueNotifier<String> searchNotifier = ValueNotifier('');
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBarAdmin(
            isSearchIcon: false,
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: height * 0.85,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: notificationTiles(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget notificationTiles() {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            onTap: (index) {},
            tabs: const [
              Tab(
                text: 'UnRead Notification',
              ),
              Tab(text: 'Read Notification'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildView(status: 'Unread', width: width, height: height),
                _buildView(status: 'read', width: width, height: height)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildView(
      {required String status, required double width, required double height}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          status == 'read'
              ? Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: GestureDetector(
                      onTap: () {
                        FirestoreServicesAdmin.deleteReadNotifications(
                            name: 'admin_notifications');
                      },
                      child: const CustomText(
                        title: 'Clear All',
                        color: Colors.red,
                        weight: FontWeight.w700,
                        size: AppSize.medium,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const Gap(20),
          Container(
            width: width,
            height: height * 0.63,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: StreamBuilder<List<NotificationModel>>(
              stream: FirestoreServicesAdmin.fetchNotification(status: status),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CupertinoActivityIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No Notification found here'));
                } else {
                  final notification = snapshot.data;
                  return ListView.builder(
                    itemCount: notification!.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (status == 'Unread') {
                          print('.................click');
                          navigationProvider.setSelectedIndex(1);
                          FireStoreServicesClient.updateNotifications(
                              docId: notification[index].docId,
                              name: 'admin_notifications');
                        }
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.blueViolet,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              AppSvgs.notifications)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: notification[index].title,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: AppSize.medium,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            children: <TextSpan>[
                                              const TextSpan(text: '   '),
                                              TextSpan(
                                                text: notification[index].body,
                                                style: const TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize: AppSize.medium,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(5),
                                        CustomText(
                                          title: AppUtils.formatTimeStamp(
                                              notification[index].time!),
                                          weight: FontWeight.w400,
                                          size: AppSize.small,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
