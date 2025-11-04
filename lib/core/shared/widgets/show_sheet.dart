import 'package:flutter/material.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';

void showSheet(
  BuildContext context, {
  required Widget child,
  double? maxHeight,
  bool isScrollControlled = false,
  bool showHandle =true,

}) async {
  await showModalBottomSheet(
    context: context,
    showDragHandle: showHandle,
    useSafeArea: true,
    useRootNavigator: true,
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: isScrollControlled,
    constraints: BoxConstraints(maxHeight: maxHeight ?? context.height * 0.5),
    backgroundColor: Color(AppColors.backgroundColor),
    builder: (context) => child,
  );
}

Future<T?> showAppDialog<T>(
  BuildContext context, {
  required Widget child,
}) async {
  return await showGeneralDialog<T?>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(child: child);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
