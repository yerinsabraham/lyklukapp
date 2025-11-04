import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class AppRatingBar extends StatelessWidget {
  final Function(double) onRatingUpdate;
  final double? initial;
  final double iconSize;
  final bool isEnable;
  const AppRatingBar({
    super.key,
    required this.onRatingUpdate,
    this.iconSize = 20,
    this.initial,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: !isEnable,
      itemSize: iconSize.sp,
      glowColor: context.colorScheme.secondary,
      unratedColor: context.colorScheme.onSecondary.withValues(alpha: .3),
      initialRating: initial ?? 0,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
      itemBuilder:
          (context, _) => Icon(Icons.star, size: 15.sp, color: Colors.amber),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
