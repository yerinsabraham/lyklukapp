import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverlayHelper {
  static OverlayEntry? overlayEntry;
  static void showOverlay(BuildContext context, [Widget? widget]) {
    final child = Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height,
      color: Colors.black.withValues(alpha: 0.3),
      child:
          widget ??
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 7.r,
              color: Colors.white,
            ),
          ),
    );
    overlayEntry = OverlayEntry(builder: (context) => child);
    Overlay.of(context).insert(overlayEntry!);
  }

  // static void showDownloadOverlay(BuildContext context) {
  //   final child = Container(
  //     width: double.infinity,
  //     height: MediaQuery.sizeOf(context).height,
  //     color: Colors.black.withValues(alpha: 0.3),
  //     child: HookConsumer(
  //       builder: (_, WidgetRef ref, __) {
  //         final progress = ref.watch(uploadProgressProvider);
  //         return Center(
  //           child: CircularProgressIndicator(
  //             strokeWidth: 7.r,
  //             color: Colors.white,
  //             value: progress,
  //             // valueColor: ColorTween(
  //             //   begin: Colors.white,
  //             //   end: AppColors.orangeColor,
  //             // ).animate(useAnimationController()),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //   overlayEntry = OverlayEntry(builder: (context) => child);
  //   Overlay.of(context).insert(overlayEntry!);
  // }

  static void removeOverlay() {
    if (overlayEntry == null) return;
    overlayEntry?.remove();
    overlayEntry = null;
  }

  static void showOverlay2(BuildContext context) {
    // final context = _tKey.currentContext;
    const child = Center(child: CircularProgressIndicator());
    OverlayEntry entry = OverlayEntry(builder: (context) => child);
    Overlay.of(context).insert(entry);
    // remove the entry
    Future.delayed(
      const Duration(seconds: 2),
    ).whenComplete(() => entry.remove());
  }
}
