import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ticket_resale/screens/routes.dart';

import '../components/components.dart';
import '../constants/constants.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double height = size.height;

    return Scaffold(
      body: AuthBackgroundView(
        imagePath: AppImages.authImage,
        isBackButton: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                    text: 'Login to ',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: AppSize.large,
                        fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Rave Trade',
                          style: const TextStyle(
                              color: AppColors.darkpurple,
                              fontSize: AppSize.large,
                              fontWeight: FontWeight.w700),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // navigate to desired screen
                            })
                    ]),
              ),
              const CustomText(
                title: 'to get started',
                weight: FontWeight.w700,
                size: AppSize.large,
                color: AppColors.jetBlack,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomButton(
                isSvgImage: false,
                backgroundColor: AppColors.white,
                socialText: 'Sign in with Gmail',
                imagePath: AppImages.google,
                isSocial: true,
                onPressed: () {},
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomButton(
                backgroundColor: AppColors.white,
                socialText: 'Sign in with Facebook',
                imagePath: AppSvgs.facebook,
                isSocial: true,
                onPressed: () {},
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomButton(
                backgroundColor: AppColors.white,
                socialText: 'Sign in with Apple ID',
                imagePath: AppSvgs.apple,
                isSocial: true,
                onPressed: () {},
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomButton(
                backgroundColor: AppColors.white,
                btnText: 'Sign in with Email',
                weight: FontWeight.w700,
                textColor: AppColors.white,
                gradient: customGradient,
                textSize: AppSize.medium,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signIn);
                },
              ),
              SizedBox(
                height: height * 0.04,
              ),
              RichText(
                text: TextSpan(
                  text: 'Not a member? ',
                  style: const TextStyle(
                      color: AppColors.blueGrey,
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
                          // navigate to desired screen
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
