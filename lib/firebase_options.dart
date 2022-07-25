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
    apiKey: 'AIzaSyAxkgo7vqCr0Z5taDFGs_OHIafWjydsJM0',
    appId: '1:838635491378:web:4933eaf841bfde7713ac2b',
    messagingSenderId: '838635491378',
    projectId: 'bike-service-app-8aae9',
    authDomain: 'bike-service-app-8aae9.firebaseapp.com',
    storageBucket: 'bike-service-app-8aae9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfiOeV7w5CId1YuibeQ5RkpLATAcz6YeQ',
    appId: '1:838635491378:android:778ebede0c03f5b013ac2b',
    messagingSenderId: '838635491378',
    projectId: 'bike-service-app-8aae9',
    storageBucket: 'bike-service-app-8aae9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPrGnev6YFqyydP7VwXMLl5Q5qIRpS4io',
    appId: '1:838635491378:ios:32f30001359c5e9513ac2b',
    messagingSenderId: '838635491378',
    projectId: 'bike-service-app-8aae9',
    storageBucket: 'bike-service-app-8aae9.appspot.com',
    iosClientId: '838635491378-q9t30cgtc4avm424fu6p9e1mq8vsv341.apps.googleusercontent.com',
    iosBundleId: 'com.example.bikeServiceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPrGnev6YFqyydP7VwXMLl5Q5qIRpS4io',
    appId: '1:838635491378:ios:32f30001359c5e9513ac2b',
    messagingSenderId: '838635491378',
    projectId: 'bike-service-app-8aae9',
    storageBucket: 'bike-service-app-8aae9.appspot.com',
    iosClientId: '838635491378-q9t30cgtc4avm424fu6p9e1mq8vsv341.apps.googleusercontent.com',
    iosBundleId: 'com.example.bikeServiceApp',
  );
}
