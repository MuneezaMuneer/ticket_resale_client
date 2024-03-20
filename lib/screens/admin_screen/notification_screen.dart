import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/models/notification_model.dart';
import 'package:ticket_resale/widgets/widgets.dart';

import '../../db_services/db_services.dart';
import '../../providers/providers.dart';

class AdminNotification extends StatefulWidget {
  const AdminNotification({super.key});
  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  late Stream<List<NotificationModel>> fetchNotification;
  ValueNotifier<String> searchNotifier = ValueNotifier('');
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    fetchNotification = FirestoreServicesAdmin.fetchNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Consumer<SearchProvider>(
        builder: (context, searchprovider, child) => Scaffold(
              appBar: searchprovider.isSearching
                  ? PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: CustomAppBarField(
                          text: 'Search via name & phoneNo',
                          searchController: searchcontroller,
                          setSearchValue: (searchQuery) {
                            searchNotifier.value = searchQuery;
                          }))
                  : const PreferredSize(
                      preferredSize: Size.fromHeight(60),
                      child: CustomAppBarAdmin()),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CustomText(
                      title: 'Recent Notifications',
                      weight: FontWeight.w600,
                      size: AppSize.regular,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: height * 0.85,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: notificationtiles(),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  Widget notificationtiles() {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Container(
      width: width,
      height: height * 0.15,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: StreamBuilder<List<NotificationModel>>(
          stream: fetchNotification,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator();
            } else if (snapshot.hasError) {
              {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
            } else if (snapshot.hasData) {
              final notification = snapshot.data;
              return ListView.builder(
                itemCount: notification!.length,
                itemBuilder: (context, index) => Column(
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
                                  child:
                                      SvgPicture.asset(AppSvgs.notifications)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width,
                                  child: RichText(
                                    text: TextSpan(
                                      text: notification![index].title,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: AppSize.medium,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(text: '   '),
                                        TextSpan(
                                          text: notification[index].body,
                                          style: const TextStyle(
                                            color: AppColors.grey,
                                            fontSize: AppSize.medium,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                CustomText(
                                  title: notification[index].time.toString(),
                                  weight: FontWeight.w400,
                                  size: AppSize.small,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Container(
                                height: height * 0.5,
                                width: width * 0.7,
                                decoration:
                                    BoxDecoration(color: AppColors.brown),
                              );
                            },
                            child: Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.midNight,
                              ),
                              child: const Center(
                                child: Text(
                                  'View Details',
                                  style: TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: AppSize.small,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Text('No Notification found here');
            }
          }),
    );
  }
}
