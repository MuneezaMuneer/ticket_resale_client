import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';

import '../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
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
                    left: 90, top: 70, child: SvgPicture.asset(AppSvgs.level1))
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
            const SizedBox(
              height: 3,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  CustomProfileRow(
                    leadingIcon: Icons.person_2_outlined,
                    title: 'Profile Settings',
                    color: AppColors.jetBlack,
                    trailingIcon: Icons.arrow_forward_ios,
                    iconColor: AppColors.lightGrey,
                  ),
                  CustomProfileRow(
                    svgImage: AppSvgs.level,
                    isSvg: true,
                    title: 'Your Level',
                    color: AppColors.jetBlack,
                    trailingIcon: Icons.arrow_forward_ios,
                    iconColor: AppColors.lightGrey,
                  ),
                  CustomProfileRow(
                    leadingIcon: Icons.notifications_none,
                    title: 'Notification',
                    color: AppColors.jetBlack,
                    trailingIcon: Icons.arrow_forward_ios,
                    iconColor: AppColors.lightGrey,
                  ),
                  CustomProfileRow(
                    leadingIcon: Icons.paypal,
                    leadingColor: AppColors.electricBlue,
                    title: 'Connect paypal',
                    color: AppColors.electricBlue,
                    trailingIcon: Icons.arrow_forward_ios,
                    iconColor: AppColors.electricBlue,
                  ),
                  CustomProfileRow(
                    leadingIcon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    color: AppColors.jetBlack,
                    trailingIcon: Icons.arrow_forward_ios,
                    iconColor: AppColors.lightGrey,
                  ),
                  CustomProfileRow(
                    svgImage: AppSvgs.termOfUse,
                    isSvg: true,
                    title: 'Term of Use',
                    color: AppColors.jetBlack,
                    trailingIcon: Icons.arrow_forward_ios,
                    iconColor: AppColors.lightGrey,
                  ),
                  CustomProfileRow(
                    leadingIcon: Icons.logout,
                    leadingColor: AppColors.blueViolet,
                    title: 'Logout',
                    color: AppColors.blueViolet,
                    trailingIcon: Icons.arrow_forward_ios,
                    iconColor: AppColors.blueViolet,
                  ),
                  CustomProfileRow(
                    leadingIcon: Icons.delete_outline,
                    leadingColor: AppColors.raddishPink,
                    title: 'Delete Account',
                    color: AppColors.raddishPink,
                    trailingIcon: Icons.arrow_forward_ios,
                    iconColor: AppColors.raddishPink,
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
