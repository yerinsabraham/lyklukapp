import 'package:flutter/material.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/theme.dart';
import 'package:lykluk/core/shared/widgets/loading_widget.dart';

class LoadingWithText extends StatelessWidget {
  final String? text;
  final EdgeInsets padding;
  const LoadingWithText({super.key, this.text, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: LoadingWidget(color: Color(AppColors.primaryColor)),
            ),
            10.sH,
            Text(
              text ?? 'Loading... Please wait',
              style: context.body14Bold.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
