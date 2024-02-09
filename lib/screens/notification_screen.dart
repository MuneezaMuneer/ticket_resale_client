import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/custom_appbar.dart';
import 'package:ticket_resale/widgets/custom_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(
            title: 'Notification',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: CustomText(
                  title: 'Unread',
                  size: AppSize.medium,
                  weight: FontWeight.w600,
                  color: AppColors.jetBlack,
                ),
              ),
              const Gap(20),
              Container(
                height: height * 0.32,
                width: width,
                color: AppColors.white,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.yellow),
                          ),
                          const Gap(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CustomText(
                                    title: 'Posted! ',
                                    size: AppSize.medium,
                                    weight: FontWeight.w600,
                                    color: AppColors.jetBlack,
                                  ),
                                  CustomText(
                                    title: 'your post successfully uploaded',
                                    size: AppSize.medium,
                                    weight: FontWeight.w300,
                                    color: AppColors.jetBlack.withOpacity(0.7),
                                  )
                                ],
                              ),
                              const Gap(3),
                              CustomText(
                                title: 'Today at 9:34 PM',
                                size: AppSize.small,
                                weight: FontWeight.w400,
                                color: AppColors.jetBlack.withOpacity(0.4),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: CustomText(
                  title: 'Unread',
                  size: AppSize.medium,
                  weight: FontWeight.w600,
                  color: AppColors.jetBlack,
                ),
              ),
              SizedBox(
                height: height * 0.3,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.tealBlue),
                          ),
                          const Gap(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title:
                                    'Posted! your post successfully uploaded',
                                size: AppSize.medium,
                                weight: FontWeight.w300,
                                color: AppColors.jetBlack.withOpacity(0.7),
                              ),
                              const Gap(3),
                              CustomText(
                                title: 'Yesterday at 11:12 AM',
                                size: AppSize.small,
                                weight: FontWeight.w400,
                                color: AppColors.jetBlack.withOpacity(0.4),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
