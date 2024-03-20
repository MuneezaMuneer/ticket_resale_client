import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/admin_panel/firestore_services_admin.dart';
import 'package:ticket_resale/providers/clear_provider.dart';
import '../constants/constants.dart';
import '../models/fetch_ticket_model.dart';
import '../providers/search_provider.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import '../components/filter_menu_admin.dart';

class TicketListing extends StatefulWidget {
  const TicketListing({super.key});
  @override
  State<TicketListing> createState() => _TicketListingState();
}

List<TicketModal> userData = [];
TextEditingController searchController = TextEditingController();

class _TicketListingState extends State<TicketListing> {
  late Stream<List<TicketModal>> fetchEvents;
  TextEditingController controller = TextEditingController();
  ValueNotifier<String> searchNotifier = ValueNotifier('');
  TextEditingController searchcontroller = TextEditingController();
  List<TicketModal> filterEventData = [];
  List<TicketModal> eventData = [];
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
                      searchNotifier.value = searchQuery;
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
          padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
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
                      size: AppSize.regular,
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
                    child: StreamBuilder<List<TicketModal>>(
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
                              List<TicketModal?> ticketData =
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
                                          (MapEntry<int, TicketModal?> entry) {
                                        TicketModal? ticketData = entry.value;
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
                                    size: AppSize.regular,
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
}

DataCell _dataCellForNames({
  required String name,
}) {
  return DataCell(Text(
    AppUtils.textTo32Characters(name),
    style: const TextStyle(
      fontSize: AppSize.small,
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
  required String fcmToken,
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
              NotificationServices.sendNotification(
                  context: context,
                  token: fcmToken,
                  title: currentStatus,
                  body: 'Your ticket is $currentStatus');
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
