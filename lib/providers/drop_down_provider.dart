import 'package:flutter/material.dart';
class DropDownProvider extends ChangeNotifier {
  String _selectedOption = 'Date';
  String get selectedOption => _selectedOption;
  void toggleSelectedOption() {
    _selectedOption = _selectedOption == 'Date' ? 'Price' : 'Date';
    notifyListeners();
  }
  void setSelectedOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }
}
