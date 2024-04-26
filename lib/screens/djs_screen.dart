import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class DJsListWidget extends StatefulWidget {
  @override
  State<DJsListWidget> createState() => _DJsListWidgetState();
}

class _DJsListWidgetState extends State<DJsListWidget> {
  late Stream<List<EventModalClient>> fetchEventData;
  late Stream<List<DjsModel>> fetchDjs;
  @override
  void initState() {
    fetchEventData = FireStoreServicesClient.fetchEventData();
    fetchDjs = FireStoreServicesClient.fetchDjs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return SizedBox(
      height: 100,
      child: StreamBuilder<List<DjsModel>>(
        stream: fetchDjs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData) {
            final djs = snapshot.data!;

            return StreamBuilder<List<EventModalClient>>(
              stream: fetchEventData,
              builder: (context, eventSnapshot) {
                if (eventSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CupertinoActivityIndicator());
                } else if (eventSnapshot.hasData) {
                  final events = eventSnapshot.data!;

                  Map<String, int> djCounts = {};
                  for (var event in events) {
                    if (djCounts.containsKey(event.djName)) {
                      djCounts[event.djName!] = djCounts[event.djName]! + 1;
                    } else {
                      djCounts[event.djName!] = 1;
                    }
                  }
                  print('DJ Counts: $djCounts');
                  List<String> sortedDjNames = djCounts.keys.toList()
                    ..sort((a, b) => djCounts[b]!.compareTo(djCounts[a]!));
                  print('Sorted DJ Names: $sortedDjNames');
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sortedDjNames.length,
                    itemBuilder: (context, index) {
                      final djName = sortedDjNames[index];
                      final dj = djs.firstWhere((dj) => dj.name == djName);
                      return GestureDetector(
                        onTap: () {
                          showAdaptiveDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog.adaptive(
                                title: SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: Text(
                                    "Events for ${dj.name}",
                                    style: TextStyle(
                                        fontSize: AppFontSize.large,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                content: SizedBox(
                                  height: 150,
                                  width: 200,
                                  child: SingleChildScrollView(
                                    child: ListBody(
                                      children: events
                                          .where(
                                              (event) => event.djName == djName)
                                          .map((event) => ListTile(
                                                title: Text(
                                                    '${event.eventName!}',
                                                    style: TextStyle(
                                                        color: AppColors.black,
                                                        fontSize:
                                                            AppFontSize.regular,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: SizedBox(
                          height: height * 0.07,
                          width: width * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.pastelBlue.withOpacity(0.7),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0XffF7F5FF),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    child: CustomDisplayStoryImage(
                                      height: 47,
                                      width: 47,
                                      imageUrl: dj.imageUrl!,
                                    ),
                                  ),
                                  const Gap(10),
                                  CustomText(
                                    title: dj.name,
                                    color: AppColors.jetBlack.withOpacity(0.7),
                                    size: AppFontSize.verySmall,
                                    weight: FontWeight.w600,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  print('No Event Data');
                  return _buildText();
                }
              },
            );
          } else {
            print('No DJ Data');
            return _buildText();
          }
        },
      ),
    );
  }

  Widget _buildText() {
    return const Center(
        child: Text(
      'No Dj',
      style: TextStyle(
          color: AppColors.jetBlack,
          fontSize: AppFontSize.medium,
          fontWeight: FontWeight.w400),
    ));
  }
}
