// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/bottom_sheet.dart';
import '../db_services/db_services.dart';

class NotificationServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<String?> getFCMCurrentDeviceToken() async {
    return await messaging.getToken();
  }

  static Future<void> appOpenInBackground(
      {required BuildContext context}) async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleNotificationResponse(context, message);
      log('Message clicked!');
    });
  }

  static void forGroundNotifications(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (Platform.isAndroid) {
        notificationSettings(context: context, message: message);
        log('............... data ==  ${message.data}');

        showNotification(
          title: message.notification!.title ?? '',
          body: message.notification!.body ?? '',
        );
      }
    });
  }

  static Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      messaging.setForegroundNotificationPresentationOptions(
          alert: true, sound: true, badge: false);

      return true;
    } else {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        return true;
      } else {
        return false;
      }
    }
  }

  static Future<void> notificationSettings(
      {required BuildContext context, required RemoteMessage message}) async {
    var iosInitializationSetting = const DarwinInitializationSettings();
    var androidInitializationSetting =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSetting = InitializationSettings(
        android: androidInitializationSetting, iOS: iosInitializationSetting);

    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      handleNotificationResponse(context, message);
      print('object');
    });
  }

  static void handleNotificationResponse(
      BuildContext context, RemoteMessage message) async {
    if (AuthServices.getCurrentUser.uid.isNotEmpty) {
      if (FirebaseAuth.instance.currentUser != null) {
        String? id = message.data['id'];
        String? userId = message.data['user_id'];
        String? notificationType = message.data['notification_type'];

        if (id != null && userId != null) {
          String hashKey =
              FireStoreServicesClient.getMessagesHashCodeID(userIDReceiver: id);
          UserModelClient userModel =
              await FireStoreServicesClient.fetchDataOfUser(userId: userId);

          if (notificationType == 'ticket_listing') {
            Navigator.pushNamed(context, AppRoutes.detailFirstScreen,
                arguments: id);
          } else if (notificationType == 'offer_confirm') {
            Navigator.pushNamed(
              context,
              AppRoutes.chatDetailScreen,
              arguments: {
                'receiverId': id,
                'hashKey': hashKey,
                'isOpened': false,
              },
            );
          } else {
            CustomBottomSheet.showConfirmTicketsSheet(
                context: context,
                hashKey: hashKey,
                id: {'seller_uid': userId},
                userModel: userModel);
          }
        }
      }
    }
  }

  static Future<void> showNotification(
      {required String title, required String body}) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        math.Random.secure().nextInt(100000).toString(), "Rave Trade",
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetail =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Rave Trade Application',
      importance: Importance.high,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetail);
    Future.delayed(
      Duration.zero,
      () {
        flutterLocalNotificationsPlugin.show(
          0,
          title,
          body,
          notificationDetails,
        );
      },
    );
  }

  static Future<void> sendNotification(
      {required String token,
      required String title,
      required String body,
      required Map<String, dynamic> data}) async {
    if (token.isEmpty) {
      log('Unable to send FCM message, no token exists.');
      return;
    }
    log("................Web.................Notification :$token");
    try {
      await http
          .post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'key= ${ApiURLS.fcmServerKey}'
            },
            body: json.encode({
              'to': token,
              "notification": {
                "title": title,
                "body": body,
              },
              "data": data
            }),
          )
          .then((value) => log('.....--- body -- ${value.body}'));
      log('FCM request for web sent!');
    } catch (e) {
      log('Error is: ${e.toString()}');
    }
  }

  static Future<List<String>> getAdminFCMTokens() async {
    List<String> tokens = [];

    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("admin_data").get();
    for (var element in snapshot.docs) {
      tokens.add(element.data()['token']);
    }

    print('The token is $tokens');

    log('The token is $tokens');
    return tokens;
  }
}
