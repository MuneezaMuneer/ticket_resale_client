import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/admin_panel/custom_appbar.dart';
import 'package:ticket_resale/admin_panel/drop_down_menu.dart';
import 'package:ticket_resale/admin_panel/firestore_services.dart';
import 'package:ticket_resale/constants/constants.dart';
import '../models/tickets_model.dart';
import '../providers/search_provider.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'event_model_admin.dart';
import 'notification_services.dart';

class TicketListing extends StatefulWidget {
  const TicketListing({super.key});
  @override
  State<TicketListing> createState() => _TicketListingState();
}

late Future<List<TicketModel?>> fetchEvents;
ValueNotifier<String> searchNotifier = ValueNotifier('');
TextEditingController searchcontroller = TextEditingController();
List<EventModelAdmin?> eventData = [];
List<EventModelAdmin?> filterEventData = [];
late SearchProvider searchProvider;

class _TicketListingState extends State<TicketListing> {
  @override
  void initState() {
    fetchEvents = FirestoreServices.fetchTickets();
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Consumer<SearchProvider>(
      builder: (context, searchprovider, child) => Scaffold(
          appBar: searchprovider.isSearching
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: CustomAppBarField(
                      searchController: searchcontroller,
                      setSearchValue: (searchQuery) {
                        searchNotifier.value = searchQuery;
                        filterEventData = eventData
                            .where((data) =>
                                data!.festivalName!
                                    .toLowerCase()
                                    .contains(searchQuery.toLowerCase()) ||
                                data.username!
                                    .toLowerCase()
                                    .contains(searchQuery.toLowerCase()) ||
                                data.ticketType!
                                    .toLowerCase()
                                    .contains(searchQuery.toLowerCase()))
                            .toList();
                      }))
              : const PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: CustomAppBarAdmin()),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    searchNotifier.value = '';
                  },
                  child: const CustomText(
                    title: 'Ticket listing',
                    weight: FontWeight.w600,
                    size: AppSize.regular,
                  ),
                ),
                const Gap(50),
                CustomDropDown(
                  onSelectedDate: (startDate, endDate) {
                    searchNotifier.value = '$startDate';

                    filterEventData = eventData.where((item) {
                      DateTime itemDate = DateTime.parse(item!.date!);
                      return itemDate.isAfter(
                              startDate.subtract(const Duration(days: 1))) &&
                          itemDate
                              .isBefore(endDate.add(const Duration(days: 1)));
                    }).toList();
                  },
                  onSelectedPrice: (min, max) {
                    searchNotifier.value = '$min$max';
                    filterEventData = eventData.where((item) {
                      double itemPrice = double.tryParse(item!.price!) ??
                          0; // Parse string to double
                      return itemPrice <= min && itemPrice >= max;
                    }).toList();
                  },
                  onSelectedStatus: (slectedValue) {
                    log('.........................on ui $slectedValue}');
                    searchNotifier.value = slectedValue;
                    filterEventData = eventData
                        .where((data) => data!.status!
                            .toLowerCase()
                            .contains(slectedValue.toLowerCase()))
                        .toList();
                  },
                )
              ],
            ),
            const Gap(25),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: size.height * .75,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                        ),
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
                    child: FutureBuilder<List<TicketModel?>>(
                      future: fetchEvents,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CupertinoActivityIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ValueListenableBuilder(
                              valueListenable: searchNotifier,
                              builder: (context, query, child) {
                                List<TicketModel?> ticketData = query.isEmpty
                                    ? snapshot.data!
                                    : snapshot.data!
                                        .where((data) => data!.status!
                                            .toLowerCase()
                                            .contains(query.toLowerCase()))
                                        .toList();

                                ;
                                if (ticketData.isNotEmpty) {
                                  return DataTable(
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
                                          (MapEntry<int, TicketModel?> entry) {
                                        TicketModel? ticketData = entry.value;
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
                                                id: ticketData.eventID!,
                                                isUser: false),
                                            _dataCellForNames(
                                                id: ticketData.userID!,
                                                isUser: true),
                                            _createDataCell(
                                                ticketData.ticketType!),
                                            _createDataCell(ticketData.price!),
                                            DataCell(createTableCell(
                                              ticketID: ticketData.ticketID!,
                                            )),
                                          ],
                                        );
                                      }).toList());
                                } else {
                                  return const CustomText(
                                    title: 'No record found here',
                                    size: AppSize.regular,
                                    color: AppColors.jetBlack,
                                  );
                                }
                              },
                            ),
                          );
                        } else {
                          return const Text('');
                        }
                      },
                    ),
                  ),
                ),
              ),
            ))
          ])),
    );
  }
}

DataCell _createDataCell(String text) {
  return DataCell(
    Text(
      AppUtils.textTo32Characters(text),
      style: const TextStyle(
        fontSize: AppSize.small,
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
              fontSize: AppSize.regular,
              fontWeight: FontWeight.w600,
              color: Colors.black)),
    ),
  );
}

Widget createTableCell({
  required String ticketID,
}) {
  Color backgroundColor;
  Color textColor = Colors.white;
  return StreamBuilder(
      stream: FirestoreServices.fetchTicketStatus(ticketID: ticketID),
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

              NotificationServices.sendPushNotification(
                  title: 'Ticket listing',
                  body: 'Your ticket is $currentStatus',
                  token:
                      'dqpv4lNjS9eovGSl3oNvkJ:APA91bGJDwpMS7rXp6aJNrHs0qxNEYgbn2MmUpM02L9B0iZglcMQAYzFt_H9yU6RqUANSheAy8IoC-59mFWtitseaeU7Z0UlLmdtOeKK80G883iwDWFWNS0tNg9O42oHZThFz9TWQ2pH');

              FirestoreServices.updateTicketStatus(ticketID, currentStatus);
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
                    fontSize: AppSize.small,
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

DataCell _dataCellForNames({required String id, required bool isUser}) {
  return DataCell(
    StreamBuilder(
        stream: isUser
            ? FirestoreServices.fetchUserName(userID: id)
            : FirestoreServices.fetchEventName(eventID: id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              AppUtils.textTo32Characters('${snapshot.data}'),
              style: const TextStyle(
                fontSize: AppSize.small,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            );
          } else {
            return const SizedBox();
          }
        }),
  );
}
