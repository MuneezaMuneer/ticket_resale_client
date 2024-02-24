import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ticket_resale/db_services/auth_services.dart';
import 'package:ticket_resale/models/user_model.dart';
import 'package:ticket_resale/utils/app_utils.dart';
import '../../components/components.dart';
import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController gmailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
TextEditingController instaController = TextEditingController();
TextEditingController phoneController = TextEditingController();
ValueNotifier<bool> passwordVisibility = ValueNotifier<bool>(true);
ValueNotifier<bool> confirmpasswordVisibility = ValueNotifier<bool>(true);
GlobalKey<FormState> formKey = GlobalKey<FormState>();
ValueNotifier<bool> loading = ValueNotifier<bool>(false);

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    firstNameController.clear();
    lastNameController.clear();
    gmailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneController.clear();
    instaController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
   // double width = size.width;
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
                          controller: firstNameController,
                          hintStyle: const TextStyle(color: AppColors.silver),
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
                          controller: lastNameController,
                          hintText: 'Last Name',
                          hintStyle: const TextStyle(color: AppColors.silver),
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
                    controller: gmailController,
                    hintStyle: const TextStyle(color: AppColors.silver),
                    hintText: 'Email',
                    keyBoardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email == null || !EmailValidator.validate(email)) {
                        return 'Please enter a valid email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ValueListenableBuilder<bool>(
                    builder: (context, isVisible, child) => CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: AppColors.silver),
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Please enter valid password';
                        } else {
                          return null;
                        }
                      },
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
                    ),
                    valueListenable: passwordVisibility,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ValueListenableBuilder<bool>(
                    builder: (context, isVisiblePassword, child) =>
                        CustomTextField(
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                      hintStyle: const TextStyle(color: AppColors.silver),
                      isVisibleText: isVisiblePassword,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Please enter your password again';
                        } else {
                          return null;
                        }
                      },
                      suffixIcon: GestureDetector(
                        onTap: () {
                          confirmpasswordVisibility.value =
                              !confirmpasswordVisibility.value;
                        },
                        child: Icon(
                          isVisiblePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.silver,
                        ),
                      ),
                    ),
                    valueListenable: confirmpasswordVisibility,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    controller: instaController,
                    hintStyle: const TextStyle(color: AppColors.silver),
                    hintText: 'Instagram @',
                    keyBoardType: TextInputType.emailAddress,
                    validator: (url) {
                      if (url!.isEmpty) {
                        return 'Please enter valid instagram';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 70,
                    child: IntlPhoneField(
                      controller: phoneController,
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
                    child: ValueListenableBuilder(
                      valueListenable: loading,
                      builder: (context, value, child) {
                        return CustomButton(
                          backgroundColor: AppColors.white,
                          btnText: 'Sign up',
                          weight: FontWeight.w700,
                          textColor: AppColors.white,
                          gradient: customGradient,
                          loading: loading.value,
                          textSize: AppSize.regular,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                loading.value = true;

                                UserModel userModel = UserModel(
                                  displayName:
                                      '${firstNameController.text} ${lastNameController.text}',
                                  email: gmailController.text,
                                  instaUsername: instaController.text,
                                  phoneNo: phoneController.text,
                                );

                                await AuthServices.signUp(
                                  email: gmailController.text,
                                  password: passwordController.text,
                                  context: context,
                                ).then((userCredentials) {
                                  if (userCredentials != null) {
                                    AuthServices.storeUserData(
                                            userModel: userModel)
                                        .then((value) {
                                      Navigator.pushNamed(
                                          context, AppRoutes.navigationScreen);
                                    });
                                  }

                                  loading.value = false;
                                });
                              } else {
                                AppUtils.toastMessage(
                                    'Password does not match');
                              }
                            }
                          },
                        );
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
