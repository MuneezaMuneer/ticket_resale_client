import 'package:flutter/material.dart';

class FeedbackProvider extends ChangeNotifier {
  int _experience = 0;
  int get getExperience => _experience;
  void setExperience(int experience) {
    _experience = experience;
    notifyListeners();
  }

  int _time = 3;
  int get getTime => _time;
  void setTime(int time) {
    _time = time;
    notifyListeners();
  }

   int _accurate = 5;
  int get getAccuracy => _accurate;
  void setAccuracy(int accurate) {
    _accurate = accurate;
    notifyListeners();
  }

  int _behaviour = 7;
  int get getBehave=> _behaviour;
  void setBehave(int behaviour){
    _behaviour = behaviour;
    notifyListeners();
  }
  
}
