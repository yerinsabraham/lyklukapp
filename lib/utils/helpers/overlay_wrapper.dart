import 'package:flutter/material.dart';

class OverlayWrapper {
  static   OverlayEntry? _overlayEntry;

   static void showOverlay({
    required BuildContext context,
    required Widget child,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return child;
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

 static  void removeOverlay() {

    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
