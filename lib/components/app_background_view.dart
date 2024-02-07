import 'package:flutter/material.dart';
import 'package:ticket_resale/constants/app_colors.dart';

class AppBackGround extends StatelessWidget {
  final String imagePath;
  final Widget child;
  const AppBackGround(
      {super.key, required this.child, required this.imagePath});

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
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width,
              height: height * 0.6,
              decoration: const BoxDecoration(
                  color: AppColors.paleGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: child,
            )),
      ],
    );
  }
}
