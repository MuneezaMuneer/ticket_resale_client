import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/constants/app_colors.dart';
import 'package:ticket_resale/constants/app_images.dart';
import 'package:ticket_resale/constants/app_textsize.dart';
import 'package:ticket_resale/widgets/widgets.dart';

deleteDialog({required BuildContext context}) {
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
                size: AppSize.medium,
                weight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              CustomText(
                title: 'Account will be permanently deleted.',
                color: AppColors.jetBlack.withOpacity(0.8),
                size: AppSize.medium,
                weight: FontWeight.w400,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: 120,
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
                width: 120,
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

ticketSellDialog({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        title: Column(
          children: [
            SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  AppImages.ticket,
                  fit: BoxFit.cover,
                )),
            const CustomText(
              title: 'Are you sure?',
              color: AppColors.jetBlack,
              size: AppSize.large,
              weight: FontWeight.w700,
            ),
            CustomText(
              title:
                  'Are you sure you want to sell this ticket on below mentioned details.',
              color: AppColors.jetBlack.withOpacity(0.8),
              maxLines: 2,
              size: AppSize.medium,
              softWrap: true,
              weight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: 'Price offered',
                  size: AppSize.xmedium,
                  weight: FontWeight.w400,
                  color: AppColors.jetBlack,
                ),
                CustomText(
                  title: '\$300',
                  size: AppSize.xmedium,
                  weight: FontWeight.w400,
                  color: AppColors.blueViolet,
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: 'Buyer',
                  size: AppSize.xmedium,
                  weight: FontWeight.w400,
                  color: AppColors.jetBlack,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(AppImages.profile),
                      ),
                    ),
                    Gap(10),
                    CustomText(
                      title: 'Leslie Alexander',
                      size: AppSize.intermediate,
                      weight: FontWeight.w400,
                      color: AppColors.jetBlack,
                    )
                  ],
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: 120,
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
                width: 120,
                child: CustomButton(
                  onPressed: () {},
                  textColor: AppColors.white,
                  textSize: AppSize.medium,
                  btnText: 'Confirm',
                  gradient: customGradient,
                  weight: FontWeight.w600,
                ),
              )
            ],
          ),
        ],
      );
    },
  );
}
