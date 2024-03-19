// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/utils/notification_services.dart';
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
  ValueNotifier<bool> fbNotifier = ValueNotifier<bool>(false);
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
                        fontSize: AppSize.xxlarge,
                        fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Rave Trade',
                        style: const TextStyle(
                            color: AppColors.darkpurple,
                            fontSize: AppSize.xxlarge,
                            fontWeight: FontWeight.w700),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      )
                    ],
                  ),
                ),
                const CustomText(
                  title: 'to get started',
                  weight: FontWeight.w700,
                  size: AppSize.xxlarge,
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
                        await AuthServices.signInWithGoogle(
                                context, googleNotifier, '$fcmToken')
                            .then((credential) {
                          if (credential != null) {
                            googleNotifier.value = false;
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppRoutes.navigationScreen, (route) => false);
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
                  valueListenable: fbNotifier,
                  builder: (context, value, child) {
                    return CustomButton(
                      loading: fbNotifier.value,
                      backgroundColor: AppColors.white,
                      socialText: 'Sign in with Facebook',
                      imagePath: AppSvgs.facebook,
                      socialTextWeight: FontWeight.w400,
                      isSocial: true,
                      onPressed: () async {
                        fbNotifier.value = true;
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
                        appleNotifier.value = true;
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
                  textSize: AppSize.medium,
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
                        fontSize: AppSize.medium,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Register Now ',
                        style: const TextStyle(
                            color: AppColors.electricBlue,
                            fontSize: AppSize.medium,
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
