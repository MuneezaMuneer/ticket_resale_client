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

  bool _isinstaProgress = false;
  bool get getInstaProgress => _isinstaProgress;
  set setInstaProgress(bool value) {
    _isinstaProgress = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
