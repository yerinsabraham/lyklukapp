import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/context_ext.dart';

class ContainerSeparator extends StatelessWidget {
  const ContainerSeparator({
    super.key,
    this.height = 1,
    this.color = Colors.black,
    this.activeColor,
    this.count = 1,
    this.index = 0,
    required this.onSelect,

    this.itemWidth,
    this.mainAxisAlignment,
  });
  final double height;
  final double? itemWidth;
  final Color color;
  final Color? activeColor;
  final int count;
  final int index;
  final MainAxisAlignment? mainAxisAlignment;
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final eachWidth = (boxWidth / count).floorToDouble() - (1 * count);
        final dashHeight = height;
        // final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment:
              mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(count, (i) {
            return GestureDetector(
              onTap: () {
                // pageController.jumpToPage(i);
                onSelect(i);
              },
              child: Container(
                margin: EdgeInsets.only(right: 5.w),
                width: itemWidth ?? eachWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color:
                        index >= i
                            ? activeColor ?? context.colorScheme.primary
                            : const Color(0xffF5DBF7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
