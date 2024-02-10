import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/utils/app_dialouge.dart';
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
      backgroundColor: AppColors.pastelBlue.withOpacity(0.3),
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
                    left: 90,
                    top: 70,
                    child: SvgPicture.asset(AppSvgs.levelOne))
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.profileSettings);
                    },
                    child: const CustomProfileRow(
                      leadingIcon: Icons.person_2_outlined,
                      title: 'Profile Settings',
                      color: AppColors.jetBlack,
                      iconColor: AppColors.lightGrey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.profileLevelScreen);
                    },
                    child: const CustomProfileRow(
                      svgImage: AppSvgs.level,
                      isSvg: true,
                      title: 'Your Level',
                      color: AppColors.jetBlack,
                      iconColor: AppColors.lightGrey,
                    ),
                  ),
                  const CustomProfileRow(
                    leadingIcon: Icons.notifications_none,
                    title: 'Notification',
                    color: AppColors.jetBlack,
                    arrowBack: false,
                    iconColor: AppColors.lightGrey,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.connectScreen);
                    },
                    child: const CustomProfileRow(
                      leadingIcon: Icons.paypal,
                      leadingColor: AppColors.electricBlue,
                      title: 'Connect paypal',
                      color: AppColors.electricBlue,
                      iconColor: AppColors.electricBlue,
                    ),
                  ),
                  const CustomProfileRow(
                    leadingIcon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    color: AppColors.jetBlack,
                    iconColor: AppColors.lightGrey,
                  ),
                  const CustomProfileRow(
                    svgImage: AppSvgs.termOfUse,
                    isSvg: true,
                    title: 'Term of Use',
                    color: AppColors.jetBlack,
                    iconColor: AppColors.lightGrey,
                  ),
                  const CustomProfileRow(
                    leadingIcon: Icons.logout,
                    leadingColor: AppColors.blueViolet,
                    title: 'Logout',
                    color: AppColors.blueViolet,
                    iconColor: AppColors.blueViolet,
                  ),
                  GestureDetector(
                    onTap: () {
                      deleteDialog(context: context);
                    },
                    child: const CustomProfileRow(
                      leadingIcon: Icons.delete_outline,
                      isLastRow: true,
                      leadingColor: AppColors.raddishPink,
                      title: 'Delete Account',
                      color: AppColors.raddishPink,
                      iconColor: AppColors.raddishPink,
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
