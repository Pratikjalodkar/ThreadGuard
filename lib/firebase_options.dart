// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDwO32PkJjUoj0T3e9YzfcH2Xb66b9nWPo',
    appId: '1:647755150503:web:a94ae05bc7ecba9ad2d782',
    messagingSenderId: '647755150503',
    projectId: 'threatguard-83118',
    authDomain: 'threatguard-83118.firebaseapp.com',
    storageBucket: 'threatguard-83118.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvdD0rGCfwGt2wm5j19YJ_01L0AI-G-no',
    appId: '1:647755150503:android:1ef695a9929fb154d2d782',
    messagingSenderId: '647755150503',
    projectId: 'threatguard-83118',
    storageBucket: 'threatguard-83118.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBD5dyWM33sCQVBZbNVzuNq1cDfoVLmfK0',
    appId: '1:647755150503:ios:6292fcc30a060f03d2d782',
    messagingSenderId: '647755150503',
    projectId: 'threatguard-83118',
    storageBucket: 'threatguard-83118.appspot.com',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBD5dyWM33sCQVBZbNVzuNq1cDfoVLmfK0',
    appId: '1:647755150503:ios:6292fcc30a060f03d2d782',
    messagingSenderId: '647755150503',
    projectId: 'threatguard-83118',
    storageBucket: 'threatguard-83118.appspot.com',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDwO32PkJjUoj0T3e9YzfcH2Xb66b9nWPo',
    appId: '1:647755150503:web:d2fb6263857c45bad2d782',
    messagingSenderId: '647755150503',
    projectId: 'threatguard-83118',
    authDomain: 'threatguard-83118.firebaseapp.com',
    storageBucket: 'threatguard-83118.appspot.com',
  );
}