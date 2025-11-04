import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/di/injection.dart';



final configProvider = Provider((ref)=> getIt<RemoteConfigService>());

class RemoteConfigService {
  final FirebaseRemoteConfig _firebaseRemoteConfig;

  RemoteConfigService({FirebaseRemoteConfig? config})
    : _firebaseRemoteConfig = config ?? FirebaseRemoteConfig.instance {
    initialize();
  }
  Future<void> initialize() async {
    await _firebaseRemoteConfig.fetchAndActivate();
  }
  /// Returns a Remote Config string value for [key]. If the key is not set
  /// remotely this returns an empty string.
  String getString(String key) {
    try {
      return _firebaseRemoteConfig.getString(key) ?? '';
    } catch (_) {
      return '';
    }
  }
}
