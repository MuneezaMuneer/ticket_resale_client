import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

  static String getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 6 && hour < 12) {
      return 'Good Morning,';
    } else if (hour >= 12 && hour < 14) {
      return 'Good Noon,';
    } else if (hour >= 14 && hour < 16) {
      return 'Good Afternoon,';
    } else if (hour >= 16 && hour < 21) {
      return 'Good Evening,';
    } else {
      return 'Good Night,';
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

  static dateFormat(String date) {
    DateTime dateFormat = DateTime.parse(date);
    String formattedDate = DateFormat('d MMM').format(dateFormat);
    return formattedDate;
  }

  static String limitTo42Char(String inputText) {
    if (inputText.length > 43) {
      return '${inputText.substring(0, 43)}...';
    } else {
      return inputText;
    }
  }

  static String limitTo33Char(String inputText) {
    if (inputText.length > 33) {
      return '${inputText.substring(0, 33)}...';
    } else {
      return inputText;
    }
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

  static String textTo32Characters(String inputText) {
    if (inputText.length > 15) {
      return '${inputText.substring(0, 15)}...';
    } else {
      return inputText;
    }
  }
}
