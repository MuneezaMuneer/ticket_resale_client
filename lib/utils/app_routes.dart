import 'package:flutter/material.dart';
import 'package:ticket_resale/screens/profile_setting.dart';
import 'package:ticket_resale/widgets/custom_navigation.dart';
import '../constants/constants.dart';
import '../screens/screens.dart';
import '../screens/signin_screen.dart';
import '../screens/signup_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  if (settings.name == AppRoutes.logIn) {
    return navigatePage(LoginScreen());
  } else if (settings.name == AppRoutes.signIn) {
    return navigatePage(SignInScreen());
  } else if (settings.name == AppRoutes.signUp) {
    return navigatePage(SignUpScreen());
  } else if (settings.name == AppRoutes.navigationScreen) {
    return navigatePage(const CustomNavigation());
  } else if (settings.name == AppRoutes.homeScreen) {
    return navigatePage(const HomeScreen());
  } else if (settings.name == AppRoutes.commentScreen) {
    return navigatePage(const CommentScreen());
  } else if (settings.name == AppRoutes.feedbackScreen) {
    return navigatePage(const FeedBackScreen());
  } else if (settings.name == AppRoutes.detailScreen) {
    return navigatePage(const HomeDetailScreen());
  } else if (settings.name == AppRoutes.newTicketScreen) {
    return navigatePage(const AddNewTicket());
  } else if (settings.name == AppRoutes.connectScreen) {
    return navigatePage(const PaymentConnectScreen());
  } else if (settings.name == AppRoutes.disconnectScreen) {
    return navigatePage(const PaymentDisconnectScreen());
  } else if (settings.name == AppRoutes.profileScreen) {
    return navigatePage(const ProfileScreen());
  } else if (settings.name == AppRoutes.profileSettings) {
    return navigatePage(const ProfileSettings());
  } else if (settings.name == AppRoutes.notificationScreen) {
    return navigatePage(const NotificationScreen());
  } else if (settings.name == AppRoutes.profileLevelScreen) {
    return navigatePage(const ProfileLevelScreen());
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
