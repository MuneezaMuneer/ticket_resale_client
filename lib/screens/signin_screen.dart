import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/components/app_background.dart';
import 'package:ticket_resale/constants/constants.dart';
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
      body: AppBackground(
        imagePath: AppImages.authImage,
        isBackButton: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                    text: 'Sign in ',
                    style: const TextStyle(
                        color: AppColors.darkpurple,
                        fontSize: AppSize.verylarge,
                        fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'to Continue',
                          style: const TextStyle(
                              color: AppColors.jetBlack,
                              fontSize: AppSize.verylarge,
                              fontWeight: FontWeight.w700),
                          recognizer: TapGestureRecognizer()..onTap = () {})
                    ]),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const CustomTextField(
                hintText: 'Email ID',
                keyBoardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const CustomTextField(
                hintText: 'Password',
                suffixIcon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: AppColors.silver,
                ),
              ),
              const Gap(10),
              const Align(
                alignment: Alignment.centerRight,
                child: CustomText(
                  title: 'Forgot Password?',
                  color: AppColors.electricBlue,
                  weight: FontWeight.w400,
                  size: AppSize.medium,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomButton(
                backgroundColor: AppColors.white,
                btnText: 'Sign in',
                weight: FontWeight.w700,
                textColor: AppColors.white,
                gradient: customGradient,
                textSize: AppSize.regular,
                onPressed: () {},
              ),
              SizedBox(
                height: height * 0.2,
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
