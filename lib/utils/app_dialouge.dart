import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/app_colors.dart';
import 'package:ticket_resale/constants/app_images.dart';
import 'package:ticket_resale/constants/app_textsize.dart';
import 'package:ticket_resale/widgets/widgets.dart';

customDialog({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        title: SizedBox(
          height: 230,
          child: Column(
            children: [
              SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    AppImages.personBold,
                    fit: BoxFit.cover,
                  )),
              const CustomText(
                title: 'Delete Account',
                color: AppColors.jetBlack,
                size: AppSize.large,
                weight: FontWeight.w700,
              ),
              CustomText(
                title: 'Are you sure to delete your account.',
                color: AppColors.jetBlack.withOpacity(0.8),
                size: AppSize.small,
                weight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              CustomText(
                title: 'Account will be permanently deleted.',
                color: AppColors.jetBlack.withOpacity(0.8),
                size: AppSize.small,
                weight: FontWeight.w400,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 100,
                child: CustomButton(
                  onPressed: () {},
                  btnText: 'Cancel',
                  backgroundColor: AppColors.white,
                  borderColor: AppColors.jetBlack,
                  textColor: AppColors.jetBlack,
                  weight: FontWeight.w500,
                  textSize: AppSize.xmedium,
                ),
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: CustomButton(
                  onPressed: () {},
                  btnText: 'Delete',
                  backgroundColor: AppColors.red,
                  borderColor: AppColors.red,
                  textColor: AppColors.white,
                  weight: FontWeight.w700,
                  textSize: AppSize.xmedium,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
