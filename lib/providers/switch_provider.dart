import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_resale/constants/app_texts.dart';

class SwitchProvider extends ChangeNotifier {
  bool _notification = true;
  bool get getNotification => _notification;
  bool _comment = false;
  bool get getComment => _comment;
  Future<void> loadPreferences() async {
    SharedPreferences? prefs = AppText.preference;
    _notification = prefs?.getBool('notification') ?? true;
    _comment = prefs?.getBool('comment') ?? false;
    notifyListeners();
  }

  Future<void> savePreferences() async {
    SharedPreferences? prefs = AppText.preference;
    await prefs?.setBool('notification', _notification);
    await prefs?.setBool('comment', _comment);
  }

  setNotification(bool notification) {
    _notification = notification;
    notifyListeners();
    savePreferences();
  }

  setComment(bool comment) {
    _comment = comment;
    notifyListeners();
    savePreferences();
  }
}
