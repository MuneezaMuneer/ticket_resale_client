import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/widgets/widgets.dart';
import '../../constants/constants.dart';
import '../../utils/utils.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({super.key});
  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  late Stream<List<UserModelAdmin?>> fetchUserData;
  ValueNotifier<String> searchNotifier = ValueNotifier('');
  TextEditingController searchcontroller = TextEditingController();
  bool isOdd = false;
  @override
  void initState() {
    fetchUserData = FirestoreServicesAdmin.fetchUserData();
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
                      text: 'Search via name & phoneNo',
                      searchController: searchcontroller,
                      setSearchValue: (searchQuery) {
                        searchNotifier.value = searchQuery;
                      }))
              : const PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: CustomAppBarAdmin()),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Gap(30),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: CustomText(
                title: 'User Management',
                weight: FontWeight.w600,
                size: AppFontSize.regular,
              ),
            ),
            const Gap(25),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10),
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
                child: StreamBuilder<List<UserModelAdmin?>>(
                    stream: fetchUserData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ValueListenableBuilder(
                              valueListenable: searchNotifier,
                              builder: (context, query, child) {
                                List<UserModelAdmin?> eventData = query.isEmpty
                                    ? snapshot.data!
                                    : snapshot.data!
                                        .where((data) => data!.name!
                                            .toLowerCase()
                                            .contains(query.toLowerCase()))
                                        .toList();
                                if (eventData.isNotEmpty) {
                                  return DataTable(
                                      columnSpacing: width * 0.1,
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
                                          ' Name',
                                        ),
                                        _buildTableCell('Email'),
                                        _buildTableCell('Instagram'),
                                        _buildTableCell('Phone No.'),
                                      ],
                                      rows: eventData.asMap().entries.map(
                                          (MapEntry<int, UserModelAdmin?>
                                              entry) {
                                        UserModelAdmin? userData = entry.value;
                                        final bool isOdd = entry.key.isOdd;
                                        final Color rowColor = isOdd
                                            ? AppColors.lightPurple
                                            : AppColors.white;

                                        return DataRow(
                                          color: WidgetStateProperty
                                              .resolveWith<Color?>(
                                                  (Set<WidgetState> states) {
                                            return rowColor;
                                          }),
                                          cells: [
                                            _createDataCell(
                                              userData!.name ?? 'N/A',
                                            ),
                                            _createDataCell('Huma Safdar'),
                                            _createDataCell(
                                                userData.instaUsername !=
                                                            null &&
                                                        userData.instaUsername!
                                                            .isNotEmpty
                                                    ? userData.instaUsername!
                                                    : 'xyz'),
                                            _createDataCell(userData.phoneNo !=
                                                        null &&
                                                    userData.phoneNo!.isNotEmpty
                                                ? userData.phoneNo!
                                                : 'No Number provider here'),
                                          ],
                                        );
                                      }).toList());
                                } else {
                                  return SizedBox(
                                    width: width,
                                    child: const Center(
                                      child: CustomText(
                                        title: 'No record found here',
                                        size: AppFontSize.regular,
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
      FirestoreServicesAdmin.updateUserStatus(documentId, status);
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
            fontSize: AppFontSize.small,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
