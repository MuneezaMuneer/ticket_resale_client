// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';
import '../components/components.dart';

class HomeDetailFirstScreen extends StatefulWidget {
  final String eventId;
  HomeDetailFirstScreen({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  State<HomeDetailFirstScreen> createState() => _HomeDetailFirstScreenState();
}

class _HomeDetailFirstScreenState extends State<HomeDetailFirstScreen> {
  late Stream<List<TicketModelClient>> displayTickets;
  late Stream<EventModalClient> fetchEvents;
  @override
  void initState() {
    displayTickets =
        FireStoreServicesClient.fetchTicketsData(docID: widget.eventId);
    fetchEvents = FireStoreServicesClient.fetchEventDataBasedOnId(
        eventId: widget.eventId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: AppColors.pastelBlue.withOpacity(0.3),
      body: StreamBuilder(
        stream: fetchEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData) {
            final EventModalClient? eventData = snapshot.data;

            return AppBackground(
              networkImage: '${eventData!.imageUrl}',
              isAssetImage: false,
              isBackButton: true,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 30),
                        child: CustomText(
                          title: '${eventData.eventName}',
                          size: AppFontSize.large,
                          weight: FontWeight.w600,
                          softWrap: true,
                          color: AppColors.jetBlack,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const Gap(40),
                      Container(
                        height: height * 0.06,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(56),
                            border: Border.all(color: AppColors.white),
                            color: AppColors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: AppColors.paleGrey,
                                    radius: 17,
                                    backgroundImage:
                                        AssetImage(AppImages.profileImage),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                    ),
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: 'Featured DJ : ',
                                          style: TextStyle(
                                              color: AppColors.lightGrey
                                                  .withOpacity(0.6),
                                              fontSize: AppFontSize.xsmall,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: eventData.djName,
                                          style: TextStyle(
                                              color: AppColors.blueViolet,
                                              fontSize: AppFontSize.medium,
                                              fontWeight: FontWeight.w600)),
                                    ])),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(15),
                      Container(
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(56),
                            border: Border.all(color: AppColors.white),
                            color: AppColors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: AppColors.paleGrey,
                                      radius: 20,
                                      child: SvgPicture.asset(
                                        AppSvgs.clock,
                                        height: 30,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 7, bottom: 7),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          title:
                                              '${AppUtils.formatDate('${eventData.date}')}, ${eventData.time}',
                                          color: AppColors.lightGrey
                                              .withOpacity(0.6),
                                          size: AppFontSize.xsmall,
                                          weight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: 'at ',
                                                style: TextStyle(
                                                    color: AppColors.lightGrey
                                                        .withOpacity(0.6),
                                                    letterSpacing: 0.8,
                                                    fontSize:
                                                        AppFontSize.xsmall,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            TextSpan(
                                                text: '${eventData.location}',
                                                style: const TextStyle(
                                                    color: AppColors.jetBlack,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    letterSpacing: 0.8,
                                                    fontSize: AppFontSize.small,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ])),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      const CustomText(
                        title: 'About Event',
                        size: AppFontSize.regular,
                        weight: FontWeight.w600,
                        color: AppColors.jetBlack,
                      ),
                      CustomText(
                        title: '${eventData.description}',
                        size: AppFontSize.medium,
                        softWrap: true,
                        weight: FontWeight.w400,
                        color: AppColors.lightGrey,
                      ),
                      const Gap(20),
                      const CustomText(
                        title: 'Tickets Available by Sellers',
                        size: AppFontSize.regular,
                        weight: FontWeight.w600,
                        color: AppColors.jetBlack,
                      ),
                      const Gap(15),
                      StreamBuilder(
                        stream: displayTickets,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          } else if (snapshot.hasData) {
                            final tickets = snapshot.data!;
                            if (tickets.isNotEmpty) {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: tickets.length,
                                itemExtent: 140,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.detailSecondScreen,
                                          arguments: {
                                            'eventId': widget.eventId,
                                            'ticketId': tickets[index].docId,
                                            'ticketUserId': tickets[index].uid
                                          },
                                        );
                                      },
                                      child: CustomTile(
                                        userId: tickets[index].uid,
                                        title:
                                            '${tickets[index].ticketType} TICKET AVAILABLE',
                                        subTitle:
                                            'VIP Seats + Exclusive braclets',
                                        price: '${tickets[index].price}',
                                        imagePath: '${tickets[index].imageUrl}',
                                        text: 'Sell by',
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                  child: Column(
                                children: [
                                  Gap(30),
                                  Text('No Ticket Available'),
                                ],
                              ));
                            }
                          } else {
                            return const Text('No Ticket Available');
                          }
                        },
                      ),
                      const Gap(10)
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No Event Yet'));
          }
        },
      ),
    );
  }
}
