import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

import '../constants/constants.dart';
import 'routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushNamed(context, AppRoutes.logIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              AppColors.white,
              AppColors.purple.withOpacity(0.3),
            ],
            radius: 0.9,
            focalRadius: 0.5,
            stops: const [0.1, 2.0],
          ),
        ),
        child: SizedBox(
          height: 106,
          width: 170,
          child: Center(
            child: SvgPicture.asset(
              AppSvgs.logo,
            ),
          ),
        ),
      ),
    );
  }
}
