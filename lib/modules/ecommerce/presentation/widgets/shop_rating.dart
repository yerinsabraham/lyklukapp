import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/context_ext.dart';

class ShopRating extends StatelessWidget {
  const ShopRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
          WidgetSpan(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: 16.sp,
                  color: context.colorScheme.inversePrimary,
                ),
                Text(
                  ' 4.5',
                  style: context.body14Light.copyWith(
                    color: context.colorScheme.inversePrimary,
                  ),
                ),
                Text(
                  '(37.4k)',
                  style: context.body14Light.copyWith(
                    color: context.colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ),
        );
  }
}