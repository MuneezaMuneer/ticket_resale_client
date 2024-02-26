import 'package:flutter/material.dart';

class ButtonState extends ChangeNotifier {
  bool _isActive = false;

  bool get isActive => _isActive;

  void toggleStatus() {
    _isActive = !_isActive;
    notifyListeners();
  }
}
