import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_resale/constants/app_texts.dart';
import 'package:ticket_resale/db_services/auth_services.dart';

class SwitchProvider extends ChangeNotifier {
  bool _notification = true;
  bool get getNotification => _notification;
  bool _commentValue = false;

  bool get getComment => _commentValue;

  Future<void> fetchCommentValueFromFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference user =
        firestore.collection('user_data').doc(AuthServices.userUid);
    DocumentSnapshot snapshot = await user.get();
    if (snapshot.exists) {
      bool commentValue =
          (snapshot.data() as Map<String, dynamic>)['comment_value'] ?? false;

      _commentValue = commentValue;
      notifyListeners();
    }
  }

  Future<void> loadPreferences() async {
    SharedPreferences? prefs = AppText.preference;
    _notification = prefs?.getBool('notification') ?? true;

    notifyListeners();
  }

  Future<void> savePreferences() async {
    SharedPreferences? prefs = AppText.preference;
    await prefs?.setBool('notification', _notification);
  }

  setNotification(bool notification) {
    _notification = notification;
    notifyListeners();
    savePreferences();
  }
}
