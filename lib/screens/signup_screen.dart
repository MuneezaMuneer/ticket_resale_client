import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ticket_resale/screens/routes.dart';
import '../components/components.dart';
import '../constants/constants.dart';
import '../widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
          child: SingleChildScrollView(
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
                const Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        borderColor: AppColors.silver,
                        hintText: 'First Name',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                          borderColor: AppColors.silver, hintText: 'Last Name'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const CustomTextField(
                  borderColor: AppColors.silver,
                  hintText: 'Email',
                  keyBoardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 12,
                ),
                const CustomTextField(
                  borderColor: AppColors.silver,
                  hintText: 'Password',
                  suffixIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.silver,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const CustomTextField(
                  borderColor: AppColors.silver,
                  hintText: 'Confirm Password',
                  suffixIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.silver,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: height * 0.08,
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
                      contentPadding:
                          const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                      enabled: true,
                      fillColor: AppColors.silver,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: AppColors.silver,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: AppColors.silver,
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
                      Navigator.pushNamed(context, AppRoutes.homeScreen);
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
                        color: AppColors.blueGrey,
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
    );
  }
}
