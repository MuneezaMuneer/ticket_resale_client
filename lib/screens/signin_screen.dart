import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/components/app_background.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/auth_services.dart';
import 'package:ticket_resale/utils/toastmessage.dart';
import '../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
ValueNotifier<bool> passwordVisibility = ValueNotifier<bool>(true);

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    emailController.clear();
    passwordController.clear();

    super.initState();
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
              key: formKey,
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
                  CustomTextField(
                    controller: emailController,
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
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ValueListenableBuilder<bool>(
                    builder: (context, isVisible, child) => CustomTextField(
                      controller: passwordController,
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
                    btnText: 'Sign in',
                    weight: FontWeight.w700,
                    textColor: AppColors.white,
                    gradient: customGradient,
                    textSize: AppSize.regular,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        AuthServices.login(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context)
                            .then((value) => ToastMessage.toastMessage(
                                'SignIn SuccessFully'));
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.2,
                  ),
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
                        )
                      ],
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
