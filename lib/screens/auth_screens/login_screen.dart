// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';
import '../../components/components.dart';
import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> googleNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> appleNotifier = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      body: AppBackground(
        imagePath: AppImages.authImage,
        isBackButton: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Sign in to ',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: AppFontSize.xxlarge,
                        fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Rave Trade',
                        style: const TextStyle(
                            color: AppColors.darkpurple,
                            fontSize: AppFontSize.xxlarge,
                            fontWeight: FontWeight.w700),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      )
                    ],
                  ),
                ),
                const CustomText(
                  title: 'to get started',
                  weight: FontWeight.w700,
                  size: AppFontSize.xxlarge,
                  color: AppColors.jetBlack,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ValueListenableBuilder(
                  valueListenable: googleNotifier,
                  builder: (context, value, child) {
                    return CustomButton(
                      loading: googleNotifier.value,
                      isSvgImage: false,
                      backgroundColor: AppColors.white,
                      socialText: 'Sign in with Gmail',
                      socialTextWeight: FontWeight.w400,
                      imagePath: AppImages.google,
                      isSocial: true,
                      onPressed: () async {
                        googleNotifier.value = true;
                        String? fcmToken = await NotificationServices
                            .getFCMCurrentDeviceToken();
                        log('message: ....$fcmToken');
                        UserModelClient userModel = UserModelClient();
                        await AuthServices.signInWithGoogle(
                          context: context,
                          googleNotifier: googleNotifier,
                          fcmToken: fcmToken!,
                          userModel: userModel,
                        ).then((credential) {
                          if (credential != null) {
                            googleNotifier.value = false;
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.navigationScreen,
                              (route) => false,
                            );
                          }
                        });
                      },
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ValueListenableBuilder(
                  valueListenable: appleNotifier,
                  builder: (context, value, child) {
                    return CustomButton(
                      loading: appleNotifier.value,
                      backgroundColor: AppColors.white,
                      socialText: 'Sign in with Apple ID',
                      imagePath: AppSvgs.apple,
                      socialTextWeight: FontWeight.w400,
                      isSocial: true,
                      onPressed: () async {
                        if (Platform.isIOS) {
                          appleNotifier.value = true;
                          AuthServices.signInWithApple(context)
                              .then((credential) {
                            if (credential != null) {
                              appleNotifier.value = false;
                              Navigator.pushNamedAndRemoveUntil(context,
                                  AppRoutes.navigationScreen, (route) => false);
                            }
                          });
                        } else {
                          SnackBarHelper.showSnackBar(context,
                              'This feature is available on iOS devices only');
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomButton(
                  btnText: 'Sign in with Email',
                  weight: FontWeight.w700,
                  textColor: AppColors.white,
                  gradient: customGradient,
                  textSize: AppFontSize.medium,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signIn);
                  },
                ),
                const Gap(30),
                RichText(
                  text: TextSpan(
                    text: 'Not a member? ',
                    style: const TextStyle(
                        color: AppColors.lightBlack,
                        fontSize: AppFontSize.medium,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Register Now ',
                        style: const TextStyle(
                            color: AppColors.electricBlue,
                            fontSize: AppFontSize.medium,
                            fontWeight: FontWeight.w400),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, AppRoutes.signUp);
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
