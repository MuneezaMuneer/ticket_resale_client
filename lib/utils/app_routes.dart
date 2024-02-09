import 'package:flutter/material.dart';
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
  } else if (settings.name == AppRoutes.ticketScreen) {
    return navigatePage(const TicketsScreen());
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
