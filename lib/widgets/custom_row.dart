import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/auth_services.dart';
import 'package:ticket_resale/db_services/firestore_services_client.dart';
import 'package:ticket_resale/widgets/custom_text.dart';

class CustomRow extends StatefulWidget {
  const CustomRow({super.key});

  @override
  State<CustomRow> createState() => _CustomRowState();
}

class _CustomRowState extends State<CustomRow> {
  late Future<List<int>> fetchRatings;
  @override
  void initState() {
    fetchRatings = FireStoreServicesClient.fetchRatings(
        currentUser: AuthServices.getCurrentUser.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 160,
      child: Row(
        children: [
         const Icon(
            Icons.star,
            color: AppColors.amber,
            size: 20,
          ),
          FutureBuilder(
            future:fetchRatings ,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                
              }
              return const CustomText(
              title: '4.7 ',
              weight: FontWeight.w600,
              size: AppSize.large,
              color: AppColors.charcoal,
            );
            },
          ),
        const   Padding(
            padding: EdgeInsets.only(top: 8),
            child: CustomText(
              title: '(23 Transactions) ',
              weight: FontWeight.w400,
              size: AppSize.small,
              color: AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}
