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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDWKQV-Yu4Rr13_KB4jCHyoDVJB8v1JnhU',
    appId: '1:525606001037:web:b2ecdbe49f24a6249205c4',
    messagingSenderId: '525606001037',
    projectId: 'kltn-hethongtuoitieu-87ff7',
    authDomain: 'kltn-hethongtuoitieu-87ff7.firebaseapp.com',
    databaseURL:
        'https://kltn-hethongtuoitieu-87ff7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kltn-hethongtuoitieu-87ff7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnOmt_-fgq0fwABrfvyN0HQo-Yi3ZcB04',
    appId: '1:525606001037:android:120912fd9c55eb839205c4',
    messagingSenderId: '525606001037',
    projectId: 'kltn-hethongtuoitieu-87ff7',
    databaseURL:
        'https://kltn-hethongtuoitieu-87ff7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kltn-hethongtuoitieu-87ff7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1980lR8rH1Af4UJe6JZkAZMldoN-kwy4',
    appId: '1:525606001037:ios:40ddf979df8c0d439205c4',
    messagingSenderId: '525606001037',
    projectId: 'kltn-hethongtuoitieu-87ff7',
    databaseURL:
        'https://kltn-hethongtuoitieu-87ff7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kltn-hethongtuoitieu-87ff7.appspot.com',
    iosClientId:
        '525606001037-teqp1lbuvfsq5msvk29r6bejm77gk1r8.apps.googleusercontent.com',
    iosBundleId: 'com.example.kltn',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1980lR8rH1Af4UJe6JZkAZMldoN-kwy4',
    appId: '1:525606001037:ios:40ddf979df8c0d439205c4',
    messagingSenderId: '525606001037',
    projectId: 'kltn-hethongtuoitieu-87ff7',
    databaseURL:
        'https://kltn-hethongtuoitieu-87ff7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kltn-hethongtuoitieu-87ff7.appspot.com',
    iosClientId:
        '525606001037-teqp1lbuvfsq5msvk29r6bejm77gk1r8.apps.googleusercontent.com',
    iosBundleId: 'com.example.kltn',
  );
}
