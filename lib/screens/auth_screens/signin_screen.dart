import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';

import '../../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  ValueNotifier<bool> passwordVisibility = ValueNotifier<bool>(true);
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double height = size.height;
    return Scaffold(
      body: AppBackground(
        imagePath: AppImages.authImage,
        isBackButton: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
              key: globalKey,
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'Sign in ',
                        style: const TextStyle(
                          color: AppColors.darkpurple,
                          fontSize: AppFontSize.verylarge,
                          fontWeight: FontWeight.w700,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'to Continue',
                              style: const TextStyle(
                                  color: AppColors.jetBlack,
                                  fontSize: AppFontSize.verylarge,
                                  fontWeight: FontWeight.w700),
                              recognizer: TapGestureRecognizer()..onTap = () {})
                        ]),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField(
                    controller: emailController,
                    hintStyle: const TextStyle(color: AppColors.silver),
                    hintText: 'Email ID',
                    validator: (value) {
                      if (value == null || !EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                    keyBoardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ValueListenableBuilder<bool>(
                    builder: (context, isVisible, child) => CustomTextField(
                      controller: passwordController,
                      hintStyle: const TextStyle(color: AppColors.silver),
                      hintText: 'Password',
                      maxLines: 1,
                      isVisibleText: isVisible,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          passwordVisibility.value = !passwordVisibility.value;
                        },
                        child: Icon(
                          isVisible ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.silver,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Please enter your password';
                        }

                        return null;
                      },
                    ),
                    valueListenable: passwordVisibility,
                  ),
                  const Gap(10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.forgotPasswordScreen,
                        );
                      },
                      child: const CustomText(
                        title: 'Forgot Password?',
                        color: AppColors.electricBlue,
                        weight: FontWeight.w400,
                        size: AppFontSize.medium,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  ValueListenableBuilder(
                    valueListenable: loading,
                    builder: (context, value, child) {
                      return CustomButton(
                        loading: loading.value,
                        btnText: 'Sign in',
                        weight: FontWeight.w700,
                        textColor: AppColors.white,
                        gradient: customGradient,
                        textSize: AppFontSize.regular,
                        onPressed: () async {
                          if (globalKey.currentState!.validate()) {
                            loading.value = true;

                            await Future.delayed(
                                    const Duration(milliseconds: 100))
                                .then((value) => AuthServices.login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context))
                                .then((value) async {});
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              FocusScope.of(context).unfocus();
                            });

                            loading.value = false;
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.signUp);
                    },
                    child: RichText(
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
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
