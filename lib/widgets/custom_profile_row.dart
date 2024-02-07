import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/constants/app_colors.dart';
import 'package:ticket_resale/constants/app_textsize.dart';
import 'widgets.dart';

class CustomProfileRow extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color? iconColor;
  final Color? leadingColor;
  final String? title;
  final Color? color;
  final double? size;
  final TextStyle? style;
  final bool arrowBack;
  final String? svgImage;
  final bool isSvg;
  final FontWeight? weight;

  const CustomProfileRow(
      {super.key,
      this.style,
      this.title,
      this.color,
      this.size,
      this.iconColor,
      this.weight,
      this.arrowBack = true,
      this.leadingIcon,
      this.trailingIcon,
      this.svgImage,
      this.isSvg = false,
      this.leadingColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.silver)),
                child: isSvg
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset('$svgImage'),
                      )
                    : Icon(
                        leadingIcon,
                        size: 20,
                        color: leadingColor,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '$title',
                  style: TextStyle(
                    fontSize: AppSize.regular,
                    fontWeight: FontWeight.w400,
                    color: color,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                child: arrowBack
                    ? Icon(
                        trailingIcon,
                        size: 15,
                        color: iconColor,
                      )
                    : const CustomSwitch(),
              ),
            ],
          ),
          const CustomDivider(),
          const SizedBox(
            height: 3,
          ),
        ],
      ),
    );
  }
}
