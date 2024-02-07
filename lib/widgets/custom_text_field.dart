import 'package:flutter/material.dart';
import 'package:ticket_resale/components/call_back_funs.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/custom_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final double? height;
  final OnChanged onChanged;
  final ValidatorFormField? validator;
  final TextInputType? keyBoardType;
  final Color borderColor;
  final Color? fillColor;
  final bool isFilled;
  final FontWeight? weight;
  final TextStyle? hintStyle;
  final bool readOnly;
  final TextStyle? suffixStyle;
  final bool isVisibleText;
  final String obscuringCharacter;
  final String? trailingText;
  final bool isTrailingText;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.keyBoardType,
    this.suffixIcon,
    this.weight,
    this.hintStyle,
    this.suffixStyle,
    this.validator,
    this.height = 56,
    this.isVisibleText = false,
    this.readOnly = false,
    required this.borderColor,
    this.obscuringCharacter = '●',
    this.prefixIcon,
    this.fillColor,
    this.isFilled = false,
    this.trailingText,
    this.isTrailingText = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return SizedBox(
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
          suffixIcon: isTrailingText
              ? Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20),
                  child: CustomText(
                    title: '$trailingText',
                    color: AppColors.springGreen,
                    weight: FontWeight.w600,
                    size: AppSize.medium,
                  ),
                )
              : suffixIcon,
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
            fontSize: AppSize.medium,
            fontWeight: FontWeight.w400,
          ),
          suffixStyle: suffixStyle,
        ),
        keyboardType: keyBoardType,
      ),
    );
  }
}
