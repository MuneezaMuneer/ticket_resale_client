import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/widgets/widgets.dart';

import '../providers/dj_provider.dart';

class DJsListWidget extends StatelessWidget {
  final Function(String) onDjTapped;

  const DJsListWidget({Key? key, required this.onDjTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double width = size.width;
    return SizedBox(
      height: 100,
      width: width,
      child: StreamBuilder<List<DjsModel>>(
        stream: FireStoreServicesClient.fetchDjs(),
        builder: (context, djSnapshot) {
          if (djSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (djSnapshot.hasData) {
            final djs = djSnapshot.data!;

            return StreamBuilder<List<EventModalClient>>(
              stream: FireStoreServicesClient.fetchEventData(),
              builder: (context, eventSnapshot) {
                if (eventSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
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
                  if (sortedDjNames.isEmpty) {
                    return _buildText();
                  } else {
                    return Consumer<SelectedDJProvider>(
                      builder: (context, selectedDJProvider, child) {
                        return ListView.builder(
                          itemExtent: 120,
                          scrollDirection: Axis.horizontal,
                          itemCount: sortedDjNames.length,
                          itemBuilder: (context, index) {
                            final djName = sortedDjNames[index];
                            final dj =
                                djs.firstWhere((dj) => dj.name == djName);
                            bool isSelected =
                                djName == selectedDJProvider.selectedDJName;
                            return GestureDetector(
                              onTap: () {
                                onDjTapped(djName);
                                selectedDJProvider.setSelectedDJName(djName);
                              },
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.blue
                                            : AppColors.pastelBlue
                                                .withOpacity(0.7),
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
                                        const SizedBox(height: 10),
                                        CustomText(
                                          title: dj.name,
                                          color: AppColors.jetBlack
                                              .withOpacity(0.7),
                                          size: AppFontSize.verySmall,
                                          weight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
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
        'No DJ available',
        style: TextStyle(
          color: AppColors.jetBlack,
          fontSize: AppFontSize.medium,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
