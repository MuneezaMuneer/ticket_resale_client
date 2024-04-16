// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'dart:io';
import 'dart:math' hide log;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/db_services/db_services.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/utils/utils.dart';
import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});
  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

late ImagePickerProvider imagePickerProvider;
String? photoUrl;
String countryCode = '';

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController nameController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    photoUrl = '${AuthServices.getCurrentUser.photoURL}';
    AuthServices.fetchUserDetails().then((userModel) {
      if (userModel != null) {
        instaController.text = '${userModel.instaUsername}';
        phoneNoController.text = userModel.phoneNo ?? '';
        birthController.text = userModel.birthDate ?? '';
      } else {
        instaController.text = '';
        phoneNoController.text = '';
        birthController.text = '';
      }
      return userModel;
    });
    nameController.text = '${AuthServices.getCurrentUser.displayName}';
    emailController.text = '${AuthServices.getCurrentUser.email}';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    otpController.dispose();
    birthController.dispose();
    loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 234, 248),
      appBar: const CustomAppBarClient(
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
                SizedBox(
                  height: 140,
                  width: 140,
                  child: Consumer<ImagePickerProvider>(
                    builder: (BuildContext context, imageProvider, child) {
                      return SizedBox(
                        child: (imageProvider.getImageBytes.isNotEmpty)
                            ? CircleAvatar(
                                backgroundImage: FileImage(
                                    File(imageProvider.getImageBytes)),
                              )
                            : (photoUrl != null && photoUrl != 'null')
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl: "$photoUrl",
                                      placeholder: (context, url) =>
                                          const CupertinoActivityIndicator(
                                        color: AppColors.blueViolet,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const CircleAvatar(
                                    backgroundImage:
                                        AssetImage(AppImages.profileImage),
                                  ),
                      );
                    },
                  ),
                ),
                Positioned(
                    left: 60,
                    top: 55,
                    child: InkWell(
                        onTap: () async {
                          String image = await AppUtils.getImageFromGallery();
                          imagePickerProvider.setImageBytes = image;
                        },
                        child: SvgPicture.asset(AppSvgs.camera)))
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            CustomText(
              title: '${FirebaseAuth.instance.currentUser!.displayName}',
              weight: FontWeight.w600,
              size: AppFontSize.large,
              color: AppColors.jetBlack,
            ),
            const SizedBox(
              height: 5,
            ),
            CustomRow(
              userId: AuthServices.getCurrentUser.uid,
            ),
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
                        controller: nameController,
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
                          controller: instaController,
                          hintText: '@username',
                          hintStyle: const TextStyle(
                              color: AppColors.lightBlack,
                              fontWeight: FontWeight.w400,
                              fontSize: AppFontSize.small),
                          validator: InstagramValidator.validator()),
                      const SizedBox(height: 15),
                      Text(
                        'Email ID',
                        style: _buildstyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        controller: emailController,
                        readOnly: true,
                        trailingText: 'Verified',
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
                              controller: phoneNoController,
                              flagsButtonPadding: const EdgeInsets.all(8),
                              dropdownIcon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Color(0xFF9E9E9E),
                              ),
                              dropdownIconPosition: IconPosition.trailing,
                              cursorColor: AppColors.silver,
                              decoration: InputDecoration(
                                hintText: 'Enter phone number',
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
                              onChanged: (phone) {
                                countryCode = phone.countryCode;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 20,
                            top: 15,
                            child: GestureDetector(
                              onTap: () {
                                _triggerOTP(context);
                              },
                              child: const CustomText(
                                title: 'Verify',
                                color: AppColors.springGreen,
                                weight: FontWeight.w600,
                                size: AppFontSize.medium,
                              ),
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
                        controller: birthController,
                        hintText: 'Date of birth',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              AppUtils.openDatePicker(context,
                                  dateController: birthController);
                            },
                            child: SvgPicture.asset(
                              AppSvgs.date,
                            ),
                          ),
                        ),
                        hintStyle: _buildTextFieldstyle(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter date of birth';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      ValueListenableBuilder(
                        valueListenable: loading,
                        builder: (context, value, child) {
                          return CustomButton(
                              fixedHeight: height * 0.07,
                              fixedWidth: width,
                              btnText: 'Save',
                              loading: loading.value,
                              weight: FontWeight.w700,
                              textColor: AppColors.white,
                              gradient: customGradient,
                              textSize: AppFontSize.regular,
                              onPressed: () {
                                _updateUserInfo();
                              });
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

  Future<void> _updateUserInfo() async {
    if (formKey.currentState!.validate()) {
      loading.value = true;

      try {
        String? imageUrl;
        if (imagePickerProvider.getImageBytes.isNotEmpty) {
          imageUrl = await AuthServices.uploadOrUpdateImage(
            imagePath: imagePickerProvider.getImageBytes,
          );
        }

        UserModelClient userModel = UserModelClient(
            displayName: nameController.text,
            instaUsername: instaController.text,
            phoneNo: phoneNoController.text,
            birthDate: birthController.text,
            email: AuthServices.getCurrentUser.email,
            photoUrl: imagePickerProvider.getImageBytes.isNotEmpty
                ? imageUrl
                : AuthServices.getCurrentUser.photoURL,
            status: 'Active');

        await AuthServices.storeUserImage(userModel: userModel);
      } catch (e) {
        log('Error storing user data: ${e.toString()}');
      } finally {
        loading.value = false;
      }
    }
  }

  TextStyle _buildstyle() {
    return const TextStyle(
      color: AppColors.lightBlack,
      fontWeight: FontWeight.w600,
      fontSize: AppFontSize.medium,
    );
  }

  TextStyle _buildTextFieldstyle() {
    return TextStyle(
        color: AppColors.lightBlack.withOpacity(0.8),
        fontWeight: FontWeight.w400,
        fontSize: AppFontSize.medium);
  }

  _triggerOTP(BuildContext context) async {
    log('message:$countryCode${phoneNoController.text}');
    FocusManager.instance.primaryFocus?.unfocus();
    if (phoneNoController.text.isNotEmpty &&
        phoneNoController.text.length > 6) {
      ///otp generation
      var rnd = new Random();
      var digits = rnd.nextInt(9000) + 1000;
      var sentOTP = digits;
      log('message: $sentOTP');
      AuthServices.sendSmsOTP(
        context: context,
        toNumber: '$countryCode${phoneNoController.text.trim()}',
        sentOTP: sentOTP.toString(),
      );
      CustomBottomSheet.showOTPBottomSheet(
        context: context,
        btnText: 'Verify Number',
        onSubmit: (number) {
          otpController.text = number;
        },
        email: '$countryCode${phoneNoController.text.trim()}',
        onTape: () async {
          Navigator.of(context).pop();
          if (sentOTP.toString() == otpController.text.trim()) {
            SnackBarHelper.showSnackBar(context, 'Otp verfied successfully');
          } else {
            SnackBarHelper.showSnackBar(context, 'Entered OTP is not correct');
          }
        },
      );
    } else {
      SnackBarHelper.showSnackBar(context, 'Plase add valid phone number');
    }
  }
}
