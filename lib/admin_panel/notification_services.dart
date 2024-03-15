import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const _fcmAPI = 'https://fcm.googleapis.com/fcm/send';
  static const _serverKEy =
      'AAAAwZawCR8:APA91bGv744R5IO8MZdhSvTjkzoBgV7nPt33A4DO8F5Oopw8GWuFZEJ3Whnz_mf4NCYf0jOuy4MjiRKSgiUDxmZTyNmsAe7Gf_XdD9jI6wCx0VJ7mcxxl2ABFpQ5XDlu5TAK7c9JTmRR';

  static Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  static void sendPushNotification(
      {required String title,
      required String body,
      required String token}) async {
    try {
      await http
          .post(
            Uri.parse(_fcmAPI),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'key=$_serverKEy'
            },
            body: json.encode({
              'to':
                  'eeqdB0VHSvOatxMgUNnvyf:APA91bHD3XNIcwB7-BxD30TUE7KtFSWyLZPkdlWuKNnvRYDIpyfzlI-A1Q4Fs69G5HXQEoA3xfQoGxZLUI_I0RKt4WoXjpXrOCgrJkaAQI35fHIV4DUtAuf_VZJpVsEh8pag67SCZeM9',
              "notification": {"title": title, "body": body}
            }),
          )
          .then((value) => print(value.body));
      print('FCM request for web sent!');
    } catch (e) {
      print(e);
    }
  }

  static void requestPermission() {
    if (Platform.isIOS) {
      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions(
            alert: false,
            badge: true,
            sound: true,
          );
    } else {
      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }
  }

  static void initializeNotification() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(
      {required String title, required String body}) async {
    var androidChannelSpecifics = const AndroidNotificationDetails(
      'NOTIFICATIO_ID',
      'NAME',
      channelDescription: "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }
}
