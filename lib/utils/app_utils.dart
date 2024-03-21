import 'dart:io';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  static String dateFormat(String date) {
    DateTime dateFormat = DateTime.parse(date);
    String day = dateFormat.day.toString();

    String suffix = 'th';
    if (day.endsWith('1') && !day.endsWith('11')) {
      suffix = 'st';
    } else if (day.endsWith('2') && !day.endsWith('12')) {
      suffix = 'nd';
    } else if (day.endsWith('3') && !day.endsWith('13')) {
      suffix = 'rd';
    }

    String formattedDate = '${DateFormat('d').format(dateFormat)}$suffix';
    return formattedDate;
  }

  static String convertDateTimeToMMMMDY({DateTime? dateTime}) {
    if (dateTime != null) {
      DateTime time = dateTime;

      DateTime currentDate = DateTime.now();

      DateFormat dateFormat = DateFormat.yMd();

      String formattedServerDate = dateFormat.format(time);

      String formattedCurrentDate = dateFormat.format(currentDate);

      if (formattedServerDate == formattedCurrentDate) {
        return 'Today';
      } else {
        DateFormat dateFormat = DateFormat("MMMM d, y");
        String formattedDate = dateFormat.format(time);
        return formattedDate;
      }
    }
    return '';
  }

  static String convertDateTimeToOnlyTime(timeStamp) {
    DateFormat timeFormat = DateFormat("h:mm a");
    String formattedTime = timeFormat.format(timeStamp);
    return formattedTime;
  }

  static String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  static String formatTimeStamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate(); 
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if ((difference.inDays / 7).floor() < 5) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else {
      int months =
          now.month - dateTime.month + (12 * (now.year - dateTime.year));
      if (months == 1) {
        return '1 month ago';
      } else {
        return '$months months ago';
      }
    }
  }

  static String formatTimeAgo(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if ((difference.inDays / 7).floor() < 5) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else {
      int months =
          now.month - dateTime.month + (12 * (now.year - dateTime.year));
      if (months == 1) {
        return '1 month ago';
      } else {
        return '$months months ago';
      }
    }
  }

  static String formatDatee(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
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
