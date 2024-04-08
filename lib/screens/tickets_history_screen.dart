import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class TicketsHistoryScreen extends StatefulWidget {
  const TicketsHistoryScreen({super.key});

  @override
  State<TicketsHistoryScreen> createState() => _TicketsHistoryScreenState();
}

class _TicketsHistoryScreenState extends State<TicketsHistoryScreen> {
  late Stream<List<TicketModelClient>> displayTickets;
  late Stream<List<TicketsSoldModel>> soldTicketsHistory;
  @override
  void initState() {
    displayTickets = FireStoreServicesClient.fetchCurrentUserTickets();
    soldTicketsHistory = FireStoreServicesClient.fetchSoldTicketsHistory(
        userId: AuthServices.getCurrentUser.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CustomAppBarClient(
            title: 'Tickets History',
          ),
          backgroundColor: AppColors.paleGrey,
          body: Column(
            children: [
              Gap(20),
              TabBar(
                tabs: [
                  Tab(text: 'Active Tickets'),
                  Tab(text: 'Sold Tickets'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: StreamBuilder(
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
                                itemExtent: 80,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: _tileContainer(
                                      title:
                                          '${tickets[index].ticketType} TICKET AVAILABLE',
                                      subTitle:
                                          'VIP Seats + Exclusive braclets',
                                      price: '${tickets[index].price}',
                                      imagePath: '${tickets[index].imageUrl}',
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                  child: Text('No Ticket Available'));
                            }
                          } else {
                            return const Center(
                                child: Text('No Ticket Available'));
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: StreamBuilder(
                        stream: soldTicketsHistory,
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
                                    child: CustomTile(
                                      title:
                                          '${tickets[index].ticketName} TICKET AVAILABLE',
                                      subTitle:
                                          'VIP Seats + Exclusive braclets',
                                      price: '${tickets[index].ticketPrice}',
                                      imagePath:
                                          '${tickets[index].ticketImage}',
                                      userId: '${tickets[index].buyerUid}',
                                      text: 'Buy by',
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                  child: Text('No Ticket Available'));
                            }
                          } else {
                            return const Center(
                                child: Text('No Ticket Available'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _tileContainer({
    String? title,
    String? subTitle,
    String? price,
    String? imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.blueViolet)),
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0XffF7F5FF),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: CustomDisplayStoryImage(
                      imageUrl: '$imagePath',
                      height: 43,
                      width: 43,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: '$title',
                          color: AppColors.jetBlack,
                          size: AppFontSize.small,
                          weight: FontWeight.w600,
                        ),
                        CustomText(
                          title: '$subTitle',
                          color: AppColors.lightGrey.withOpacity(0.6),
                          size: AppFontSize.xsmall,
                          weight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CustomText(
                title: '$price',
                color: const Color(0XffAC8AF7),
                size: 18,
                weight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
    );
  }
}
