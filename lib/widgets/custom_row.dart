import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class ShowTransction extends StatefulWidget {
  final String userId;
  ShowTransction({super.key, required this.userId});

  @override
  State<ShowTransction> createState() => _ShowTransctionState();
}

class _ShowTransctionState extends State<ShowTransction> {
  late Stream<List<FeedbackModel>> fetchRatings;
  late Stream<UserModelClient> fetchUserLevel;
  late String totalTransactions;
  @override
  void initState() {
    totalTransactions = '';
    fetchRatings = FireStoreServicesClient.fetchFeedback(userId: widget.userId);
    fetchUserLevel =
        FireStoreServicesClient.fetchUserLevels(userId: widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Row(
        children: [
          const Icon(
            Icons.star,
            color: AppColors.amber,
            size: 20,
          ),
          StreamBuilder<List<FeedbackModel>>(
            stream: fetchRatings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder<Map<String, dynamic>>(
                  future:
                      FireStoreServicesClient.calculateAverages(snapshot.data),
                  builder: (context, averageRatingSnapshot) {
                    if (averageRatingSnapshot.hasData) {
                      final Map<String, dynamic> averages =
                          averageRatingSnapshot.data!;
                      final double averageRating = averages['rating'] ?? 0.0;
                      return CustomText(
                        title: averageRating.toStringAsFixed(1),
                        weight: FontWeight.w600,
                        size: AppFontSize.large,
                        color: AppColors.charcoal,
                      );
                    } else {
                      return CupertinoActivityIndicator();
                    }
                  },
                );
              } else {
                return CupertinoActivityIndicator();
              }
            },
          ),
          StreamBuilder(
            stream: fetchUserLevel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CupertinoActivityIndicator());
              } else if (snapshot.hasData) {
                UserModelClient? currentUser = snapshot.data!;
                totalTransactions = currentUser
                            .profileLevels!['number_of_transactions'] !=
                        null
                    ? '${currentUser.profileLevels!['number_of_transactions']} transaction${currentUser.profileLevels!['number_of_transactions'] == 1 ? '' : 's'}'
                    : '(0 Transactions) ';
                return Padding(
                  padding: EdgeInsets.only(top: 5, left: 7),
                  child: CustomText(
                    title: totalTransactions,
                    weight: FontWeight.w400,
                    size: AppFontSize.small,
                    color: AppColors.charcoal,
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
