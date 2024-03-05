// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';
class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  bool isRead = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 234, 248),
      appBar: const CustomAppBar(
        title: 'Notification',
        isNotification: false,
      ),
      body: Column(
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
          Expanded(
            child: Container(
                decoration: BoxDecoration(color: AppColors.white, boxShadow: [
                  BoxShadow(
                      color: AppColors.blueViolet.withOpacity(0.4),
                      blurRadius: 10)
                ]),
                child: _builderWidget(FontWeight.w600, AppColors.yellow)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Text(
              'Read',
              style: _textStyle(),
            ),
          ),
          const Gap(20),
          Expanded(
            child: _builderWidget(FontWeight.w300, AppColors.vibrantGreen),
          )
        ],
      ),
    );
  }

  Widget _builderWidget(final FontWeight weight, final Color containerColor) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
            leading: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven ? Colors.red : Colors.blue),
            ),
            title: Row(children: [
              Expanded(
                flex: 2,
                child: CustomText(
                  title: 'Posted! ',
                  size: AppSize.medium,
                  weight: weight,
                  color: AppColors.jetBlack,
                ),
              ),
              Expanded(
                flex: 8,
                child: CustomText(
                  title: 'your post successfully uploaded',
                  size: AppSize.medium,
                  weight: FontWeight.w300,
                  color: AppColors.jetBlack.withOpacity(0.7),
                ),
              )
            ]),
            subtitle: CustomText(
              title: 'Today at 9:34 PM',
              size: AppSize.small,
              weight: FontWeight.w400,
              color: AppColors.jetBlack.withOpacity(0.4),
            ));
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
