import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class TicketListing extends StatefulWidget {
  const TicketListing({super.key});
  @override
  State<TicketListing> createState() => _TicketListingState();
}

class _TicketListingState extends State<TicketListing> {
  late Stream<List<TicketModalAdmin>> fetchEvents;
  TextEditingController controller = TextEditingController();

  TextEditingController searchcontroller = TextEditingController();
  List<TicketModalAdmin> filterEventData = [];
  List<TicketModalAdmin> eventData = [];
  late ClearProvider clearProvider;
  @override
  void initState() {
    fetchEvents = FirestoreServicesAdmin.fetchTicket();
    clearProvider = Provider.of<ClearProvider>(context, listen: false);

    SchedulerBinding.instance.addPostFrameCallback((timings) {
      clearProvider.clearSearchText();
    });

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
                    text: 'Search via Event name, seller & ticket type',
                    searchController: searchcontroller,
                    setSearchValue: (searchQuery) {
                      clearProvider.setSearchText = searchQuery;
                      filterEventData = eventData
                          .where((data) =>
                              data.eventName!
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()) ||
                              data.userName!
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()) ||
                              data.ticketType!
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()))
                          .toList();
                    }))
            : const PreferredSize(
                preferredSize: Size.fromHeight(60), child: CustomAppBarAdmin()),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      title: 'Ticket listing',
                      weight: FontWeight.w600,
                      size: AppFontSize.regular,
                    ),
                    FilterMenuAdmin(
                      onSelectedPrice: (min, max) {
                        clearProvider.setSearchText = '$min$max';
                        filterEventData = eventData.where((item) {
                          double itemPrice = double.tryParse(item.price!) ?? 0;
                          return itemPrice <= min && itemPrice >= max;
                        }).toList();
                      },
                      onSelectedStatus: (slectedValue) {
                        log('.........................on ui $slectedValue}');
                        clearProvider.setSearchText = slectedValue;
                        filterEventData = eventData
                            .where((data) => data.status!
                                .toLowerCase()
                                .contains(slectedValue.toLowerCase()))
                            .toList();
                      },
                    ),
                  ],
                ),
              ),
              const Gap(25),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.purple.withOpacity(0.3),
                            blurRadius: 7,
                            spreadRadius: 2,
                            offset: const Offset(0, 0),
                          ),
                          const BoxShadow(
                              color: AppColors.lightPurple,
                              blurRadius: 7,
                              spreadRadius: 2,
                              offset: Offset(0, 0))
                        ]),
                    child: StreamBuilder<List<TicketModalAdmin>>(
                      stream: fetchEvents,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CupertinoActivityIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          eventData = snapshot.data!;
                          return Consumer<ClearProvider>(
                            builder: (context, query, child) {
                              List<TicketModalAdmin?> ticketData =
                                  query.searchText.isEmpty
                                      ? snapshot.data!
                                      : filterEventData;

                              if (ticketData.isNotEmpty) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                      columnSpacing: width * 0.066,
                                      dividerThickness: 0.0000000000000000001,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25)),
                                        color: AppColors.lightPurple,
                                        border: Border.all(
                                            color: Colors.transparent),
                                      ),
                                      columns: [
                                        _buildTableCell(
                                          'Image',
                                        ),
                                        _buildTableCell('Event name'),
                                        _buildTableCell('Seller name'),
                                        _buildTableCell('Ticket type'),
                                        _buildTableCell('Price'),
                                        _buildTableCell('Status')
                                      ],
                                      rows: ticketData.asMap().entries.map(
                                          (MapEntry<int, TicketModalAdmin?>
                                              entry) {
                                        TicketModalAdmin? ticketData =
                                            entry.value;
                                        final bool isOdd = entry.key.isOdd;
                                        final Color rowColor = isOdd
                                            ? AppColors.lightPurple
                                            : AppColors.white;

                                        return DataRow(
                                          color: MaterialStateProperty
                                              .resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
                                            return rowColor;
                                          }),
                                          cells: [
                                            DataCell(CircleAvatar(
                                              radius: 15,
                                              backgroundImage: NetworkImage(
                                                  ticketData!.image!),
                                            )),
                                            _dataCellForNames(
                                              name: ticketData.eventName!,
                                            ),
                                            _dataCellForNames(
                                              name: ticketData.userName!,
                                            ),
                                            _createDataCell(
                                                ticketData.ticketType!),
                                            _createDataCell(ticketData.price!),
                                            DataCell(createTableCell(
                                              ticketID: ticketData.ticketID!,
                                              userID: ticketData.userId!,
                                              eventId: ticketData.eventid!,
                                              eventName: ticketData.eventName!,
                                              ticketType:
                                                  ticketData.ticketType!,
                                              fcmToken: ticketData.fcmToken!,
                                            )),
                                          ],
                                        );
                                      }).toList()),
                                );
                              } else {
                                return const Center(
                                  child: CustomText(
                                    title: 'No record found here',
                                    size: AppFontSize.regular,
                                    color: AppColors.jetBlack,
                                  ),
                                );
                              }
                            },
                          );
                        } else {
                          return const Text('');
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createTableCell({
    required String ticketID,
    required String fcmToken,
    required String eventId,
    required String eventName,
    required String ticketType,
    required String userID,
  }) {
    Color backgroundColor;
    Color textColor = Colors.white;
    return StreamBuilder(
        stream: FirestoreServicesAdmin.fetchTicketStatus(ticketID: ticketID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String status = snapshot.data!;

            if (status == 'Active') {
              backgroundColor = AppColors.green;
            } else if (status == 'Disable') {
              backgroundColor = AppColors.red;
            } else {
              backgroundColor = AppColors.blue;
            }
            return GestureDetector(
              onTap: () {
                String currentStatus =
                    (status == 'Active') ? 'Disable' : 'Active';
                FirestoreServicesAdmin.updateTicketStatus(
                    ticketID, currentStatus);
                NotificationModel notificationModel = NotificationModel(
                    title: 'Ticket listing',
                    notificationType: 'ticket_listing',
                    body:
                        'Your $ticketType ticket is $currentStatus for "$eventName"',
                    eventId: eventId,
                    status: 'Unread',
                    userId: userID);
                NotificationServices.sendNotification(
                        token: fcmToken,
                        title: 'Ticket listing',
                        body:
                            'Your $ticketType ticket is $currentStatus for "$eventName"',
                        data: notificationModel.toMapForNotifications())
                    .then((value) {
                  FireStoreServicesClient.storeNotifications(
                      notificationModel: notificationModel,
                      name: 'client_notifications');
                });
              },
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38),
                  color: backgroundColor,
                ),
                child: Center(
                  child: Text(
                    status,
                    style: TextStyle(
                      color: textColor,
                      fontSize: AppFontSize.small,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox(
              width: 100,
            );
          }
        });
  }
}

DataCell _dataCellForNames({
  required String name,
}) {
  return DataCell(Text(
    AppUtils.textTo32Characters(name),
    style: const TextStyle(
      fontSize: AppFontSize.small,
      fontWeight: FontWeight.w400,
      color: AppColors.grey,
    ),
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
  ));
}

DataCell _createDataCell(String text) {
  return DataCell(
    Text(
      AppUtils.textTo32Characters(text),
      style: const TextStyle(
        fontSize: AppFontSize.small,
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ),
  );
}

DataColumn _buildTableCell(String text) {
  return DataColumn(
    label: Center(
      child: Text(AppUtils.textTo32Characters(text),
          style: const TextStyle(
              fontSize: AppFontSize.regular,
              fontWeight: FontWeight.w600,
              color: Colors.black)),
    ),
  );
}
