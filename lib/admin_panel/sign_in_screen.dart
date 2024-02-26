import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/admin_panel/auth_services_admin.dart';
import '../constants/constants.dart';

import '../widgets/widgets.dart';

class SignInAdmin extends StatefulWidget {
  const SignInAdmin({super.key});
  @override
  State<SignInAdmin> createState() => _SignInAdminState();
}

class _SignInAdminState extends State<SignInAdmin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<bool> passwordVisibility = ValueNotifier<bool>(true);
  ValueNotifier<bool> indicator = ValueNotifier<bool>(false);
  @override
  void initState() {
    emailController.text = 'test@gmail.com';
    passwordController.text = '123456';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height * 0.45,
            width: width,
            decoration: BoxDecoration(gradient: customGradientAdmin),
            child: Image.asset(AppImages.admin, fit: BoxFit.contain),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.6,
              width: width,
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Sign in ',
                          style: const TextStyle(
                              color: AppColors.blueViolet,
                              fontSize: AppSize.verylarge,
                              fontWeight: FontWeight.w700),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'as Admin',
                              style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: AppSize.verylarge,
                                  fontWeight: FontWeight.w700),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            )
                          ],
                        ),
                      ),
                      const Gap(30),
                      CustomTextField(
                        controller: emailController,
                        hintStyle:
                            const TextStyle(color: AppColors.electricGrey),
                        hintText: 'Email ID',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter your Email';
                          }

                          if (!EmailValidator.validate(value)) {
                            return 'Please Enter a valid Email';
                          }
                          return null;
                        },
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      const Gap(25),
                      ValueListenableBuilder<bool>(
                        builder: (context, isVisible, child) => CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          hintStyle:
                              const TextStyle(color: AppColors.electricGrey),
                          maxLines: 1,
                          isVisibleText: isVisible,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              passwordVisibility.value =
                                  !passwordVisibility.value;
                            },
                            child: Icon(
                              isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.electricGrey,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
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
                          onTap: () {},
                          child: const CustomText(
                            title: 'Forgot Password?',
                            color: AppColors.electricBlue,
                            weight: FontWeight.w400,
                            size: AppSize.medium,
                          ),
                        ),
                      ),
                      const Gap(30),
                      ValueListenableBuilder<bool>(
                        builder: (context, value, child) => CustomButton(
                          btnText: 'Sign in',
                          loading: indicator.value,
                          weight: FontWeight.w700,
                          textColor: AppColors.white,
                          gradient: customGradient,
                          textSize: AppSize.regular,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              indicator.value = true;
                              await AuthServicesAdmin.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context)
                                  .then((value) {
                                indicator.value = false;
                              });
                            }
                          },
                        ),
                        valueListenable: indicator,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
