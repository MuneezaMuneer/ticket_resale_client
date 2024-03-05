import 'package:flutter/material.dart';
class SearchProvider extends ChangeNotifier {
  bool _isSearching = false;
  bool get isSearching => _isSearching;
  void toggleSearch() {
    _isSearching = !_isSearching;
    notifyListeners();
  }
  void setSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }
}
