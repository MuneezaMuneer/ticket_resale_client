import 'package:flutter/material.dart';

class ClearProvider extends ChangeNotifier {
  String _searchText = '';

  String get searchText => _searchText;

  void clearSearchText() {
    _searchText = '';
    notifyListeners();
  }

  set setSearchText(String newText) {
    _searchText = newText;
    notifyListeners();
  }
}
