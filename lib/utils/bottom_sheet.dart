import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/providers/bottom_sheet_provider.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CustomBottomSheet {
  static void showOTPBottomSheet(
      {required BuildContext context,
      required OnChanged onChanged,
      required String email,
      bool isLoading = false,
      required OnTape onTape}) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
                color: AppColors.paleGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Verification Code",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                const Gap(10),
                Text(
                  "Verification code has been sent on\n $email. ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 15),
                ),
                const SizedBox(
                  height: 20,
                ),
                OtpTextField(
                  numberOfFields: 4,
                  borderColor: AppColors.jetBlack,
                  focusedBorderColor: AppColors.jetBlack,
                  showFieldAsBox: true,
                  borderWidth: 4.0,
                  onSubmit: onChanged,
                ),
                const Gap(50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Consumer<BottomSheetProvider>(
                    builder: (context, loadingProvider, child) => SizedBox(
                      height: 60,
                      child: CustomButton(
                        loading: loadingProvider.getLoadingProgress,
                        gradient: customGradient,
                        btnText: 'Verify Email',
                        onPressed: onTape,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      backgroundColor: Colors.transparent,
      context: context,
    );
  }
}
