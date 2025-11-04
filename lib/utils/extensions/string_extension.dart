import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lykluk/core/services/cloudinary_service.dart';
import 'package:lykluk/core/services/logger_service.dart';

enum PasswordValidationType { length, upperCase, lowerCase, digit, specialChar }

extension StringExtension on String {
  String get capitalize {
    if (isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  DateTime get toDateTime {
    return DateTime.parse(this);
  }

  static String capitalizeFirst(String string) {
    if (string.isEmpty) return '';
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }

  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(
    RegExp(' +'),
    ' ',
  ).split(' ').map((str) => str.toCapitalized).join(' ');

  /// validate email
  bool isValidEmail() {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:"
      r"\.[a-zA-Z0-9-]+)*$",
    ).hasMatch(this);
  }

  // /// validate password
  // bool isValidPassword() {
  //   return RegExp(
  //           r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
  //       .hasMatch(this);
  // }

  /// isPassword 8 character
  bool get isEightCharater {
    return length >= 8;
  }

  /// isPassword has one uppercase
  bool get isOneUppercase {
    return contains(RegExp(r'[A-Z]'));
  }

  /// isPhone
  bool get isPhone {
    return contains(RegExp(r'^\+1\s\([0-9]{3}\)\s[0-9]{3}-[0-9]{4}$'));
  }

  /// isPassword has one lowercase
  bool get isOneLowercase {
    return contains(RegExp(r'[a-z]'));
  }

  /// isPassword has one digit
  bool get isOneNumber {
    return contains(RegExp(r'[0-9]'));
  }

  /// conbine this 4 validation
  bool get isValidPassword {
    return isEightCharater && isOneUppercase && isOneLowercase && isOneNumber;
  }

  /// is Email valid

  bool get isEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  /// is valid number
  bool get isValidPhoneNumber {
    final v = this;
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    return phoneRegex.hasMatch(v);
  }

  ///
  /// convert an hax color to color
  Color get color {
    return Color(int.parse(this, radix: 16) + 0xFF000000);
  }

  /// to Today 20
  String get toToday {
    return split(' ')[0];
  }

  /// format currency
  String get formatCurrency {
    final doubleData = double.parse(this);
    final NumberFormat formatter = NumberFormat("#,##0.00", "en_US");
    final correct = formatter.format(doubleData).split('.')[0];
    return correct;
  }

  /// substring the first 2 characters
  String get firstTwo {
    if(length < 2){
      return '';
    }
    return substring(0, 2);
  }

  /// dateTime generator from string
  DateTime fromDaySection(DateTime startDate) {
    final isNowBeforeStart = DateTime.now().toLocal().isAfter(
      startDate.toLocal(),
    );
    final ramd =
        Random().nextInt(24) < DateTime.now().hour
            ? DateTime.now().toLocal().hour +
                Random().nextInt(24 - DateTime.now().toLocal().hour)
            : Random().nextInt(24);
    final value = toLowerCase();
    switch (value) {
      case 'anytime':
        return DateTime(
          startDate.year,
          startDate.month,
          startDate.day,
          ramd,
          0,
          0,
        ).toLocal();
      case 'morning':
        return DateTime(
          startDate.year,
          startDate.month,
          isNowBeforeStart ? startDate.day - 1 : startDate.day,
          9,
          0,
          0,
        ).toLocal();
      case 'afternoon':
        return DateTime(
          startDate.year,
          startDate.month,
          isNowBeforeStart ? startDate.day - 1 : startDate.day,
          12,
          0,
          0,
        ).toLocal();
      case 'evening':
        return DateTime(
          startDate.year,
          startDate.month,
          isNowBeforeStart ? startDate.day - 1 : startDate.day,
          19,
          0,
          0,
        ).toLocal();
      default:
        return DateTime(
          startDate.year,
          startDate.month,
          startDate.day,
          ramd,
          0,
          0,
        ).toLocal();
    }
  }

  /// convert from 2:00 PM to  datetime
  DateTime get fromStringToDateTime {
    final time = this;
    final hour = int.parse(time.split(':')[0]);
    final period = time.split(' ')[1];
    final isPm = period.toLowerCase() == 'pm';
    final newHour = isPm ? hour + 12 : hour;
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      newHour,
    );
  }

  /// dateTime generator from string
  DateTime pickTime(DateTime startDate, String time) {
    final isNowBeforeStart = DateTime.now().toLocal().isAfter(
      startDate.toLocal(),
    );
    final ramd = time.fromStringToDateTime;
    final value = toLowerCase();
    switch (value) {
      case 'anytime':
        log.d('anytime: ${ramd.hour}');
        return DateTime(
          startDate.year,
          startDate.month,
          startDate.day,
          ramd.hour,
          0,
          0,
        ).toLocal();
      case 'morning':
        return DateTime(
          startDate.year,
          startDate.month,
          isNowBeforeStart ? startDate.day - 1 : startDate.day,
          9,
          0,
          0,
        ).toLocal();
      case 'afternoon':
        return DateTime(
          startDate.year,
          startDate.month,
          isNowBeforeStart ? startDate.day - 1 : startDate.day,
          12,
          0,
          0,
        ).toLocal();
      case 'evening':
        return DateTime(
          startDate.year,
          startDate.month,
          isNowBeforeStart ? startDate.day - 1 : startDate.day,
          19,
          0,
          0,
        ).toLocal();
      default:
        return DateTime(
          startDate.year,
          startDate.month,
          startDate.day,
          ramd.hour,
          0,
          0,
        ).toLocal();
    }
  }

  /// toDaySection

  String get toDaySection {
    final time = DateTime.parse(this);
    if (time.hour == 8) {
      return 'Morning';
    } else if (time.hour >= 12) {
      return 'Afternoon';
    } else if (time.hour == 19) {
      return 'Evening';
    } else {
      return 'Anytime';
    }
  }

  /// get duration from challenge status
  String getDurationFromChallengeStatus(int duration) {
    switch (toLowerCase()) {
      case 'ongoing':
        return 'Ends in $duration days';
      case 'scheduled':
        return 'Starts in $duration days';
      case 'completed':
        return 'Completed in $duration';
      default:
        return '$duration days';
    }
  }

  /// pluralize
  String pluralizeString(String single, String plural) {
    try {
      final intValue = int.parse(this);
      if (intValue <= 0) return '';
      if (intValue == 1) {
        return '1 $single';
      }
      return '$this $plural';
    } catch (e) {
      return '';
    }
  }

  /// to check if a path String is a valid image or video
  CloudinaryType get isImageOrVideo {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
    final videoExtensions = ['mp4', 'mov', 'avi', 'flv', 'wmv', '3gp'];
    final ext = split('.').last;
    // return imageExtensions.contains(ext) || videoExtensions.contains(ext);
    if (imageExtensions.contains(ext)) {
      return CloudinaryType.image;
    } else if (videoExtensions.contains(ext)) {
      return CloudinaryType.video;
    } else {
      return CloudinaryType.image;
    }
  }

  /// to remove link from a string text and  return the linko or null
  String? get removeLink {
    final link = RegExp(r'(https?://[^\s]+)').firstMatch(this);
    if (link != null) {
      return link.group(0);
    }
    return null;
  }

  /// remove link from a string text and return the text  that
  String? get removeLinkText {
    final newText = replaceAll(RegExp(r'(https?://[^\s]+)'), '');
    if (newText.isEmpty) {
      return null;
    }
    return this;
  }

  /// generate a random color from hashcode of a string and exclude white or shades of white
  Color get generateStableColor {
    final hash = hashCode;
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = hash & 0x0000FF;

    /// exclude white or shades of white
    if (r == 255 && g == 255 && b == 255) {
      return const Color.fromARGB(255, 0, 0, 0);
    } else {
      return Color.fromARGB(255, r, g, b);
    }
  }
}

extension OptionalString on String? {
  /// to captialize first letter  of every word in a sentence eg. 'john mike' => 'John Mike'
  String get capitalizeFirstLetter {
    final sentence = this;
    if (sentence == null) return '';
    List<String> words = sentence.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }

  String get capitalizeTwoRandomLetters {
    final input = this;
    if (input == null || input.isEmpty) return '';
    if (input.length < 2) return input.toUpperCase(); // handle short strings

    final random = Random();
    final indexes = <int>{};

    // Pick 2 unique random indexes
    while (indexes.length < 2) {
      indexes.add(random.nextInt(input.length));
    }

    final indexList = indexes.toList();
    final buffer = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      if (indexList.contains(i)) {
        buffer.write(input[i].toUpperCase());
      } else {
        buffer.write(input[i]);
      }
    }

    return buffer.toString();
  }

  String get formatString {
    final input = this;
    if (input == null || input.isEmpty) {
      return '';
    }

    // List of currency codes to check
    const currencyCodes = ['USD', 'NGN', 'EUR'];

    // Check if the input string contains any of the currency codes
    for (var code in currencyCodes) {
      if (input.contains(code)) {
        // If found, return the string with the currency code in uppercase
        return input.replaceAllMapped(
          RegExp(code, caseSensitive: false),
          (match) => match[0]!.toUpperCase(),
        );
      }
    }

    // If no currency code is found, capitalize the first letter of each word
    return input
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}

/// randow oxff color
extension RandomColor on String {
  Color get randomColor {
    return Color(int.parse(this, radix: 16) + 0xFF000000);
  }
}

String formatPhoneNumber(String phoneNumber) {
  if (phoneNumber.length < 2) return '**** **** **';
  String lastTwo = phoneNumber.substring(phoneNumber.length - 2);
  return '**** **** $lastTwo';
}

int? parseInt(dynamic value) {
  if (value is int) return value;
  if (value is String) {
    return int.tryParse(value);
  }
  return null;
}
