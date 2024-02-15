import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:ticket_resale/constants/app_colors.dart';
import 'package:ticket_resale/constants/app_textsize.dart';

class AppUtils {
  static Future<String> getImageFromGallery() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      return image.path;
    } else {
      return '';
    }
  }

  static void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        backgroundColor: AppColors.blueViolet,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  static void openDatePicker(
    BuildContext context, {
    TextEditingController? dateController,
  }) {
    BottomPicker.date(
      backgroundColor: AppColors.paleGrey,
      title: 'Select date',
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(1900),
      pickerTextStyle: const TextStyle(
        color: AppColors.purple,
        fontSize: AppSize.medium,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
      ),
      titleStyle: const TextStyle(
        fontSize: AppSize.regular,
        fontWeight: FontWeight.w600,
        color: AppColors.jetBlack,
      ),
      onChange: (index) {
        // print(index);
      },
      onSubmit: (selectedDate) {
        if (dateController != null) {
          dateController.text = selectedDate.toLocal().toString().split(' ')[0];
        }
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }
}
