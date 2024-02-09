import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../constants/constants.dart';

import '../widgets/widgets.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile Settings',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                const SizedBox(
                  height: 140,
                  width: 140,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(AppImages.profileImage),
                  ),
                ),
                Positioned(
                    left: 60, top: 55, child: SvgPicture.asset(AppSvgs.camera))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const CustomText(
              title: 'Samantha Pate',
              weight: FontWeight.w600,
              size: AppSize.large,
              color: AppColors.jetBlack,
            ),
            const SizedBox(
              height: 5,
            ),
            const CustomRow(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: 'FullName',
                    color: AppColors.blueGrey,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextField(
                    borderColor: AppColors.silver,
                    hintText: 'Samantha Pate',
                    hintStyle: TextStyle(
                        color: AppColors.blueGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.small),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const CustomText(
                    title: 'Instagram Username',
                    color: AppColors.blueGrey,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextField(
                    borderColor: AppColors.silver,
                    hintText: '@SamanthaPate',
                    hintStyle: TextStyle(
                        color: AppColors.blueGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.small),
                  ),
                  const SizedBox(height: 12),
                  const CustomText(
                    title: 'Email ID',
                    color: AppColors.blueGrey,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextField(
                    borderColor: AppColors.silver,
                    hintText: 'Email',
                    trailingText: 'Verify',
                    isTrailingText: true,
                    hintStyle: TextStyle(
                        color: AppColors.blueGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.small),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const CustomText(
                    title: 'Phone No',
                    color: AppColors.blueGrey,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      IntlPhoneField(
                        flagsButtonPadding: const EdgeInsets.all(8),
                        dropdownIcon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Color(0xFF9E9E9E),
                        ),
                        dropdownIconPosition: IconPosition.trailing,
                        cursorColor: AppColors.silver,
                        decoration: InputDecoration(
                          hintText: 'eg. 2324 1231 4230',
                          hintStyle: const TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          contentPadding: const EdgeInsets.only(
                              left: 10, top: 15, bottom: 15),
                          enabled: true,
                          fillColor: AppColors.silver,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.silver,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.silver,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        validator: (phone) {
                          if (phone == null || phone.number.isEmpty) {
                            return 'Please enter a phone number';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (phone) {},
                      ),
                      const Positioned(
                        right: 20,
                        top: 15,
                        child: CustomText(
                          title: 'Verify',
                          color: AppColors.springGreen,
                          weight: FontWeight.w600,
                          size: AppSize.medium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const CustomText(
                    title: 'DOB',
                    color: AppColors.blueGrey,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextField(
                    borderColor: AppColors.silver,
                    hintText: 'date of birth',
                    hintStyle: TextStyle(
                        color: AppColors.blueGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.small),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const CustomText(
                    title: 'Country',
                    color: AppColors.blueGrey,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextField(
                    borderColor: AppColors.silver,
                    hintText: 'country',
                    suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                    hintStyle: TextStyle(
                        color: AppColors.blueGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.small),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const CustomText(
                    title: 'State',
                    color: AppColors.blueGrey,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextField(
                    borderColor: AppColors.silver,
                    hintText: 'state',
                    suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                    hintStyle: TextStyle(
                        color: AppColors.blueGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.small),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const CustomText(
                    title: 'City',
                    color: AppColors.blueGrey,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextField(
                    borderColor: AppColors.silver,
                    hintText: 'city',
                    suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                    hintStyle: TextStyle(
                        color: AppColors.blueGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.small),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const CustomText(
                    title: 'Zip Code',
                    color: AppColors.blueGrey,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomTextField(
                    borderColor: AppColors.silver,
                    hintText: 'code',
                    hintStyle: TextStyle(
                        color: AppColors.blueGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSize.small),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: CustomButton(
                      backgroundColor: AppColors.white,
                      btnText: 'Start with Conversation',
                      weight: FontWeight.w700,
                      textColor: AppColors.white,
                      gradient: customGradient,
                      textSize: AppSize.regular,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
