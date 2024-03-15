import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';
class EventScreen extends StatefulWidget {
  final bool isBackButton;
  const EventScreen({super.key, required this.isBackButton});
  @override
  State<EventScreen> createState() => _EventScreenState();
}
class _EventScreenState extends State<EventScreen> {
  late Stream<List<EventModal>> displayEventData;
  TextEditingController searchController = TextEditingController();
  ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
  @override
  void initState() {
    displayEventData = FireStoreServices.fetchEventData();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Event Video Player',
        isBackButton: widget.isBackButton,
      ),
      backgroundColor: AppColors.paleGrey,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: width * 0.9,
                      child: ValueListenableBuilder(
                        valueListenable: searchNotifier,
                        builder: (context, value, child) {
                          return CustomTextField(
                            hintStyle: const TextStyle(color: AppColors.silver),
                            hintText: 'Search Events, Tickets, or City',
                            controller: searchController,
                            fillColor: AppColors.white,
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
                  const Gap(10),
                  const CustomText(
                    title: 'All Events',
                    color: AppColors.jetBlack,
                    size: AppSize.regular,
                    weight: FontWeight.w600,
                  ),
                  const Gap(5),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: searchNotifier,
                      builder: (context, query, child) => StreamBuilder(
                        stream: displayEventData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CupertinoActivityIndicator());
                          } else if (snapshot.hasData) {
                            final data = query.isEmpty
                                ? snapshot.data!
                                : snapshot.data!
                                    .where((data) =>
                                        data.eventName!
                                            .toLowerCase()
                                            .contains(query.toLowerCase()) ||
                                        data.location!
                                            .toLowerCase()
                                            .contains(query.toLowerCase()))
                                    .toList();
                            if (data.isNotEmpty) {
                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        crossAxisCount: 2,
                                        mainAxisExtent: 220),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color(0XffEAE6F4),
                                      ),
                                      color: AppColors.white,
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, top: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: SizedBox(
                                                    height: width < 380
                                                        ? height * 0.165
                                                        : height * 0.12,
                                                    width: width,
                                                    child: Image.network(
                                                      '${data[index].imageUrl}',
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              const Gap(10),
                                              Container(
                                                height: 25,
                                                width: width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(56),
                                                  color: AppColors.lightGrey
                                                      .withOpacity(0.1),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SvgPicture.asset(
                                                          AppSvgs.clock),
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            title: AppUtils
                                                                .dateFormat(
                                                              '${data[index].date}',
                                                            ),
                                                            color: const Color(
                                                                0Xff6E4CEE),
                                                            size:
                                                                AppSize.xxsmall,
                                                            weight:
                                                                FontWeight.w600,
                                                          ),
                                                          SizedBox(
                                                            child: CustomText(
                                                              title:
                                                                  ',${data[index].time}',
                                                              color: const Color(
                                                                  0Xff6E4CEE),
                                                              size: AppSize
                                                                  .xxsmall,
                                                              weight: FontWeight
                                                                  .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Gap(5),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3),
                                                child: CustomText(
                                                  softWrap: true,
                                                  title: AppUtils.limitTo42Char(
                                                      '${data[index].eventName}'),
                                                  color: AppColors.jetBlack,
                                                  size: AppSize.xsmall,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 3, top: 5),
                                              //   child: Row(
                                              //     children: [
                                              //       const SizedBox(
                                              //         height: 15,
                                              //         width: 15,
                                              //         child: CircleAvatar(
                                              //           backgroundImage:
                                              //               AssetImage(AppImages.profile),
                                              //         ),
                                              //       ),
                                              //       Padding(
                                              //         padding:
                                              //             const EdgeInsets.only(left: 3),
                                              //         child: RichText(
                                              //           text: const TextSpan(
                                              //             children: [
                                              //               TextSpan(
                                              //                 text: 'Posted by ',
                                              //                 style: TextStyle(
                                              //                   color:
                                              //                       AppColors.lightGrey,
                                              //                   fontSize: AppSize.xxsmall,
                                              //                   fontWeight:
                                              //                       FontWeight.w600,
                                              //                 ),
                                              //               ),
                                              //               TextSpan(
                                              //                 text: 'Jacob Jones',
                                              //                 style: TextStyle(
                                              //                   color:
                                              //                       AppColors.lightGrey,
                                              //                   fontSize: AppSize.xxsmall,
                                              //                   fontWeight:
                                              //                       FontWeight.w300,
                                              //                 ),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: SizedBox(
                                            height: 30,
                                            width: width,
                                            child: CustomButton(
                                              onPressed: () {
                                                EventModal eventModal =
                                                    EventModal(
                                                        docId:
                                                            data[index].docId,
                                                        description: data[index]
                                                            .description!,
                                                        eventName: data[index]
                                                            .eventName!,
                                                        imageUrl: data[index]
                                                            .imageUrl!,
                                                        date: data[index].date!,
                                                        time: data[index].time!,
                                                        location: data[index]
                                                            .location!);
                                                Navigator.pushNamed(context,
                                                    AppRoutes.detailFirstScreen,
                                                    arguments: eventModal);
                                              },
                                              textColor: AppColors.white,
                                              textSize: AppSize.regular,
                                              isSocial: true,
                                              gradient: customGradient,
                                              isRounded: false,
                                              isSvgImage: true,
                                              imagePath: AppSvgs.paypalIcon,
                                              socialText: 'Explore More',
                                              socialTextColor: AppColors.white,
                                              socialTextWeight: FontWeight.w600,
                                              socialTextSize: AppSize.xsmall,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return _buildText();
                            }
                          } else {
                            return _buildText();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
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
