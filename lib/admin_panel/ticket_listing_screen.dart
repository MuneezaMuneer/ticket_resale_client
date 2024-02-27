import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/admin_panel/custom_appbar.dart';
import 'package:ticket_resale/admin_panel/drop_down_menu.dart';
import 'package:ticket_resale/admin_panel/firestore_services.dart';
import 'package:ticket_resale/constants/constants.dart';

import '../providers/search_provider.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'event_model_admin.dart';

class TicketListing extends StatefulWidget {
  const TicketListing({super.key});

  @override
  State<TicketListing> createState() => _TicketListingState();
}

late Stream<List<EventModelAdmin?>> fetchEvents;
ValueNotifier<String> searchNotifier = ValueNotifier('');
TextEditingController searchcontroller = TextEditingController();
List<EventModelAdmin?> eventData = [];
List<EventModelAdmin?> filterEventData = [];
late SearchProvider searchProvider;

class _TicketListingState extends State<TicketListing> {
  @override
  void initState() {
    fetchEvents = FirestoreServices.fetchEvents();
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
                                // data.sellerName!.toLowerCase().contains(query.toLowerCase()) ||
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
                    child: StreamBuilder<List<EventModelAdmin?>>(
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
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ValueListenableBuilder(
                                  valueListenable: searchNotifier,
                                  builder: (context, query, child) {
                                    List<EventModelAdmin?> eventData =
                                        query.isEmpty
                                            ? snapshot.data!
                                            : filterEventData;
                                    if (eventData.isNotEmpty) {
                                      return DataTable(
                                          columnSpacing: width * 0.1,
                                          dividerThickness:
                                              0.0000000000000000001,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25),
                                                    topRight:
                                                        Radius.circular(25)),
                                            color: AppColors.lightPurple,
                                            border: Border.all(
                                                color: Colors.transparent),
                                          ),
                                          columns: [
                                            _buildTableCell(
                                              'Event Name',
                                            ),
                                            _buildTableCell('Seller Name'),
                                            _buildTableCell('Ticket Type'),
                                            _buildTableCell('Date'),
                                            _buildTableCell('Price'),
                                            _buildTableCell('Status')
                                          ],
                                          rows: eventData.asMap().entries.map(
                                              (MapEntry<int, EventModelAdmin?>
                                                  entry) {
                                            EventModelAdmin? eventData =
                                                entry.value;
                                            int id = entry.key;
                                            final bool isOdd = entry.key.isOdd;
                                            final Color rowColor = isOdd
                                                ? AppColors.lightPurple
                                                : AppColors.white;
                                            print(
                                                'User id is:       ${eventData!.userID}');
                                            return DataRow(
                                              color: MaterialStateProperty
                                                  .resolveWith<Color?>(
                                                      (Set<MaterialState>
                                                          states) {
                                                return rowColor;
                                              }),
                                              cells: [
                                                _createDataCell(
                                                  eventData!.festivalName ??
                                                      'N/A',
                                                ),
                                                _createDataCell('Huma Safdar'),
                                                _createDataCell(
                                                    eventData.ticketType!),
                                                _createDataCell(
                                                    eventData.date!),
                                                _createDataCell(
                                                    eventData.price!),
                                                DataCell(createTableCell(
                                                    eventData.status!,
                                                    eventData.id!,
                                                    eventData.status!)),
                                              ],
                                            );
                                          }).toList());
                                    } else {
                                      return SizedBox(
                                        width: width,
                                        child: const Center(
                                          child: CustomText(
                                            title: 'No record found here',
                                            size: AppSize.regular,
                                            color: AppColors.jetBlack,
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                            );
                          } else {
                            return const Text('');
                          }
                        }),
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
      child: Text(AppUtils.limitTextTo32Characters(text),
          style: const TextStyle(
              fontSize: AppSize.regular,
              fontWeight: FontWeight.w600,
              color: Colors.black)),
    ),
  );
}

Widget createTableCell(
    String cellText, String documentId, String currentStatus) {
  Color backgroundColor;
  Color textColor = Colors.white;

  if (cellText == 'Active') {
    backgroundColor = AppColors.green;
  } else if (cellText == 'Disable') {
    backgroundColor = AppColors.red;
  } else {
    backgroundColor = AppColors.blue;
  }

  return GestureDetector(
    onTap: () {
      String status = (currentStatus == 'Active') ? 'Disable' : 'Active';
      for (var element in filterEventData) {
        if (element!.id == documentId) {
          element.status = status;
          break;
        }
      }
      FirestoreServices.updateStatus(documentId, status);
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
          cellText,
          style: TextStyle(
            color: textColor,
            fontSize: AppSize.small,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
