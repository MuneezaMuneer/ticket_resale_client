import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_resale/components/components.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/widgets/widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final double? height;
  final OnChanged onChanged;
  final ValidatorFormField? validator;
  final TextInputType? keyBoardType;
  final Color? fillColor;
  final bool isFilled;
  final FontWeight? weight;
  final TextStyle? hintStyle;
  final bool isSuffixIcon;
  final Widget? iconWidget;
  final int? maxLines;
  final bool readOnly;
  final bool isCommentField;
  final TextStyle? suffixStyle;
  final bool isVisibleText;
  final String obscuringCharacter;
  final String? trailingText;
  final bool isTrailingText;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;

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
    this.obscuringCharacter = '●',
    this.prefixIcon,
    this.fillColor,
    this.isFilled = false,
    this.trailingText,
    this.isTrailingText = false,
    this.isCommentField = false,
    this.maxLines,
    this.initialValue,
    this.isSuffixIcon = true,
    this.iconWidget,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      obscuringCharacter: obscuringCharacter,
      cursorColor: AppColors.jetBlack.withOpacity(0.3),
      obscureText: isVisibleText,
      cursorHeight: 23,
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10, left: 17),
        hintText: hintText,
        alignLabelWithHint: true,
        suffixIcon: isTrailingText
            ? Padding(
                padding: const EdgeInsets.only(top: 15, right: 20),
                child: CustomText(
                  title: '$trailingText',
                  color: AppColors.springGreen,
                  weight: FontWeight.w600,
                  size: AppFontSize.medium,
                ),
              )
            : isSuffixIcon
                ? suffixIcon
                : iconWidget,
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: isFilled,
        enabledBorder: OutlineInputBorder(
            borderRadius: isCommentField
                ? BorderRadius.circular(12)
                : BorderRadius.circular(42),
            borderSide: const BorderSide(
              color: AppColors.pastelBlue,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: isCommentField
                ? BorderRadius.circular(12)
                : BorderRadius.circular(42),
            borderSide: const BorderSide(
              color: AppColors.pastelBlue,
            )),
        border: OutlineInputBorder(
            borderRadius: isCommentField
                ? BorderRadius.circular(12)
                : BorderRadius.circular(42),
            borderSide: const BorderSide(
              color: AppColors.pastelBlue,
            )),
        hintStyle: hintStyle,
        suffixStyle: suffixStyle,
      ),
      keyboardType: keyBoardType,
    );
  }
}
