import 'package:flutter/widgets.dart';

class ImagePickerProvider extends ChangeNotifier {
  String _imageBytes = '';
  String _imageUrl = '';
  String get getImageBytes {
    return _imageBytes;
  }

  set setImageBytes(String bytes) {
    _imageBytes = bytes;
    notifyListeners();
  }

  String get getImageUrl {
    return _imageUrl;
  }

  set setImageUrl(String url) {
    _imageUrl = url;
    notifyListeners();
  }
}
