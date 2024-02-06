import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:ticket_resale/components/auth_background_view.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/screens/routes.dart';

import '../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double height = size.height;
    return Scaffold(
      body: AuthBackgroundView(
        imagePath: AppImages.authImage,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                    text: 'Sign in ',
                    style: const TextStyle(
                        color: AppColors.darkpurple,
                        fontSize: AppSize.large,
                        fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'to Continue',
                          style: const TextStyle(
                              color: AppColors.jetBlack,
                              fontSize: AppSize.large,
                              fontWeight: FontWeight.w700),
                          recognizer: TapGestureRecognizer()..onTap = () {})
                    ]),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const CustomTextField(
                borderColor: AppColors.silver,
                hintText: 'Email ID',
                keyBoardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const CustomTextField(
                borderColor: AppColors.silver,
                hintText: 'Password',
                suffixIcon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: AppColors.silver,
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: CustomText(
                  title: 'Forgot Password?',
                  color: AppColors.electricBlue,
                  weight: FontWeight.w400,
                  size: AppSize.small,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              CustomButton(
                backgroundColor: AppColors.white,
                btnText: 'Sign in',
                weight: FontWeight.w700,
                textColor: AppColors.white,
                gradient: customGradient,
                textSize: AppSize.xmedium,
                onPressed: () {},
              ),
              SizedBox(
                height: height * 0.06,
              ),
              RichText(
                text: TextSpan(
                  text: 'Not a member? ',
                  style: const TextStyle(
                      color: AppColors.blueGrey,
                      fontSize: AppSize.small,
                      fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Register Now ',
                      style: const TextStyle(
                          color: AppColors.electricBlue,
                          fontSize: AppSize.small,
                          fontWeight: FontWeight.w400),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, AppRoutes.signUp);
                        },
                    )
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
