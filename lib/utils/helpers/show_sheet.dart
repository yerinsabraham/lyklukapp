import 'package:flutter/material.dart';
import 'package:lykluk/utils/theme/theme.dart';

Future<T?> showSheet<T>(
  BuildContext context, {
  required Widget child,
  double? maxHeight,
  bool isScrollControlled = false,
  bool showDragHandle= true,
  BoxConstraints? constraints,
  double? scrollControlDisabledMaxHeightRatio,

}) async {
  return await showModalBottomSheet<T?>(
    context: context,
    showDragHandle: showDragHandle,
    useSafeArea: true,
    useRootNavigator: true,
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: isScrollControlled,
    scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio ?? 0.5,
    constraints:  constraints,
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
