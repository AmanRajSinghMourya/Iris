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
    apiKey: 'AIzaSyDHs-raSoqXdXw2g41c8sJvStURPq4NYy8',
    appId: '1:786510428184:web:86cf5884c5f558fd126b6d',
    messagingSenderId: '786510428184',
    projectId: 'iris-e579a',
    authDomain: 'iris-e579a.firebaseapp.com',
    storageBucket: 'iris-e579a.appspot.com',
    measurementId: 'G-C3EXFKZTP3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaWqcDWFOq_zuwbqCroTiUQjVQC7QdHvM',
    appId: '1:786510428184:android:bf55bf935ddc8703126b6d',
    messagingSenderId: '786510428184',
    projectId: 'iris-e579a',
    storageBucket: 'iris-e579a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmnckuZHq2ARb2UXTdyMRaV1TaDjlrRbU',
    appId: '1:786510428184:ios:ccfb245fc84605b6126b6d',
    messagingSenderId: '786510428184',
    projectId: 'iris-e579a',
    storageBucket: 'iris-e579a.appspot.com',
    iosBundleId: 'com.example.iris',
  );
}
