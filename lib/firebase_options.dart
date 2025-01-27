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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBPUIR-VwKLhbe-VAe1HacRWboTWQ7AGzk',
    appId: '1:58268360785:web:a497e2a1a6298878151870',
    messagingSenderId: '58268360785',
    projectId: 'si-fi-6ebe1',
    authDomain: 'si-fi-6ebe1.firebaseapp.com',
    storageBucket: 'si-fi-6ebe1.appspot.com',
    measurementId: 'G-WP9HMZGQ1L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBR09Ignyl1Gk8x-GYXeTIv5vlQb3W22rI',
    appId: '1:58268360785:android:89b5d1d1a78acdae151870',
    messagingSenderId: '58268360785',
    projectId: 'si-fi-6ebe1',
    storageBucket: 'si-fi-6ebe1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSKjpab4z-sYXvLSyfEqmUJmuKkiu6mP4',
    appId: '1:58268360785:ios:eef5b31efa8143e6151870',
    messagingSenderId: '58268360785',
    projectId: 'si-fi-6ebe1',
    storageBucket: 'si-fi-6ebe1.appspot.com',
    iosBundleId: 'com.example.xilancer',
  );
}
