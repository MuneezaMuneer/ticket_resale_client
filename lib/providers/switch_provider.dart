import 'package:flutter/material.dart';

class SwitchProvider extends ChangeNotifier {
  bool _value = false;
  bool get getValue => _value;
  setValue(bool value) {
    _value = value;
    notifyListeners();
  }

  bool _comment = false;
  bool get getComment => _comment;
  setComment(bool comment) {
    _comment = comment;
    notifyListeners();
  }
}
