import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShimmerList extends StatelessWidget {
  final Widget child;
  final int count;
  const ShimmerList({required this.child, super.key,  this.count= 10});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
     enabled: true,
      child: ListView.separated(
        separatorBuilder: (c, i) => 10.sH,
        itemCount: count,
        itemBuilder: (c, i) {
          return child;
        },
      ),
    );
  }
}

class ShimmerGrid extends StatelessWidget {
  final Widget child;
  final int count;
  final double? childAspectRatio;
  const ShimmerGrid({required this.child, super.key, this.count = 15, this.childAspectRatio});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: count,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.w,
          mainAxisSpacing: 20.h,
          childAspectRatio: childAspectRatio ?? 3 / 5,
        ),
        itemBuilder: (c, i) {
          return child;
        },
      ),
    );
  }
}
