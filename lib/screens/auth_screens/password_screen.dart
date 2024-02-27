import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('$key');
    Size size = MediaQuery.of(context).size;

    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: AppBackground(
        imagePath: AppImages.authImage,
        isBackButton: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: AppColors.jetBlack,
                            fontSize: AppSize.verylarge,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const CustomText(
                      title: 'Please add your registered email.',
                      color: AppColors.jetBlack,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      size: AppSize.medium,
                      weight: FontWeight.w500,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: height * 0.13,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.pastelBlue),
                          borderRadius: BorderRadius.circular(17)),
                      child: Row(
                        children: [
                          const Gap(15),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.pastelBlue.withOpacity(0.2)),
                            child: const Icon(
                              Icons.email,
                              color: AppColors.blueViolet,
                              size: 30,
                            ),
                          ),
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: 'Registered Email',
                                  size: AppSize.xsmall,
                                  color: AppColors.lightBlack.withOpacity(0.4),
                                ),
                                const CustomText(
                                  title: 'xyz@gmail.com',
                                  size: AppSize.xsmall,
                                  weight: FontWeight.w600,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: emailController,
                      hintText: 'Enter Email',
                      hintStyle: const TextStyle(color: AppColors.silver),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    SizedBox(height: height * 0.08),
                    ValueListenableBuilder(
                      valueListenable: loadingNotifier,
                      builder: (context, isLoading, child) => CustomButton(
                        fixedHeight: height * 0.07,
                        fixedWidth: width,
                        btnText: 'Continue',
                        loading: loadingNotifier.value,
                        weight: FontWeight.w700,
                        textColor: AppColors.white,
                        gradient: customGradient,
                        textSize: AppSize.regular,
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            loadingNotifier.value = true;
                            String result = await AuthServices.forgotPassword(
                                email: emailController.text, context: context);

                            if (result == 'success') {
                              AppUtils.toastMessage(
                                'Password reset email sent successfully!',
                              );
                            } else {
                              AppUtils.toastMessage(
                                result,
                              );
                              loadingNotifier.value = false;
                            }
                            loadingNotifier.value = false;
                          }
                        },
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
