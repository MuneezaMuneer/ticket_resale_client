import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/widgets/custom_gradient.dart';
import 'package:ticket_resale/widgets/custom_text.dart';
import '../constants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? child;
  final bool isNotification;
  final bool isBackButton;
  final bool isNetworkImage;
  final String? networkImage;
  const CustomAppBar(
      {super.key,
      this.title,
      this.child,
      this.isNotification = true,
      this.isBackButton = true,
      this.isNetworkImage = false,
      this.networkImage});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Container(
      height: height * 0.13,
      width: width,
      decoration: BoxDecoration(
          gradient: customGradient,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: isBackButton
                          ? const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.white,
                              size: 18,
                            )
                          : const SizedBox.shrink()),
                  SizedBox(
                      child: isNetworkImage
                          ? Padding(
                              padding: const EdgeInsets.only(top: 6, left: 10),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage('$networkImage'),
                              ),
                            )
                          : const SizedBox.shrink()),
                  const Gap(15),
                  CustomText(
                    title: '$title',
                    weight: FontWeight.w600,
                    size: AppSize.regular,
                    color: AppColors.white,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: SizedBox(
                  child: isNotification
                      ? InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.notificationScreen);
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white.withOpacity(0.1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(AppSvgs.sms),
                              )))
                      : const SizedBox.shrink()),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
