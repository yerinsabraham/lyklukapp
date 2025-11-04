import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/modules/profile/data/models/user_profile.dart';

import '../../modules/ecommerce/model/store_model.dart';

class HiveStorage {
  static Box<dynamic> box() {
    return Hive.box(boxName);
  }

  static const String boxName = 'app_hive';

  // App Theme
  static String get appTheme =>
      box().get('themeMode', defaultValue: ThemeMode.system.name) as String;
  static set themeMode(String value) => box().put('themeMode', value);

  // Access Token
  static String get accessToken =>
      box().get('accessToken', defaultValue: '') as String;
  static set accessToken(String value) => box().put('accessToken', value);

  // Refresh Token
  static String get refreshToken =>
      box().get('refreshToken', defaultValue: '') as String;
  static set refreshToken(String value) => box().put('refreshToken', value);

  // Registration Token
  static String get regAccessToken =>
      box().get('regAccessToken', defaultValue: '') as String;
  static set regAccessToken(String value) => box().put('regAccessToken', value);

  // X-Auth-Token
  static String get xAuthToken =>
      box().get('xAuthToken', defaultValue: '') as String;
  static set xAuthToken(String value) => box().put('xAuthToken', value);

  // Is Logged In
  static bool get isLoggedIn => accessToken.isNotEmpty;

  ///userId
  static String get userId => getUser.id.toString();
  // static set userId(String value) => box().put('userId', value);

  ///Username
  static String get username => getUser.username.toString();
  // box().get('username', defaultValue: '') as String;
  // static set username(String value) => box().put('username', value);

  // Is Onboarded
  static set isOnboarded(bool value) => box().put('isOnboarded', value);
  static bool get isOnboarded =>
      box().get('isOnboarded', defaultValue: false) as bool;

  // Is Token Available
  static bool get isTokenAvailable => accessToken.isNotEmpty;

  static String? get fullName =>
      box().get('fullName', defaultValue: null) as String?;

  /// save first name
  static set fullName(String? value) => box().put('fullName', value);

  /// get first name
  static String? get firstName =>
      box().get('firstName', defaultValue: null) as String?;

  /// save first name
  static set firstName(String? value) => box().put('firstName', value);

  /// get last name
  static String? get lastName =>
      box().get('lastName', defaultValue: null) as String?;

  /// save last name
  static set lastName(String? value) => box().put('lastName', value);

  /// get last name
  static String? get userEmail =>
      box().get('email', defaultValue: null) as String?;

  /// save last name
  static set userEmail(String? value) => box().put('email', value);

  /// get phone number
  static String? get phoneNumber =>
      box().get('phoneNumber', defaultValue: null) as String?;

  /// save fphone number
  static set phoneNumber(String? value) => box().put('phoneNumber', value);

  ///profile picture
  static String get profilePicture =>
      box().get('profilePicture', defaultValue: '') as String;
  static set profilePicture(String value) => box().put('profilePicture', value);

  static set saveUser(Map<String, dynamic> user) {
    box().put('user', jsonEncode(user));
  }

  static List<int> get interests {
    final res =
        box().get('interests', defaultValue: generateInterest()) as List;
    return List<int>.from(res);
  }

  static set interests(List<int> value) => box().put('interests', value);

  static UserProfile get getUser {
    final user = box().get('user');
    if (user != null) {
      return UserProfile.fromJson(
        Map<String, dynamic>.from((jsonDecode(user))),
      );
    }
    return UserProfile.empty();
  }

  static set store(StoreModel value)  {
    box().put('store', value.toJson());
  }

  static StoreModel get store {
    final store = box().get('store');
    if (store != null) {
      final raw= Map<String, dynamic>.from(store);
      return StoreModel.fromJson(
        Map<String, dynamic>.from(raw),
      );
    }
    return StoreModel.empty();
  }

  // Clear Boxes
  static Future<void> clearBoxes() async {
    await box().clear();
  }

  _saveData(String key, String data) async {
    await box().put(key, data);
  }

  dynamic saveData(String key, String data) async {
    if (getData(key) != null) {
      await box().delete(key);
    }
    await _saveData(key, data);
    return data;
  }

  dynamic getData(String key) {
    return box().get(key);
  }

  dynamic saveJsonData(String key, dynamic data) async {
    if (getData(key) != null) {
      await box().delete(key);
    }
    await _saveData(key, jsonEncode(data));
    return data;
  }

  dynamic getJsonData(String key) {
    return box().get(key) != null ? jsonDecode(box().get(key)) : null;
  }
}

class LocalAppStorage {
  static Box<dynamic> box() {
    return Hive.box('app_stable_hive');
  }

  /// theme mode
  /// isDakMode
  static bool? get isDakMode {
    return box().get('isDarKMode', defaultValue: null) as bool?;
  }

  static set isDarkMode(bool? isDakMode) => box().put("isDarKMode", isDakMode);

  /// set theme to either DARK, LIGHT, SYSTEM
  static set themeMode(String value) =>
      box().put("themeMode", value.toUpperCase());

  static ThemeMode get getThemeMode {
    final value = box().get("themeMode", defaultValue: "SYSTEM") as String;
    return switch (value) {
      "DARK" => ThemeMode.dark,
      "LIGHT" => ThemeMode.light,
      "SYSTEM" => ThemeMode.system,
      _ => ThemeMode.system,
    };
  }

  /// save app version
  static set appVersion(String value) => box().put('appVersion', value);
  static String get appVersion =>
      box().get('appVersion', defaultValue: '1.0.0') as String;

  /// save build number
  static set buildNumber(String value) => box().put('buildNumber', value);
  static String get buildNumber =>
      box().get('buildNumber', defaultValue: '1') as String;

  // Device ID
  static String get deviceId =>
      box().get('deviceId', defaultValue: '') as String;
  static set deviceId(String value) => box().put('deviceId', value);

  ///fcm
  static String get fcm => box().get('fcm', defaultValue: '') as String;
  static set fcm(String value) => box().put('fcm', value);

  // save current user location
  static set saveUserLocation(Map<String, double> value) {
    box().put('currentLocation', value);
    log.d('user location saved successfully, $value');
  }

  static Map<String, double> get location {
    return box().get(
          'currentLocation',
          defaultValue: {'latitude': 0.0, "longitude": 0.0},
        )
        as Map<String, double>;
  }

  static set location(Map<String, double> value) {
    box().put('currentLocation', value);
  }

  // is onboarded
  static bool get isOnboarded =>
      box().get('isOnboarded', defaultValue: false) as bool;
  static set isOnboarded(bool value) => box().put('isOnboarded', value);

  // static LocationData get getUserLocation {
  //   final raw =
  //       box().get(
  //             'currentLocation',
  //             defaultValue: {'latitude': 0.0, "longitude": 0.0},
  //           )
  //           as Map;
  //   log.d(' This the  user current location from storage $raw');
  //   final value = Map<String, double>.from(raw);
  //   return LocationData.fromMap(value);
  //   // return LocationData(latitude: value['lat'], longitude: value['lng']);
  // }
}

List<int> generateInterest() {
  final random = Random();
  final List<int> numbers = List.generate(
    3,
    (_) => random.nextInt(10) + 1, // 1 to 10
  );
  return numbers;
}
