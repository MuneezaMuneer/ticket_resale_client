import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:svg_flutter/svg.dart';

import '../widgets/custom_navigation_admin.dart';
import '../constants/constants.dart';
import '../widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        if (AppText.preference?.getString(AppText.isAdminPrefKey) == null) {
          Navigator.pushNamed(context, AppRoutes.logIn);
        } else if (AppText.preference!.getString(AppText.isAdminPrefKey) ==
            AppText.client) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomNavigation(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomNavigationAdmin(),
              ));
        }
      } else {
        Navigator.pushNamed(context, AppRoutes.logIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // checkLoginState(context);
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

// //check if user is already login then navigate to home screen
// Future<void> checkLoginState(BuildContext context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//   if (isLoggedIn) {
//     // ignore: use_build_context_synchronously
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => const HomeScreen()),
//     );
//   } else {
//     // ignore: use_build_context_synchronously
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => const SplashScreen()),
//     );
//   }
// }
