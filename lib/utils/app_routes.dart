import 'package:flutter/material.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/screens/chat_detail_screen.dart';
import 'package:ticket_resale/screens/chat_screen.dart';
import 'package:ticket_resale/widgets/widgets.dart';
import '../constants/constants.dart';
import '../screens/auth_screens/signin_screen.dart';
import '../screens/auth_screens/signup_screen.dart';
import '../screens/screens.dart';

Route onGenerateRoute(RouteSettings settings) {
  if (settings.name == AppRoutes.logIn) {
    return animatePage(const LoginScreen());
  } else if (settings.name == AppRoutes.signIn) {
    return animatePage(const SignInScreen());
  } else if (settings.name == AppRoutes.payPalAuthorization) {
    return animatePage(
        const PaypalAuthorization(title: 'PayPal Authorization'));
  } else if (settings.name == AppRoutes.signUp) {
    return animatePage(const SignUpScreen());
  } else if (settings.name == AppRoutes.navigationScreen) {
    return animatePage(const CustomNavigation());
  } else if (settings.name == AppRoutes.passwordScreen) {
    return animatePage(const PasswordScreen());
  } else if (settings.name == AppRoutes.homeScreen) {
    return animatePage(const HomeScreen());
  } else if (settings.name == AppRoutes.commentScreen) {
    final Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
    final EventModal eventModal = arguments['eventModal'] as EventModal;
    final TicketModel ticketModal = arguments['ticketModal'] as TicketModel;
    final String price = arguments['price'] as String;
    return animatePage(CommentScreen(
      eventModal: eventModal,
      ticketModal: ticketModal,
      price: price,
    ));
  } else if (settings.name == AppRoutes.feedbackScreen) {
    return animatePage(const FeedBackScreen());
  } else if (settings.name == AppRoutes.privacyScreen) {
    return animatePage(const PrivacyPolicy());
  } else if (settings.name == AppRoutes.detailFirstScreen) {
    final eventModal = settings.arguments as EventModal;
    return animatePage(HomeDetailFirstScreen(eventModal: eventModal));
  } else if (settings.name == AppRoutes.detailSecondScreen) {
    final Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
    final EventModal eventModal = arguments['eventModal'] as EventModal;
    final TicketModel ticketModal = arguments['ticketModel'] as TicketModel;
    return animatePage(HomeDetailSecondScreen(
      eventModal: eventModal,
      ticketModel: ticketModal,
    ));
  } else if (settings.name == AppRoutes.ticketScreen) {
    return animatePage(const TicketScreen());
  } else if (settings.name == AppRoutes.chatScreen) {
    return animatePage(const ChatScreen());
  } else if (settings.name == AppRoutes.chatDetailScreen) {
    final Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
    final UserModel userModal = arguments['userModel'] as UserModel;
    final String receiverId = arguments['receiverId'] as String;
    final String hashKey = arguments['hashKey'] as String;
    return animatePage(ChatDetailScreen(
      receiverId: receiverId,
      hashKey: hashKey,
      userModel: userModal,
    ));
  } else if (settings.name == AppRoutes.eventScreen) {
    final isBackButton = settings.arguments as bool;
    return animatePage(EventScreen(isBackButton: isBackButton));
  } else if (settings.name == AppRoutes.connectScreen) {
    return animatePage(const PaymentConnectScreen());
  } else if (settings.name == AppRoutes.disconnectScreen) {
    return animatePage(const PaymentDisconnectScreen());
  } else if (settings.name == AppRoutes.profileScreen) {
    return animatePage(const ProfileScreen());
  } else if (settings.name == AppRoutes.termOfUseScreen) {
    return animatePage(const TermsOfUseScreen());
  } else if (settings.name == AppRoutes.profileSettings) {
    return animatePage(const ProfileSettings());
  } else if (settings.name == AppRoutes.notificationScreen) {
    return animatePage(NotificationScreen());
  } else if (settings.name == AppRoutes.profileLevelScreen) {
    final isBackButton = settings.arguments as bool;
    return animatePage(ProfileLevelScreen(isBackButton: isBackButton));
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
