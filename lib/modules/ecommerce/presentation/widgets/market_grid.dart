import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsSliverGrid extends HookConsumerWidget {
  final int count;
  final Widget Function(BuildContext, int) builder;
  final double? childAspectRatio;
  const ProductsSliverGrid({
    super.key,
    required this.builder,
    required this.count,
    this.childAspectRatio,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverGrid.builder(
      itemCount: count,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 20.h,
        childAspectRatio:  childAspectRatio??3 / 5,
      ),
      itemBuilder: builder,
    );
  }
}

class ProductsGrid extends HookConsumerWidget {
  final int count;
  final Widget Function(BuildContext, int) builder;
    final double? childAspectRatio;
  const ProductsGrid({super.key, required this.builder, required this.count, this.childAspectRatio});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: count,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 20.h,
        childAspectRatio: childAspectRatio??3 / 5,
      ),
      itemBuilder: builder,
    );
  }
}
