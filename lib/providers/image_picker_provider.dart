import 'package:flutter/widgets.dart';

class ImagePickerProvider extends ChangeNotifier {
  String imagePath = '';
  String get getPath => imagePath;
  set setPath(String path) {
    imagePath = path;
    notifyListeners();
  }
}
