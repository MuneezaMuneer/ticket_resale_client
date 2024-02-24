import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchProvider extends ChangeNotifier {
  bool _notification = true;
  bool get getNotification => _notification;

  bool _comment = false;
  bool get getComment => _comment;

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _notification = prefs.getBool('notification') ?? false;
    _comment = prefs.getBool('comment') ?? false;
    notifyListeners();
  }

  Future<void> savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification', _notification);
    await prefs.setBool('comment', _comment);
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
