import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final int duration;
  Timer? _timer;
  Debounce({required this.duration});

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(Duration(milliseconds: duration), action);
  }

  void dispose() {
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    } else {
      _timer = null;
    }
  }
}
