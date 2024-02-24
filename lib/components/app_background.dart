import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_resale/constants/app_colors.dart';
import 'package:ticket_resale/constants/app_images.dart';

class AppBackground extends StatelessWidget {
  final String? imagePath;
  final bool isAssetImage;
  final String? networkImage;
  final Widget child;
  final bool isBackButton;
  const AppBackground(
      {super.key,
      required this.child,
      this.imagePath,
      required this.isBackButton,
      this.networkImage,
      this.isAssetImage = true});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double width = size.width;
    double height = size.height;
    return Stack(
      children: [
        SizedBox(
            height: height * 0.5,
            width: width,
            child: isAssetImage
                ? Image.asset(
                    '$imagePath',
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    '$networkImage',
                    fit: BoxFit.cover,
                  )),
        Positioned(
            top: 35,
            left: 20,
            child: isBackButton
                ? GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(AppSvgs.back))
                : const SizedBox.shrink()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: width,
            height: height * 0.6,
            decoration: const BoxDecoration(
              color: AppColors.paleGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
