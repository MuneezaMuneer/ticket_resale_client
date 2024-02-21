import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/firestore_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late Stream<List<EventModal>> displayEventData;


  @override
  void initState() {
    displayEventData = FireStoreServices.fetchEventData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Event Video Player',
      ),
      backgroundColor: AppColors.paleGrey,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: width * 0.9,
                      child: CustomTextField(
                        hintStyle: const TextStyle(color: AppColors.silver),
                        hintText: 'Search Event & Tickets',
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
                            child: const Center(
                              child: Icon(
                                Icons.search,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
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
                    child: StreamBuilder(
                      stream: displayEventData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CupertinoActivityIndicator();
                        } else if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    mainAxisExtent: 230),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: SizedBox(
                                                height: width < 370
                                                    ? height * 0.19
                                                    : height * 0.13,
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
                                                  CustomText(
                                                    title: data[index].date,
                                                    color:
                                                        const Color(0Xff6E4CEE),
                                                    size: AppSize.xxsmall,
                                                    weight: FontWeight.w600,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Gap(8),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: CustomText(
                                              softWrap: true,
                                              title:
                                                  '${data[index].festivalName}',
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
                                            Navigator.pushNamed(context,
                                                AppRoutes.detailFirstScreen);
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
                          return const Text('No Event');
                        }
                      },
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
}
