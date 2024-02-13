import 'package:fluttertoast/fluttertoast.dart';
import 'package:ticket_resale/constants/app_colors.dart';

class ToastMessage {
  static void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM_RIGHT,
        backgroundColor: AppColors.darkpurple,
        textColor: AppColors.white,
        fontSize: 16.0);
  }
}
