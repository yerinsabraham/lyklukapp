import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

enum Flavor { dev, prod }

class FlavorConfig {
  static Flavor appFlavor = kDebugMode ? Flavor.dev : Flavor.prod;

  static FirebaseOptions get android {
    switch (appFlavor) {
      case Flavor.dev:
        return const FirebaseOptions(
          apiKey: 'AIzaSyCh8B0ON1Ip0s5zDnR4a5lHFIte9azUstI',
          appId: '1:971756828487:android:e7ce372ebc15fe4ceb3e62',
          messagingSenderId: '971756828487',
          projectId: 'lykluk-staging',
          storageBucket: 'lykluk-staging.firebasestorage.app',
        );
      case Flavor.prod:
        return const FirebaseOptions(
          apiKey: 'AIzaSyBvuauALpcJW-ancDT3J9qlbqGpq_YwNTI',
          appId: '1:989199363639:android:6568b1cfdb42a09d78d9b2',
          messagingSenderId: '989199363639',
          projectId: 'lykluk-79b75',
          storageBucket: 'lykluk-79b75.firebasestorage.app',
        );
    }
  }

  static FirebaseOptions get ios {
    switch (appFlavor) {
      case Flavor.dev:
        return const FirebaseOptions(
          apiKey: 'AIzaSyCF7Gb0I168DheJzRxdjGDBveZOqVB5vtw',
          appId: '1:728695047638:ios:d7084dff70b903e04e9077',
          messagingSenderId: '728695047638',
          projectId: 'lykluk-467006',
          storageBucket: 'lykluk-467006.firebasestorage.app',
          iosBundleId: 'com.lykluk.lyklukDev',
        );
      case Flavor.prod:
        return const FirebaseOptions(
          apiKey: 'AIzaSyCF7Gb0I168DheJzRxdjGDBveZOqVB5vtw',
          appId: '1:728695047638:ios:cc12ac0bdcb4bfe04e9077',
          messagingSenderId: '728695047638',
          projectId: 'lykluk-467006',
          storageBucket: 'lykluk-467006.firebasestorage.app',
          iosBundleId: 'lykluk.com',
        );
    }
  }

  static FirebaseOptions get web {
    switch (appFlavor) {
      case Flavor.dev:
        return const FirebaseOptions(
          apiKey: 'AIzaSyAShN1flaeVxtjscneR2Ogv8ztjwwLGQGQ',
          appId: '1:971756828487:web:33a4ad881022888deb3e62',
          messagingSenderId: '971756828487',
          projectId: 'lykluk-staging',
          authDomain: 'lykluk-staging.firebaseapp.com',
          storageBucket: 'lykluk-staging.firebasestorage.app',
          measurementId: 'G-MF7P449GEV',
        );
      case Flavor.prod:
        return const FirebaseOptions(
          apiKey: 'AIzaSyASdph1gRU_VBZ-G7s6p-ADZ81cDEjdXtI',
          appId: '1:989199363639:web:9faee3d741ba93aa78d9b2',
          messagingSenderId: '989199363639',
          projectId: 'lykluk-79b75',
          authDomain: 'lykluk-79b75.firebaseapp.com',
          storageBucket: 'lykluk-79b75.firebasestorage.app',
          measurementId: 'G-6QK3GJ2RS0',
        );
    }
  }
}
