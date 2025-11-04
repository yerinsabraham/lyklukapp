import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../utils/storage/local_storage.dart';


class UtilsServices {
  final PackageInfo packageInfo;
  final DeviceInfoPlugin deviceInfoPlugin;

   UtilsServices(
      {required this.deviceInfoPlugin, required this.packageInfo}){
        saveAppVersion();
        saveDeviceId();
      }


     void saveAppVersion() async {
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    LocalAppStorage.appVersion = version;
    LocalAppStorage.buildNumber = buildNumber;
    log.d('app version is $version and build number is $buildNumber');
  }

   Future<void> saveDeviceId() async {
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }
    LocalAppStorage.deviceId = deviceId ?? '';
    log.d(" device id is $deviceId");
  }  
}
