import 'package:flutter/cupertino.dart';

class BottomSheetProvider extends ChangeNotifier {
  bool _isLoadingProgress = false;

  bool get getLoadingProgress {
    return _isLoadingProgress;
  }

  set setLoadingProgress(bool value) {
    _isLoadingProgress = value;

    notifyListeners();
  }

}