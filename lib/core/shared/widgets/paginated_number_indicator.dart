import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/circle_icon.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class PaginatedNumberIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  final int visibleCount;

  const PaginatedNumberIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.visibleCount = 5, // how many page numbers visible at a time
  });

  List<int> _visiblePages() {
    final half = (visibleCount / 2).floor();
    int start = (currentPage - half).clamp(1, totalPages - visibleCount + 1);
    int end = (start + visibleCount - 1).clamp(start, totalPages);
    return List.generate(end - start + 1, (i) => start + i);
  }

  @override
  Widget build(BuildContext context) {
    final pages = _visiblePages();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Previous arrow
        CircleIcon(
          color: context.colorScheme.onSecondary.withValues(alpha: 0.03),
          onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          child: const Icon(Icons.chevron_left),
        ),

        // Page numbers
        SizedBox(
          width: context.width * 0.65,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                 ...pages.map((page) {
                  final isActive = page == currentPage;
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 2.w),
                    child: CircleIcon(
                      onTap: () => onPageChanged(page),
                      child: CircleIcon(
                        color:
                            isActive
                                ? context.colorScheme.primary
                                : context.colorScheme.onSecondary.withValues(
                                  alpha: 0.03,
                                ),
                        child: Text(
                          page.toString(),
                          style: context.body14.copyWith(
                            color: isActive ? context.colorScheme.surface : null,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            
              ]),
          ),
        ),
       
        // Next arrow
        CircleIcon(
          color: context.colorScheme.onSecondary.withValues(alpha: 0.03),
          onTap:
              currentPage < totalPages
                  ? () => onPageChanged(currentPage + 1)
                  : null,
          child: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}




class NumberPager extends HookConsumerWidget {
  final int currentIndex;
  final Function(int) onChange;
  final int total;
  const NumberPager({
    super.key,
    required this.currentIndex,
    required this.onChange,
    required this.total,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleIcon(
          onTap: () {
            controller.animateToPage(
              (1 - currentIndex) % total,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          color: context.colorScheme.onSecondary.withValues(alpha: 0.03),
          child: Icon(Icons.arrow_back_ios, size: 15),
        ),
        SizedBox(
          width: context.width * 0.5,
          child: SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(total, (i) {
                return Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: CircleIcon(
                    onTap: () {
                      onChange(i);
                    },
                    color:
                        currentIndex == i
                            ? context.colorScheme.primary
                            : context.colorScheme.onSecondary.withValues(
                              alpha: 0.03,
                            ),
                    child: Text(
                      "${i + 1}",
                      style: context.body14.copyWith(
                        color:
                            currentIndex == i
                                ? context.colorScheme.surface
                                : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        CircleIcon(
          onTap: () {
            controller.animateToPage(
              (currentIndex + 1) % total,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          color: context.colorScheme.onSecondary.withValues(alpha: 0.03),
          child: Icon(Icons.arrow_forward_ios, size: 15),
        ),
      ],
    );
  }
}
