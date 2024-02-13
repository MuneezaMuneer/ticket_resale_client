import 'package:flutter/material.dart';
import 'package:ticket_resale/screens/profile_setting.dart';
import 'package:ticket_resale/widgets/custom_navigation.dart';
import '../constants/constants.dart';
import '../screens/profile_screen.dart';
import '../screens/screens.dart';
import '../screens/signin_screen.dart';
import '../screens/signup_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  if (settings.name == AppRoutes.logIn) {
    return animatePage(const LoginScreen());
  } else if (settings.name == AppRoutes.signIn) {
    return animatePage(const SignInScreen());
  } else if (settings.name == AppRoutes.signUp) {
    return animatePage(const SignUpScreen());
  } else if (settings.name == AppRoutes.navigationScreen) {
    return animatePage(const CustomNavigation());
  } else if (settings.name == AppRoutes.homeScreen) {
    return animatePage(const HomeScreen());
  } else if (settings.name == AppRoutes.commentScreen) {
    return animatePage(const CommentScreen());
  } else if (settings.name == AppRoutes.feedbackScreen) {
    return animatePage(const FeedBackScreen());
  } else if (settings.name == AppRoutes.detailFirstScreen) {
    return animatePage(const HomeDetailFirstScreen());
  } else if (settings.name == AppRoutes.detailThirdScreen) {
    return animatePage(const HomeDetailThirdScreen());
  } else if (settings.name == AppRoutes.newTicketScreen) {
    return animatePage(const AddNewTicket());
  } else if (settings.name == AppRoutes.connectScreen) {
    return animatePage(const PaymentConnectScreen());
  } else if (settings.name == AppRoutes.disconnectScreen) {
    return animatePage(const PaymentDisconnectScreen());
  } else if (settings.name == AppRoutes.profileScreen) {
    return animatePage(const ProfileScreen());
  } else if (settings.name == AppRoutes.profileSettings) {
    return animatePage(const ProfileSettings());
  } else if (settings.name == AppRoutes.notificationScreen) {
    return animatePage(const NotificationScreen());
  } else if (settings.name == AppRoutes.profileLevelScreen) {
    return animatePage(const ProfileLevelScreen());
  } else {
    return animatePage(const SplashScreen());
  }
}

PageRouteBuilder animatePage(Widget widget) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (_, __, ___) => widget,
    transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return customLeftSlideTransition(animation, child);
    },
  );
}

Widget customLeftSlideTransition(Animation<double> animation, Widget child) {
  Tween<Offset> tween =
      Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
  return SlideTransition(
    position: tween.animate(animation),
    child: child,
  );
}
