import 'package:flutter/material.dart';

class SelectedDJProvider extends ChangeNotifier {
  String? _selectedDJName;

  String? get selectedDJName => _selectedDJName;

  void setSelectedDJName(String? djName) {
    _selectedDJName = djName;
    notifyListeners();
  }
}
