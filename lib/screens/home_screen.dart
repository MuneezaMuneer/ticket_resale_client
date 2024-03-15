import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
  late Stream<List<EventModal>> displayEventData;
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
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
      appBar: HomeAppBar(
        controller: searchController,
        setSearchQuery: (String searchQuery) {
          searchNotifier.value = searchQuery;
        },
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(40),
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                            MainAxisAlignment.spaceBetween,
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: Column(
                              children: [
                                Gap(50),
                                CupertinoActivityIndicator(),
                              ],
                            ));
                          } else if (snapshot.hasData) {
                            final data = query.isEmpty
                                ? snapshot.data
                                : snapshot.data!
                                    .where((element) =>
                                        element.eventName!
                                            .toLowerCase()
                                            .contains(query.toLowerCase()) ||
                                        element.location!
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
                                            '${data[index].eventName}'),
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
          size: AppSize.xsmall,
          weight: FontWeight.w400,
        ),
      )
    ],
  );
}
