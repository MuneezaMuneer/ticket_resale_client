import 'package:avatar_stack/avatar_stack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/app_utils.dart';

import 'package:ticket_resale/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? displayName;
  String? photoUrl;
  TextEditingController searchController = TextEditingController();
  ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
  late Stream<List<EventModal>> displayEventData;

  @override
  void initState() {
    displayName = AuthServices.getCurrentUser.displayName ?? '';
    photoUrl = FirebaseAuth.instance.currentUser!.photoURL ?? '';
    displayEventData = FireStoreServices.fetchEventData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List namesDJS = [
      "Adele",
      "Ed Sheeran",
      "Beyoncé",
      "Justin Bieber",
    ];

    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Scaffold(
      backgroundColor: AppColors.pastelBlue.withOpacity(0.3),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: height * 0.27,
              width: width,
              decoration: BoxDecoration(
                  gradient: customGradient,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 40, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: photoUrl != null && photoUrl!.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          imageUrl: "$photoUrl",
                                          placeholder: (context, url) =>
                                              const CupertinoActivityIndicator(
                                            color: AppColors.blueViolet,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            AppImages.profileImage))),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: AppUtils.getGreeting(),
                                    color: AppColors.white,
                                    weight: FontWeight.w400,
                                    size: AppSize.small,
                                  ),
                                  CustomText(
                                    title: displayName != null
                                        ? displayName ?? ''
                                        : '',
                                    color: AppColors.white,
                                    weight: FontWeight.w700,
                                    size: AppSize.regular,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.notificationScreen);
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white.withOpacity(0.1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(AppSvgs.sms),
                              )),
                        )
                      ],
                    ),
                    const Gap(10),
                    const CustomText(
                      title: 'Discover Amazing',
                      color: AppColors.white,
                      size: AppSize.regular,
                      weight: FontWeight.w400,
                    ),
                    const CustomText(
                      title: 'Events Ticket Now',
                      color: AppColors.white,
                      size: AppSize.verylarge,
                      weight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.24,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: height * 0.08,
                      width: width * 0.85,
                      child: ValueListenableBuilder(
                        valueListenable: searchNotifier,
                        builder: (context, value, child) {
                          return CustomTextField(
                            hintText: 'Search Events, Tickets, or City',
                            hintStyle: const TextStyle(color: AppColors.silver),
                            fillColor: AppColors.white,
                            controller: searchController,
                            isFilled: true,
                            onChanged: (query) {
                              searchNotifier.value = query;
                            },
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: customGradient,
                                ),
                                child: Center(
                                  child: searchController.text.isEmpty
                                      ? const Icon(
                                          Icons.search,
                                          color: AppColors.white,
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            searchController.clear();
                                            searchNotifier.value = '';
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: AppColors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Gap(15),
                  const CustomText(
                    title: 'Upcoming Event Tickets',
                    color: AppColors.jetBlack,
                    size: AppSize.regular,
                    weight: FontWeight.w600,
                  ),
                  const Gap(15),
                  StreamBuilder(
                    stream: displayEventData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        data!.sort((a, b) => a.date!.compareTo(b.date!));

                        final nearestEvent = data.first;
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
                                      for (var n = 1; n < data.length; n++)
                                        NetworkImage('${data[n].imageUrl}')
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
                                    border:
                                        Border.all(color: AppColors.pastelBlue),
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 15),
                                      child: CustomText(
                                        title: AppUtils.limitTo33Char(
                                            '${nearestEvent.festivalName}'),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          rowText('${nearestEvent.date}'),
                                          rowText('${nearestEvent.time}')
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
                            Gap(40),
                            CupertinoActivityIndicator(),
                          ],
                        ));
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.065,
                  ),
                  const CustomText(
                    title: 'Popular DJS',
                    color: AppColors.jetBlack,
                    size: AppSize.regular,
                    weight: FontWeight.w600,
                  ),
                  const Gap(15),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: namesDJS.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: height * 0.07,
                          width: width * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          AppColors.pastelBlue.withOpacity(0.7),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0XffF7F5FF)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    child:
                                        circleAvatar(50, 50, AppImages.profile),
                                  ),
                                  const Gap(10),
                                  CustomText(
                                    title: namesDJS[index],
                                    color: AppColors.jetBlack.withOpacity(0.7),
                                    size: AppSize.verySmall,
                                    weight: FontWeight.w600,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        title: 'Events',
                        color: AppColors.jetBlack,
                        size: AppSize.regular,
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
                            size: AppSize.small,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  ValueListenableBuilder(
                    valueListenable: searchNotifier,
                    builder: (context, query, child) {
                      return StreamBuilder(
                        stream: displayEventData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = query.isEmpty
                                ? snapshot.data
                                : snapshot.data!
                                    .where((element) => element.festivalName!
                                        .toLowerCase()
                                        .contains(query.toLowerCase()))
                                    .toList();

                            if (data!.isNotEmpty) {
                              return SizedBox(
                                height:
                                    width < 370 ? height * 0.4 : height * 0.32,
                                width: width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: CustomTileContainer(
                                        height: height,
                                        width: width * 0.65,
                                        date: AppUtils.dateFormat(
                                            data[index].date!),
                                        time: data[index].time,
                                        posttitle: AppUtils.limitTo42Char(
                                            '${data[index].festivalName}'),
                                        postBy: 'Jacob Jones',
                                        imagePath: data[index].imageUrl,
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40),
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
                  const Gap(10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    return const Center(
        child: Text(
      'No Record Found',
      style: TextStyle(
          color: AppColors.jetBlack,
          fontSize: AppSize.medium,
          fontWeight: FontWeight.w400),
    ));
  }
}

Widget circleAvatar(double height, double width, String imagePath) {
  return SizedBox(
    height: height,
    width: width,
    child: CircleAvatar(
      backgroundImage: AssetImage(imagePath),
    ),
  );
}

Widget rowText(String title) {
  return Row(
    children: [
      SvgPicture.asset(AppSvgs.calender),
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: CustomText(
          title: title,
          color: AppColors.lightGrey,
          size: AppSize.xsmall,
          weight: FontWeight.w400,
        ),
      )
    ],
  );
}
