// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyABWdHcAzfetx405yG6TvZp4MJ6DrVbS_Y',
    appId: '1:831456807199:android:6322ce8e2e2724accb882a',
    messagingSenderId: '831456807199',
    projectId: 'rave-trade-ca544',
    storageBucket: 'rave-trade-ca544.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCB8pwIjcM_BQEdaPMT_hQDZNtWeLgR2WI',
    appId: '1:831456807199:ios:540c7548cabf8a6ecb882a',
    messagingSenderId: '831456807199',
    projectId: 'rave-trade-ca544',
    storageBucket: 'rave-trade-ca544.appspot.com',
    androidClientId: '831456807199-1otc8peen525k4ihn80rf081s6igd8sb.apps.googleusercontent.com',
    iosClientId: '831456807199-uuivtrqimk2453j0i6dshmf75a9luhn7.apps.googleusercontent.com',
    iosBundleId: 'com.RaveTradeApp.RaveTrade',
  );
}
