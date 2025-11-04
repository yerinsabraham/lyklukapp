import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  ///full month name
  List<String> get fullMonths => [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  ///returns the month name in short form
  List<String> get months => [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String toCustomFormatString() {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    final day = days[weekday - 1];
    final month = months[this.month];

    final hour =
        this.hour > 12
            ? this.hour - 12
            : this.hour == 0
            ? 12
            : this.hour;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? 'PM' : 'AM';

    return '$day, $month ${this.day} • $hour:$minute $period';
  }

  /// returns the date in the format of 2021-09-09
  String get date {
    return '$day/$month/$year';
  }

  String get datedash {
    final v = this;
    return DateFormat('yyyy-MM-dd').format(v);
  }

  /// returns the date in the format of 09, Sep 2021
  String get date2 {
    return '$day ${months[month]} $year';
  }

  /// returns the date in the format of 09, Sep 2021
  String get date3 {
    return '${months[month]} $day, $year';
  }

  String get durationFromToDay {
    final now = DateTime.now().toLocal();
    final difference = now.difference(this);
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        } else {
          return '${difference.inMinutes}m ago';
        }
      } else {
        return '${difference.inHours}h ago';
      }
    } else {
      return '${difference.inDays}d ago';
    }
  }

  /// e.g ends in 2 days
  String get differeneFromToday {
    final now = DateTime.now();
    final difference = this.difference(now);
    if (difference.inDays == 0) {
      return ' Ends today';
    } else {
      if (difference.inDays == 1) {
        return 'Ends in tomorrow';
      }
      return 'Ends in ${difference.inDays} days';
    }
  }

  String get toTHFormat {
    final s = this;
    final day = s.day;
    final month = s.month;

    String getOrdinalSuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    return '$day${getOrdinalSuffix(day)} ${months[month]}';
  }

  /// to return the time in the format of 12:00 PM
  String get to24HoursFormat {
    final hour =
        this.hour > 12
            ? this.hour - 12
            : this.hour == 0
            ? 12
            : this.hour;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  /// returns 12 hours ago
  String get toAgo {
    final now = DateTime.now().toLocal();
    final difference = now.difference(this);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        } else {
          return '${difference.inMinutes}m ago';
        }
      } else {
        return '${difference.inHours}h ago';
      }
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 365) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    }
  }

  /// returns 12 hours ago
  String get toTime {
    final now = DateTime.now().toLocal();
    final difference = now.difference(this);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'now';
        } else {
          return '${difference.inMinutes}m';
        }
      } else {
        return '${difference.inHours}h';
      }
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 365) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y';
    }
  }

  /// in minutes and period
  /// 12:00 PM
  String get toMinutesPeriodFormat {
    final hour =
        this.hour > 12
            ? this.hour - 12
            : this.hour == 0
            ? 12
            : this.hour;
    final period = this.hour >= 12 ? 'PM' : 'AM';

    return '$hour$period';
  }

  // Format date as "Today 3PM", "Yesterday 3PM", or "3rd July 3PM"
  String get toTodayOrYesterday {
    final s = this;

    if (s.isToday) {
      return 'Today ${s.toTimePeriodFormat}';
    } else if (s.isYesterday) {
      return 'Yesterday ${s.toTimePeriodFormat}';
    } else if (s.isTomorrow) {
      return 'Tomorrow ${s.toTimePeriodFormat}';
    } else {
      return '${s.toDayMonthFormat} ${s.toTimePeriodFormat}';
    }
  }

  /// Check if the date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if the date is yesterday
  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if the date is tomorrow
  bool get isTomorrow {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Format time as "3:00 PM"
  String get toTimePeriodFormat {
    final hour =
        this.hour > 12
            ? this.hour - 12
            : this.hour == 0
            ? 12
            : this.hour;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  /// Format date as "3rd July"
  String get toDayMonthFormat {
    final daySuffix = _getDaySuffix(day);
    final monthName = _getMonthName(month);

    return '$day$daySuffix $monthName';
  }

  /// Get the suffix for a day (e.g., "1st", "2nd", "3rd", etc.)
  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  /// Get the month name based on the month number
  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month - 1];
  }

  /// get reminder day from the current and the given date
  int get getReminderDay {
    final s = this;
    final isAboveToDay = s.isAfter(DateTime.now().toLocal());
    if (isAboveToDay) {
      return s.difference(DateTime.now().toLocal()).inDays;
    } else {
      return 0;
    }
  }

  /// set for reminder time
  String get toReminderTime {
    final s = this;
    return s.add(const Duration(days: 1)).millisecondsSinceEpoch.toString();
  }

  /// to get difference in days from the current date
  int get differenceInDays {
    final s = this;
    return s.difference(DateTime.now()).inDays;
  }
}

extension TimeofDayExt on TimeOfDay {
  String get toFormattedString {
    final hour =
        this.hour > 12
            ? this.hour - 12
            : this.hour == 0
            ? 12
            : this.hour;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  /// converts the TimeofDay to dateTime
  DateTime toDateTime(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  /// to remider time
  int get toReminderTime {
    final s = this;
    final toDay = s.toDateTime(DateTime.now().toLocal());
    return toDay.add(const Duration(days: 1)).millisecondsSinceEpoch;
  }
}

String issueDate(String transactionDate) {
  // Remove ordinal suffixes like "st", "nd", "rd", "th"
  String cleanedDate = transactionDate.replaceAllMapped(
    RegExp(r'(\d{1,2})(st|nd|rd|th)'),
    (match) => match.group(1)!,
  );

  // Parse the cleaned date string
  DateTime? date =
      DateFormat("d MMM, yyyy. h:mm a").parse(cleanedDate, true).toLocal();
  DateTime today = DateTime.now().toLocal();

  String formatDate(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

  if (formatDate(date) == formatDate(today)) {
    return 'Today';
  } else if (formatDate(date) ==
      formatDate(today.subtract(const Duration(days: 1)))) {
    return 'Yesterday';
  }

  return DateFormat('d MMMM').format(date); // e.g., 13 April
}

/// Helper function to parse message value from API response
String? parseResponseMessage(dynamic message) {
  if (message == null) return null; // ✅ Handle null case

  // ✅ Convert message to a String (if it's not already one)
  String messageStr = message.toString().trim();

  try {
    // ✅ Check if message looks like a JSON array (e.g., '["Error 1", "Error 2"]')
    if (messageStr.startsWith('[') && messageStr.endsWith(']')) {
      final decoded = jsonDecode(messageStr);

      // ✅ If it's a List<String>, join with newlines
      if (decoded is List && decoded.every((e) => e is String)) {
        return decoded.join('\n');
      }
    }

    // ✅ If it's already a normal string, return it
    return messageStr.replaceAll(RegExp(r'^\[|\]$'), ''); // ✅ Remove brackets
  } catch (e) {
    // ✅ If JSON decoding fails, return as is (but still remove brackets)
    return messageStr.replaceAll(RegExp(r'^\[|\]$'), '');
  }
}

String formatTransactionDate(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  // Get day suffix
  String day = date.day.toString();
  String suffix;
  if (day.endsWith('1') && day != '11') {
    suffix = 'st';
  } else if (day.endsWith('2') && day != '12') {
    suffix = 'nd';
  } else if (day.endsWith('3') && day != '13') {
    suffix = 'rd';
  } else {
    suffix = 'th';
  }

  String formattedDate = DateFormat("MMM, yyyy . h:mm a").format(date);
  return "${date.day}$suffix $formattedDate";
}
