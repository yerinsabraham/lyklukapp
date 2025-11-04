import 'package:intl/intl.dart';

String formatDateToCustomFormat(String date) {
  DateTime parseDate = DateTime.parse(date);
  final day = DateFormat('d').format(parseDate);
  final month = DateFormat('MMMM').format(parseDate);

  // Add the suffix to the day
  String dayWithSuffix = day;
  final int dayInt = int.parse(day);
  if (dayInt >= 11 && dayInt <= 13) {
    dayWithSuffix += 'th';
  } else if (dayInt % 10 == 1) {
    dayWithSuffix += 'st';
  } else if (dayInt % 10 == 2) {
    dayWithSuffix += 'nd';
  } else if (dayInt % 10 == 3) {
    dayWithSuffix += 'rd';
  } else {
    dayWithSuffix += 'th';
  }

  return '$dayWithSuffix $month';
}

// Write a code to convert a string to an integer in

// add two numbers
