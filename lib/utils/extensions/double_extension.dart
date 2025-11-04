import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

extension DoubleExtension on num {
  String get getPenCentage {
    final s = this;
    if (s < 0 || s > 100) {
      return '';
    }
    return '${floor()}%';
  }

  double get convertPencentageDecimal {
    final s = this;
    if (s < 0 || s > 100) {
      return 0;
    }
    return this / 100;
  }

  ///  division
  double div(double up, double down) {
    if (up == 0 || down == 0) return 0;
    return up / down;
  }

  /// check if the number is between the range
  /// [min] and [max]
  bool isBetween(double min, double max) {
    return this >= min && this <= max;
  }

  /// check if a number is a multiple of 7
  bool get isMultipleOfSeven {
    return this % 7 == 0;
  }
}

extension IntExt on int {
  String puralize(String single, String plural) {
    final s = this;
    if (s <= 0) {
      return '';
    } else if (s == 1) {
      return '$s $single';
    } else {
      return '$s $plural';
    }
  }

  /// to convert to neccessary group like thousand K, milliin M,
  String get toGroup {
    final s = this;
    if (s >= 0 && s < 1000) return '$s';
    if (s >= 1000 && s < 100000) {
      return '${s.toString().substring(0, 1)}K';
    } else if (s >= 100000 && s < 1000000) {
      return '${s.toString().substring(0, 2)}K';
    } else if (s >= 1000000 && s < 100000000) {
      return '${s.toString().substring(0, 1)}M';
    } else if (s >= 100000000 && s < 1000000000) {
      return '${s.toString().substring(0, 2)}M';
    } else {
      return 'Over 1B';
    }
  }
}

extension NumExt on num {
  /// to check if number is above 60 to  return hours and minutes
  String get time {
    if (this > 60) {
      final hour = this ~/ 60;
      final minute = this % 60;
      return '$hour hr ${minute.toStringAsFixed(0)} mins';
    } else {
      return '${toStringAsFixed(0)} mins';
    }
  }

  SizedBox get sH {
    return SizedBox(height: h);
  }

  SliverToBoxAdapter get sHs {
    return SliverToBoxAdapter(child: SizedBox(height: h));
  }

  SizedBox get sW {
    return SizedBox(width: w);
  }

  SliverToBoxAdapter get sWs {
    return SliverToBoxAdapter(child: SizedBox(width: w));
  }

  /// divider width container
  String get toCurrency {
    final NumberFormat formatter = NumberFormat("#,##0.00", "en_US");
    final correct = formatter.format(this).split('.')[0];
    return correct;
  }

  /// from convert number to corresponding string e.g 1 -First , 2- second
  String get toName {
    final val = floor();
    switch (val) {
      case 1:
        return 'First';
      case 2:
        return 'Second';
      case 3:
        return 'Third';
      case 4:
        return 'Fourth';
      default:
        return '${val}th';
    }
  }

  String pluralize(String singular, String plural) {
    if (this <= 0) return '0 $singular';
    if (this == 1) {
      return "$this $singular";
    } else {
      return "$this $plural";
    }
  }
}



extension ListUtils<T> on List<T> {
  void replaceAt(int index, T newValue) {
    if (isEmpty) {
      throw RangeError('Cannot replace in empty list');
    }
    if (index < 0 || index >= length) {
      throw RangeError('Index $index out of range (0-${length - 1})');
    }
    this[index] = newValue;
  }

  bool tryReplaceAt(int index, T newValue) {
    if (isEmpty) return false;
    if (index < 0 || index >= length) return false;
    this[index] = newValue;
    return true;
  }

  // Alternative: Add element if list is empty and index is 0
  bool tryReplaceOrAddAt(int index, T newValue) {
    if (isEmpty && index == 0) {
      add(newValue);
      return true;
    }
    if (index < 0 || index >= length) return false;
    this[index] = newValue;
    return true;
  }

  // void replaceOrAddAt(int index, T newValue) {
  //   if (isEmpty && index == 0) {
  //     add(newValue);
  //     return;
  //   }
  //   if (isEmpty || index >= length || index< 0) {
  //       throw RangeError('Index $index out of range (0-${length - 1})');
  //   }

  //   // if (index < 0 || index >= length) {
  //   //   throw RangeError('Index $index out of range (0-${length - 1})');
  //   // }
  //   this[index] = newValue;
  // }
  void replaceOrAddAt(int index, T newValue) {
    if (index < 0) {
      throw RangeError('Index cannot be negative: $index');
    }

    if (index < length) {
      // Index exists, replace it
      this[index] = newValue;
    } else {
      // Index doesn't exist, add nulls until we reach the index, then add the value
      // while (length < index) {
      //   add(null as T); // Add nulls to fill the gap
      // }
      add(newValue); // Add the actual value at the requested index
    }
  }
}
