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
      backgroundColor: const Color.fromARGB(255, 230, 234, 248),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Text(
                  'Unread',
                  style: _textStyle(),
                ),
              ),
              const Gap(20),
              Container(
                  height: height * 0.32,
                  width: width,
                  color: AppColors.white.withOpacity(0.2),
                  child: _builderWidget(FontWeight.w600, AppColors.yellow)),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Text(
                  'Read',
                  style: _textStyle(),
                ),
              ),
              SizedBox(
                  height: height * 0.36,
                  child:
                      _builderWidget(FontWeight.w300, AppColors.vibrantGreen))
            ],
          )
        ],
      ),
    );
  }

  Widget _builderWidget(final FontWeight weight, final Color containerColor) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: containerColor),
              ),
              const Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        title: 'Posted! ',
                        size: AppSize.medium,
                        weight: weight,
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
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
        color: AppColors.jetBlack,
        fontSize: AppSize.medium,
        fontWeight: FontWeight.w600);
  }
}
