import 'package:flutter/material.dart';

class UserTypeProvider extends ChangeNotifier {
  UserType _userType = UserType.client;

  UserType get userType => _userType;

  void setUserType(UserType type) {
    _userType = type;
    notifyListeners();
  }
}

enum UserType {
  client,
  admin,
}
