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
  final bool isCommentField;
  final bool commentFieldPadding;

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
    this.isCommentField = false,
    this.commentFieldPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscuringCharacter: obscuringCharacter,
      cursorColor: AppColors.jetBlack.withOpacity(0.3),
      obscureText: isVisibleText,
      onChanged: onChanged,
      validator: validator,
      maxLines: 5,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: commentFieldPadding
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
            : const EdgeInsets.only(top: 10, left: 10),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: isFilled,
        enabledBorder: OutlineInputBorder(
          borderRadius: isCommentField
              ? BorderRadius.circular(20)
              : BorderRadius.circular(42),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
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
    );
  }
}
