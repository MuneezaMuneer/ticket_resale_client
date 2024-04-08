import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CustomRow extends StatefulWidget {
  final String userId;
  CustomRow({super.key, required this.userId});

  @override
  State<CustomRow> createState() => _CustomRowState();
}

class _CustomRowState extends State<CustomRow> {
  late Stream<List<FeedbackModel>> fetchRatings;
  @override
  void initState() {
    fetchRatings = FireStoreServicesClient.fetchFeedback(userId: widget.userId);

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
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: CustomText(
              title: '(23 Transactions) ',
              weight: FontWeight.w400,
              size: AppFontSize.small,
              color: AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}
