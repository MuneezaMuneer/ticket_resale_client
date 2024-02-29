// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class ProfileLevelScreen extends StatefulWidget {
  bool isBackButton;
  ProfileLevelScreen({
    Key? key,
    required this.isBackButton,
  }) : super(key: key);

  @override
  State<ProfileLevelScreen> createState() => _ProfileLevelScreenState();
}

class _ProfileLevelScreenState extends State<ProfileLevelScreen> {
  String? photoUrl;
  late Stream<List<UserModel>> fetchUserLevel;
  TextEditingController instagramController = TextEditingController();
  GlobalKey<FormState> defaultFormKey = GlobalKey<FormState>();
  late BottomSheetProvider bottomSheetProvider;
  @override
  void initState() {
    bottomSheetProvider =
        Provider.of<BottomSheetProvider>(context, listen: false);
    photoUrl = AuthServices.getCurrentUser.photoURL;
    fetchUserLevel = FireStoreServices.fetchUserLevels();
    super.initState();
  }

  @override
  void dispose() {
    instagramController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final double height = size.height;
    final double width = size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile Level',
        isBackButton: widget.isBackButton,
      ),
      body: Column(
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
                          backgroundImage: AssetImage(AppImages.profileImage))),
              Positioned(
                  left: 90, top: 70, child: SvgPicture.asset(AppSvgs.levelOne))
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
          const Gap(40),
          Expanded(
            child: Container(
              width: width,
              decoration: const BoxDecoration(
                  color: AppColors.paleGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      title: 'Your Profile Level',
                      size: AppSize.large,
                      weight: FontWeight.w600,
                      color: AppColors.jetBlack,
                    ),
                    CustomText(
                      title:
                          'Complete below mentioned steps to get higher trust level badge for you profile.',
                      size: AppSize.medium,
                      weight: FontWeight.w400,
                      softWrap: true,
                      color: AppColors.jetBlack.withOpacity(0.7),
                    ),
                    const Gap(7),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: StreamBuilder(
                          stream: fetchUserLevel,
                          builder: (context, snapshot) {
                            UserModel? currentUser;
                            if (snapshot.hasData) {
                              final data = snapshot.data!;

                              for (UserModel user in data) {
                                if (user.id ==
                                    FirebaseAuth.instance.currentUser?.uid) {
                                  currentUser = user;
                                  break;
                                }
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(20),
                                  _buildContainer(
                                    AppSvgs.levelOne,
                                    'Verify Your Email',
                                    'Level 1 Verified',
                                    'Verify for Level 1',
                                    width,
                                    currentUser!.profileLevels![
                                            'isEmailVerified'] ??
                                        false,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.profileSettings);
                                    },
                                    child: _buildContainer(
                                        AppSvgs.levelTwo,
                                        'Verify your Phone No',
                                        'Level 2 Verified',
                                        'Verify for Level 2',
                                        width,
                                        currentUser.profileLevels![
                                                'isPhoneNoVerified'] ??
                                            false),
                                  ),
                                  _buildContainer(
                                      AppSvgs.levelThree,
                                      'Connect Your PayPal',
                                      'Level 3 Verified',
                                      'Verify for Level 3',
                                      width,
                                      currentUser.profileLevels![
                                              'isPaypalVerified'] ??
                                          false),
                                  GestureDetector(
                                    onTap: () {
                                      CustomBottomSheet.showInstaBottomSheet(
                                        context: context,
                                        controller: instagramController,
                                        defaultFormKey: defaultFormKey,
                                        onTape: () async {
                                          if (defaultFormKey.currentState!
                                              .validate()) {
                                            bottomSheetProvider
                                                .setInstaProgress = true;
                                            await FireStoreServices
                                                    .verifyInstagram(
                                                        instagram:
                                                            instagramController
                                                                .text)
                                                .then((value) {
                                              FocusScope.of(context).unfocus();
                                              Navigator.pop(context);
                                            });
                                            bottomSheetProvider
                                                .setInstaProgress = false;
                                          }
                                        },
                                      );
                                    },
                                    child: _buildContainer(
                                      AppSvgs.levelFour,
                                      'Add Instagram Profile',
                                      'Level 4 Verified',
                                      'Verify for Level 4',
                                      width,
                                      currentUser.profileLevels![
                                              'isInstaVerified'] ??
                                          false,
                                    ),
                                  ),
                                  _buildContainer(
                                    AppSvgs.levelFive,
                                    'Make 5 Buy/Sell Transaction',
                                    'Level 5 Verified',
                                    'Verify for Level 5',
                                    width,
                                    currentUser.profileLevels![
                                            'isTransactionVerified'] ??
                                        false,
                                  ),
                                  _buildContainer(
                                    AppSvgs.levelSix,
                                    'Tier 5 Super Verified',
                                    'Level 6 Verified',
                                    'Verify for Level 6',
                                    width,
                                    currentUser.profileLevels![
                                            'isSuperVerified'] ??
                                        false,
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContainer(String svgPath, String title, String levelText,
      String leveltext, double width, bool isVerified) {
    Color borderColor = isVerified ? AppColors.yellow : Colors.transparent;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 55,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(43),
            color: AppColors.white,
            border: Border.all(color: borderColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: Row(
                children: [
                  SizedBox(
                    width: width < 370 ? 2 : 5,
                  ),
                  SizedBox(
                      height: 25, width: 25, child: SvgPicture.asset(svgPath)),
                  SizedBox(
                    width: width < 370 ? 0 : 2,
                  ),
                  Expanded(
                    child: CustomText(
                      title: title,
                      size: AppSize.intermediate,
                      weight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  SizedBox(
                    width: width < 370 ? 0 : 7,
                  ),
                  SvgPicture.asset(
                    AppSvgs.verified,
                    colorFilter: ColorFilter.mode(
                        isVerified ? AppColors.yellow : AppColors.purple,
                        BlendMode.srcIn),
                  ),
                  SizedBox(
                    width: width < 370 ? 0 : 5,
                  ),
                  CustomText(
                    title: isVerified ? levelText : leveltext,
                    size: AppSize.verySmall,
                    weight: FontWeight.w400,
                    color: isVerified ? AppColors.yellow : AppColors.purple,
                  ),
                  SizedBox(
                    width: width < 370 ? 5 : 9,
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
