import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:ticket_resale/admin_panel/sign_in_screen.dart';
import '../constants/constants.dart';

class SplashScreenAdmin extends StatefulWidget {
  const SplashScreenAdmin({super.key});
  @override
  State<SplashScreenAdmin> createState() => _SplashScreenAdminState();
}

class _SplashScreenAdminState extends State<SplashScreenAdmin> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInAdmin(),
          ));
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
