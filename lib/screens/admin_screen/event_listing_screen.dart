import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/db_services/firestore_services_admin.dart';
import 'package:ticket_resale/providers/search_provider.dart';
import '../../constants/constants.dart';
import '../../models/create_event.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class EventListing extends StatefulWidget {
  const EventListing({super.key});
  @override
  State<EventListing> createState() => _EventListingState();
}


class _EventListingState extends State<EventListing> {
  late Stream<List<CreateEvents>> fetchEvents;
  ValueNotifier<String> searchNotifier = ValueNotifier('');
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    fetchEvents = FirestoreServicesAdmin.fetchEventData();

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
                        text: 'Search via event name & place',
                        searchController: controller,
                        setSearchValue: (searchQuery) {
                          searchNotifier.value = searchQuery;
                        }))
                : const PreferredSize(
                    preferredSize: Size.fromHeight(60),
                    child: CustomAppBarAdmin()),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(30),
                  SizedBox(
                    width: width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          title: 'Event listing',
                          weight: FontWeight.w600,
                          size: AppSize.regular,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.createEvent);
                          },
                          child: Container(
                            height: 35,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: customGradient),
                            child: const Center(
                              child: Text(
                                ' Add Event   + ',
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(25),
                  Expanded(
                    child: SizedBox(
                      width: width,
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
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder<List<CreateEvents>>(
                                stream: fetchEvents,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CupertinoActivityIndicator();
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else if (snapshot.hasData) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: ValueListenableBuilder(
                                          valueListenable: searchNotifier,
                                          builder: (context, query, child) {
                                            List<
                                                CreateEvents> eventsdata = query
                                                    .isEmpty
                                                ? snapshot.data!
                                                : snapshot.data!
                                                    .where((data) =>
                                                        data.eventName!
                                                            .toLowerCase()
                                                            .contains(query
                                                                .toLowerCase()) ||
                                                        data.location!
                                                            .toLowerCase()
                                                            .contains(query
                                                                .toLowerCase()))
                                                    .toList();

                                            if (eventsdata.isNotEmpty) {
                                              return DataTable(
                                                  dividerThickness:
                                                      0.0000000000000000001,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    25),
                                                            topRight:
                                                                Radius.circular(
                                                                    25)),
                                                    color:
                                                        AppColors.lightPurple,
                                                    border: Border.all(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  columns: [
                                                    _buildTableCell(
                                                      'Image',
                                                    ),
                                                    _buildTableCell(
                                                        'EventName'),
                                                    _buildTableCell('About'),
                                                    _buildTableCell('Time'),
                                                    _buildTableCell('Date'),
                                                    _buildTableCell('Place')
                                                  ],
                                                  rows: eventsdata
                                                      .asMap()
                                                      .entries
                                                      .map((MapEntry<int,
                                                              CreateEvents?>
                                                          entry) {
                                                    CreateEvents? eventData =
                                                        entry.value;
                                                    final bool isOdd =
                                                        entry.key.isOdd;
                                                    final Color rowColor = isOdd
                                                        ? AppColors.lightPurple
                                                        : AppColors.white;

                                                    return DataRow(
                                                      color: MaterialStateProperty
                                                          .resolveWith<
                                                              Color?>((Set<
                                                                  MaterialState>
                                                              states) {
                                                        return rowColor;
                                                      }),
                                                      cells: [
                                                        DataCell(CircleAvatar(
                                                          radius: 15,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  eventData!
                                                                      .imageUrl!),
                                                        )),
                                                        _dataCellForNames(
                                                            title: eventData
                                                                .eventName!),
                                                        _dataCellForNames(
                                                          title: eventData
                                                              .description!,
                                                        ),
                                                        _createDataCell(
                                                            eventData.time!),
                                                        _createDataCell(
                                                            eventData.date!),
                                                        _createDataCell(
                                                            eventData
                                                                .location!),
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
                                          }),
                                    );
                                  } else {
                                    return const Text('');
                                  }
                                }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
  
Widget createTableCell({
  required String ticketID,
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
          return const SizedBox();
        }
      });
}

}

DataCell _dataCellForNames({required String title}) {
  return DataCell(
    Text(
      AppUtils.textTo32Characters(title),
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
