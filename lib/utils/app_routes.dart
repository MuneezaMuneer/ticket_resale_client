import 'package:flutter/material.dart';
import 'package:ticket_resale/screens/signin_screen.dart';
import 'package:ticket_resale/screens/signup_screen.dart';

import '../screens/routes.dart';
import '../screens/screens.dart';

Route onGenerateRoute(RouteSettings settings) {
  if (settings.name == AppRoutes.logIn) {
    return navigatePage(const LoginScreen());
  } else if (settings.name == AppRoutes.signIn) {
    return navigatePage(const SignInScreen());
  } else if (settings.name == AppRoutes.signUp) {
    return navigatePage(const SignUpScreen());
  } else if (settings.name == AppRoutes.homeScreen) {
    return navigatePage(const HomeScreen());
  } else {
    return navigatePage(const SplashScreen());
  }
}

MaterialPageRoute navigatePage(Widget widget) {
  return MaterialPageRoute(
    builder: (context) {
      return widget;
    },
  );
}
