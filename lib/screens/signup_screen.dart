import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ticket_resale/db_services/auth_services.dart';
import '../components/components.dart';
import '../constants/constants.dart';
import '../widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _SignUpScreenState extends State<SignUpScreen> {
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
                        text: 'Register to ',
                        style: const TextStyle(
                            color: AppColors.jetBlack,
                            fontSize: AppSize.verylarge,
                            fontWeight: FontWeight.w700),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Rave Trade',
                              style: const TextStyle(
                                  color: AppColors.darkpurple,
                                  fontSize: AppSize.verylarge,
                                  fontWeight: FontWeight.w700),
                              recognizer: TapGestureRecognizer()..onTap = () {})
                        ]),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: 'First Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ' Enter your first name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Last Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your last name';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    keyBoardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email == null || !EmailValidator.validate(email)) {
                        return 'Please Enter a valid email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    suffixIcon: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: AppColors.silver,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    hintText: 'Confirm Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your password again';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    suffixIcon: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: AppColors.silver,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 70,
                    child: IntlPhoneField(
                      flagsButtonPadding: const EdgeInsets.all(8),
                      dropdownIcon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Color(0xFF9E9E9E),
                      ),
                      dropdownIconPosition: IconPosition.trailing,
                      cursorColor: AppColors.silver,
                      decoration: InputDecoration(
                        hintText: 'eg. 2324 1231 4230',
                        hintStyle: const TextStyle(
                            color: Color(0xFF9E9E9E),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        contentPadding: const EdgeInsets.only(
                            left: 10, top: 15, bottom: 15),
                        enabled: true,
                        fillColor: AppColors.silver,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: AppColors.pastelBlue,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: AppColors.pastelBlue,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (phone) {
                        if (phone == null || phone.number.isEmpty) {
                          return 'Please enter a phone number';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (phone) {},
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: CustomButton(
                      backgroundColor: AppColors.white,
                      btnText: 'Sign up',
                      weight: FontWeight.w700,
                      textColor: AppColors.white,
                      gradient: customGradient,
                      textSize: AppSize.regular,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthServices.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account?  ',
                      style: const TextStyle(
                          color: AppColors.lightBlack,
                          fontSize: AppSize.medium,
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign in ',
                          style: const TextStyle(
                              color: AppColors.electricBlue,
                              fontSize: AppSize.medium,
                              fontWeight: FontWeight.w400),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, AppRoutes.signIn);
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
