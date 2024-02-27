import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/utils/utils.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SwitchProvider switchProvider;
  String? photoUrl;

  @override
  void initState() {
    photoUrl = AuthServices.getCurrentUser.photoURL;
    Provider.of<SwitchProvider>(context, listen: false).loadPreferences();
    switchProvider = Provider.of<SwitchProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBlue.withOpacity(0.3),
      appBar: const CustomAppBar(
        title: 'Profile',
        isBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                SizedBox(
                    height: 140,
                    width: 140,
                    child: photoUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: "$photoUrl",
                              placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(
                                color: AppColors.blueViolet,
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const CircleAvatar(
                            backgroundImage:
                                AssetImage(AppImages.profileImage))),
                Positioned(
                    left: 90,
                    top: 70,
                    child: SvgPicture.asset(AppSvgs.levelOne))
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            CustomText(
              title: '${FirebaseAuth.instance.currentUser!.displayName}',
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
                  InkWell(
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
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.profileLevelScreen,
                        arguments: true,
                      );
                    },
                    child: const CustomProfileRow(
                      svgImage: AppSvgs.level,
                      isSvg: true,
                      title: 'Your Level',
                      color: AppColors.jetBlack,
                      iconColor: AppColors.lightGrey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.notificationScreen);
                    },
                    child: const CustomProfileRow(
                      leadingIcon: Icons.notifications_none,
                      title: 'Notification',
                      color: AppColors.jetBlack,
                      arrowBack: false,
                      iconColor: AppColors.lightGrey,
                    ),
                  ),
                  InkWell(
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
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.privacyScreen);
                    },
                    child: const CustomProfileRow(
                      leadingIcon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      color: AppColors.jetBlack,
                      iconColor: AppColors.lightGrey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.termOfUseScreen);
                    },
                    child: const CustomProfileRow(
                      svgImage: AppSvgs.termOfUse,
                      isSvg: true,
                      title: 'Term of Use',
                      color: AppColors.jetBlack,
                      iconColor: AppColors.lightGrey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AuthServices.signOut();
                      Navigator.pushNamed(context, AppRoutes.logIn);
                    },
                    child: const CustomProfileRow(
                      leadingIcon: Icons.logout,
                      leadingColor: AppColors.blueViolet,
                      title: 'Logout',
                      color: AppColors.blueViolet,
                      iconColor: AppColors.blueViolet,
                    ),
                  ),
                  InkWell(
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
