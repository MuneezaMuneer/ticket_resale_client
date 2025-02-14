import 'package:flutter/material.dart';
import 'package:ticket_resale/screens/tickets_history_screen.dart';
import 'package:ticket_resale/widgets/widgets.dart';
import '../constants/constants.dart';
import '../screens/screens.dart';

Route onGenerateRoute(RouteSettings settings) {
  if (settings.name == AppRoutes.logIn) {
    return animatePage(const LoginScreen());
  } else if (settings.name == AppRoutes.signIn) {
    return animatePage(const SignInScreen());
  } else if (settings.name == AppRoutes.createEvent) {
    return animatePage(const CreateEvent());
  } else if (settings.name == AppRoutes.payPalAuthorization) {
    return animatePage(const PaypalAuthorization());
  } else if (settings.name == AppRoutes.signUp) {
    return animatePage(const SignUpScreen());
  } else if (settings.name == AppRoutes.navigationScreen) {
    return animatePage(const CustomNavigationClient());
  } else if (settings.name == AppRoutes.forgotPasswordScreen) {
    return animatePage(const ForgotPasswordScreen());
  } else if (settings.name == AppRoutes.homeScreen) {
    return animatePage(const HomeScreen());
  } else if (settings.name == AppRoutes.commentScreen) {
    final Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
    final String eventId = arguments['eventId'] as String;
    final String ticketId = arguments['ticketId'] as String;
    final String ticketUserId = arguments['ticketUserId'] as String;

    final String price = arguments['price'] as String;

    return animatePage(CommentScreen(
      eventId: eventId,
      price: price,
      ticketId: ticketId,
      ticketUserId: ticketUserId,
    ));
  } else if (settings.name == AppRoutes.feedbackScreen) {
    final Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
    final String sellerImageUrl = arguments['sellerImageUrl'] as String;
    final String sellerName = arguments['sellerName'] as String;
    final String sellerId = arguments['sellerId'] as String;
    return animatePage(FeedBackScreen(
        sellerImageUrl: sellerImageUrl,
        sellerName: sellerName,
        sellerId: sellerId));
  } else if (settings.name == AppRoutes.privacyScreen) {
    return animatePage(const PrivacyPolicy());
  } else if (settings.name == AppRoutes.detailFirstScreen) {
    final eventId = settings.arguments as String;
    return animatePage(HomeDetailFirstScreen(
      eventId: eventId,
    ));
  } else if (settings.name == AppRoutes.detailSecondScreen) {
    final Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
    final String eventId = arguments['eventId'] as String;
    final String ticketId = arguments['ticketId'] as String;
    final String ticketUserId = arguments['ticketUserId'] as String;
    return animatePage(HomeDetailSecondScreen(
      eventId: eventId,
      ticketId: ticketId,
      ticketUserId: ticketUserId,
    ));
  } else if (settings.name == AppRoutes.ticketScreen) {
    return animatePage(const TicketScreen());
  } else if (settings.name == AppRoutes.logoutAdmin) {
    return animatePage(const SignInScreen());
  } else if (settings.name == AppRoutes.ticketScreen) {
    return animatePage(const TicketScreen());
  } else if (settings.name == AppRoutes.chatScreen) {
    return animatePage(const ChatScreen());
  } else if (settings.name == AppRoutes.chatDetailScreen) {
    final Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;

    final String receiverId = arguments['receiverId'] as String;
    final String hashKey = arguments['hashKey'] as String;

    final bool isOpened = arguments['isOpened'] as bool;
    return animatePage(ChatDetailScreen(
      receiverId: receiverId,
      hashKey: hashKey,
      isOpened: isOpened,
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
  } else if (settings.name == AppRoutes.ticketsHistoryScreen) {
    return animatePage(TicketsHistoryScreen());
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
