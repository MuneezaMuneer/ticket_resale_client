import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:svg_flutter/svg_flutter.dart';
import '../constants/constants.dart';
import '../widgets/widgets.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

TextEditingController fullNameController = TextEditingController();
TextEditingController instagramUserNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneNoController = TextEditingController();
TextEditingController dOBController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController zipCodeController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 234, 248),
      appBar: const CustomAppBar(
        title: 'Profile Settings',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                const SizedBox(
                  height: 140,
                  width: 140,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(AppImages.profileImage),
                  ),
                ),
                Positioned(
                    left: 60, top: 55, child: SvgPicture.asset(AppSvgs.camera))
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            CustomText(
              title: FirebaseAuth.instance.currentUser!.displayName,
              weight: FontWeight.w600,
              size: AppSize.large,
              color: AppColors.jetBlack,
            ),
            const SizedBox(
              height: 5,
            ),
            const CustomRow(),
            const SizedBox(height: 30),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
                        style: _buildstyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText:
                            FirebaseAuth.instance.currentUser!.displayName,
                        hintStyle: _buildTextFieldstyle(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Instagram Username',
                        style: _buildstyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: '@SamanthaPate',
                        hintStyle: const TextStyle(
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: AppSize.small),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter instagram username';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Email ID',
                        style: _buildstyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: FirebaseAuth.instance.currentUser!.email,
                        trailingText: 'Verify',
                        isTrailingText: true,
                        hintStyle: _buildTextFieldstyle(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Phone No.',
                        style: _buildstyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
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
                                hintText: 'eg.3092829992',
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
                          const Positioned(
                            right: 20,
                            top: 15,
                            child: CustomText(
                              title: 'Verify',
                              color: AppColors.springGreen,
                              weight: FontWeight.w600,
                              size: AppSize.medium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'DOB',
                        style: _buildstyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: 'Date of birth',
                        hintStyle: _buildTextFieldstyle(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter date';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      CustomButton(
                        fixedHeight: height * 0.07,
                        fixedWidth: width,
                        btnText: 'Save',
                        weight: FontWeight.w700,
                        textColor: AppColors.white,
                        gradient: customGradient,
                        textSize: AppSize.regular,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  TextStyle _buildstyle() {
    return const TextStyle(
      color: AppColors.lightBlack,
      fontWeight: FontWeight.w600,
      fontSize: AppSize.medium,
    );
  }

  TextStyle _buildTextFieldstyle() {
    return TextStyle(
        color: AppColors.lightBlack.withOpacity(0.8),
        fontWeight: FontWeight.w400,
        fontSize: AppSize.medium);
  }
}
