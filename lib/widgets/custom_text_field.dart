import 'package:flutter/material.dart';
import 'package:ticket_resale/components/call_back_funs.dart';
import 'package:ticket_resale/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final OnChanged onChanged;
  final ValidatorFormField? validator;
  final TextInputType? keyBoardType;
  final Color borderColor;
  final Color? fillColor;
  final bool isFilled;
  final TextStyle? hintStyle;
  final bool readOnly;
  final TextStyle? suffixStyle;
  final bool isVisibleText;
  final String obscuringCharacter;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.keyBoardType,
    this.suffixIcon,
    this.hintStyle,
    this.suffixStyle,
    this.validator,
    this.isVisibleText = false,
    this.readOnly = false,
    required this.borderColor,
    this.obscuringCharacter = '●',
    this.prefixIcon,
    this.fillColor,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return SizedBox(
      height: height * 0.07,
      width: width * 0.8,
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        obscuringCharacter: obscuringCharacter,
        cursorColor: AppColors.jetBlack.withOpacity(0.3),
        obscureText: isVisibleText,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 10, left: 10),
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          fillColor: fillColor,
          filled: isFilled,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(42),
              borderSide: BorderSide(
                color: borderColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(42),
              borderSide: BorderSide(
                color: borderColor,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(42),
              borderSide: BorderSide(
                color: borderColor,
              )),
          hintStyle: const TextStyle(
            color: AppColors.silver,
            fontSize: AppSize.xmedium,
            fontWeight: FontWeight.w500,
          ),
          suffixStyle: suffixStyle,
        ),
        keyboardType: keyBoardType,
      ),
    );
  }
}
