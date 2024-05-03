import 'dart:developer';

import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/providers/dj_provider.dart';
import 'package:ticket_resale/screens/djs_screen.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  late ValueNotifier<String> searchNotifier;
  late Stream<List<EventModalClient>> displayEventData;
  late final ValueNotifier<String> selectedDJNameNotifier;
  late final ValueNotifier<bool> isDjSelectedNotifier;
  String? displayName;
  String? photoUrl;

  @override
  void initState() {
    searchController = TextEditingController();
    searchNotifier = ValueNotifier<String>('');
    displayEventData = FireStoreServicesClient.fetchEventData();
    displayName = AuthServices.getCurrentUser.displayName ?? '';
    photoUrl = AuthServices.getCurrentUser.photoURL ?? '';
    selectedDJNameNotifier = ValueNotifier<String>('');
    isDjSelectedNotifier = ValueNotifier<bool>(false);
    NotificationServices.getFCMCurrentDeviceToken().then((token) {
      log('token: $token');
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchNotifier.dispose();
    selectedDJNameNotifier.dispose();
    isDjSelectedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    ///muneeza check why build is called too many times. it should be called only once
    log('message: build is called');
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.blueViolet,
                title: Row(
                  children: [
                    photoUrl != null && photoUrl!.isNotEmpty
                        ? CustomDisplayStoryImage(
                            imageUrl: '$photoUrl',
                            width: 50,
                          )
                        : const CircleAvatar(
                            backgroundImage: AssetImage(AppImages.profileImage),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: AppUtils.getGreeting(),
                            color: AppColors.white,
                            weight: FontWeight.w400,
                            size: AppFontSize.small,
                          ),
                          CustomText(
                            title: displayName != null ? displayName ?? '' : '',
                            color: AppColors.white,
                            weight: FontWeight.w700,
                            size: AppFontSize.regular,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: IconButton.filled(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color(0xffFFFFFF).withOpacity(0.1)),
                        iconColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.notificationScreen,
                        );
                      },
                      icon: Icon(Icons.notifications),
                    ),
                  ),
                ],
              ),
              SearchAppBar(
                searchController: searchController,
                width: width,
                setSearchQuery: (String searchQuery) {
                  searchNotifier.value = searchQuery;
                },
                searchNotifier: searchNotifier,
              )
            ],
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(40),
                        const CustomText(
                          title: 'Upcoming Event Tickets',
                          color: AppColors.jetBlack,
                          size: AppFontSize.regular,
                          weight: FontWeight.w600,
                        ),
                        const Gap(15),
                        StreamBuilder<List<EventModalClient>>(
                          stream: displayEventData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: Column(
                                children: [
                                  Gap(50),
                                  CupertinoActivityIndicator(),
                                ],
                              ));
                            } else if (snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data!.isNotEmpty) {
                              final data = snapshot.data;
                              data!.sort((a, b) => a.date!.compareTo(b.date!));

                              final nearestEvent = data.firstWhere(
                                (event) => event.featuredEvent == true,
                                orElse: () => data.first,
                              );
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: SizedBox(
                                          height: 200,
                                          width: width,
                                          child: Image.network(
                                            '${nearestEvent.imageUrl}',
                                            fit: BoxFit.cover,
                                          ))),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SizedBox(
                                        width: 150,
                                        child: AvatarStack(
                                          height: 50,
                                          avatars: [
                                            for (var n = 1;
                                                n < data.length;
                                                n++)
                                              NetworkImage(
                                                  '${data[n].imageUrl}')
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 18,
                                    bottom: -35,
                                    child: Container(
                                      height: height * 0.1,
                                      width: width * 0.8,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.pastelBlue),
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 15),
                                            child: CustomText(
                                              title: AppUtils.limitTo33Char(
                                                  '${nearestEvent.eventName}'),
                                              color: AppColors.jetBlack,
                                              size: 15,
                                              weight: FontWeight.w700,
                                            ),
                                          ),
                                          const Gap(5),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                rowText(
                                                    AppUtils.formatDatee(
                                                      nearestEvent.date!,
                                                    ),
                                                    AppSvgs.calender),
                                                rowText('${nearestEvent.time}',
                                                    AppSvgs.clock)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Center(
                                  child: Column(
                                children: [
                                  Gap(30),
                                  Text('No Event Yet'),
                                ],
                              ));
                            }
                          },
                        ),
                        SizedBox(
                          height: height * 0.065,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              title: 'Popular DJS',
                              color: AppColors.jetBlack,
                              size: AppFontSize.regular,
                              weight: FontWeight.w600,
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: isDjSelectedNotifier,
                              builder: (context, isDjSelected, child) {
                                final selectedDJProvider =
                                    Provider.of<SelectedDJProvider>(context,
                                        listen: false);
                                return isDjSelected
                                    ? IconButton(
                                        onPressed: () {
                                          selectedDJNameNotifier.value = '';
                                          selectedDJProvider
                                              .clearSelectedDJName();
                                          isDjSelectedNotifier.value = false;
                                        },
                                        icon: Icon(Icons.close,
                                            color: AppColors.red),
                                      )
                                    : SizedBox();
                              },
                            ),
                          ],
                        ),
                        const Gap(15),
                        DJsListWidget(
                          onDjTapped: (String djName) {
                            selectedDJNameNotifier.value = djName;
                            isDjSelectedNotifier.value = true;
                          },
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              title: 'Events',
                              color: AppColors.jetBlack,
                              size: AppFontSize.regular,
                              weight: FontWeight.w600,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.eventScreen,
                                  arguments: true,
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: CustomText(
                                  title: 'View All',
                                  color: AppColors.blueViolet,
                                  size: AppFontSize.small,
                                  weight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        ValueListenableBuilder(
                          valueListenable: selectedDJNameNotifier,
                          builder: (context, selectedDj, child) =>
                              ValueListenableBuilder(
                            valueListenable: searchNotifier,
                            builder: (context, query, child) {
                              return StreamBuilder<List<EventModalClient>>(
                                stream: displayEventData,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: Column(
                                        children: [
                                          Gap(50),
                                          CupertinoActivityIndicator(),
                                        ],
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    final List<EventModalClient> data =
                                        snapshot.data!;

                                    // Conditionally filter events based on selected DJ name
                                    List<EventModalClient> filteredData = data;
                                    if (selectedDj.isNotEmpty) {
                                      filteredData = filteredData
                                          .where((event) =>
                                              event.djName == selectedDj)
                                          .toList();
                                    }

                                    filteredData = query.isEmpty
                                        ? filteredData
                                        : filteredData
                                            .where((event) =>
                                                event.eventName!
                                                    .toLowerCase()
                                                    .contains(
                                                        query.toLowerCase()) ||
                                                event.location!
                                                    .toLowerCase()
                                                    .contains(
                                                        query.toLowerCase()))
                                            .toList();

                                    if (filteredData.isNotEmpty) {
                                      return SizedBox(
                                        height: width < 370
                                            ? height * 0.45
                                            : height * 0.32,
                                        width: width,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: filteredData.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: CustomTileContainer(
                                                height: height,
                                                width: width * 0.65,
                                                date: AppUtils.dateFormat(
                                                    filteredData[index].date!),
                                                time: filteredData[index].time,
                                                posttitle: AppUtils.limitTo42Char(
                                                    '${filteredData[index].eventName}'),
                                                postBy: 'Jacob Jones',
                                                imagePath: filteredData[index]
                                                    .imageUrl,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 40),
                                        child: _buildText(),
                                      );
                                    }
                                  } else {
                                    return _buildText();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildText() {
    return const Center(
        child: Text(
      'No Record Found',
      style: TextStyle(
          color: AppColors.jetBlack,
          fontSize: AppFontSize.medium,
          fontWeight: FontWeight.w400),
    ));
  }
}

Widget rowText(String title, String svgIcon) {
  return Row(
    children: [
      SvgPicture.asset(
        svgIcon,
        colorFilter:
            const ColorFilter.mode(AppColors.lightGrey, BlendMode.srcIn),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: CustomText(
          title: title,
          color: AppColors.lightGrey,
          size: AppFontSize.xsmall,
          weight: FontWeight.w400,
        ),
      )
    ],
  );
}
