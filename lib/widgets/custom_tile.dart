import 'package:flutter/material.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CustomTile extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final String? price;
  final String? imagePath;
  final String? userId;
  final String text;

  const CustomTile({
    Key? key,
    this.title,
    this.subTitle,
    this.price,
    this.imagePath,
    this.userId,
    required this.text,
  }) : super(key: key);

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.blueViolet),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0XffF7F5FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: CustomDisplayStoryImage(
                            imageUrl: '${widget.imagePath}',
                            height: 43,
                            width: 43,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: '${widget.title}',
                                color: AppColors.jetBlack,
                                size: AppSize.small,
                                weight: FontWeight.w600,
                              ),
                              CustomText(
                                title: '${widget.subTitle}',
                                color: AppColors.lightGrey.withOpacity(0.6),
                                size: AppSize.xsmall,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: CustomText(
                      title: '${widget.price}',
                      color: const Color(0XffAC8AF7),
                      size: 18,
                      weight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FireStoreServicesClient.fetchUserData(userId: widget.userId!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                child: (data.photoUrl != null) &&
                                        data.photoUrl!.isNotEmpty &&
                                        data.photoUrl != 'null'
                                    ? CustomDisplayStoryImage(
                                        imageUrl: '${data.photoUrl}',
                                        height: 43,
                                        width: 43,
                                      )
                                    : const CircleAvatar(
                                        backgroundImage:
                                            AssetImage(AppImages.profileImage),
                                      ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title: widget.text,
                                      color:
                                          AppColors.lightBlack.withOpacity(0.7),
                                      size: AppSize.verySmall,
                                      weight: FontWeight.w300,
                                    ),
                                    CustomText(
                                      title: '${data.displayName}',
                                      color:
                                          AppColors.lightBlack.withOpacity(0.6),
                                      size: AppSize.intermediate,
                                      weight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: ProfileLevelImage(
                              profileLevelsFuture:
                                  FireStoreServicesClient.fetchProfileLevels(
                                userId: data.id!,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
