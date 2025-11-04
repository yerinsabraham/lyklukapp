import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/presentation/widgets/notification_filter_chip.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/theme.dart';

class NotificationHeader extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const NotificationHeader({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      NotificationConstants.filterAll,
      NotificationConstants.filterRequests,
      NotificationConstants.filterComments,
      NotificationConstants.filterSuggestions,
      NotificationConstants.filterMentions,
      NotificationConstants.filterCommunity,
      NotificationConstants.filterPodcasts,
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: NotificationConstants.topPadding.h,
        left: NotificationConstants.headerPadding.w,
        right: NotificationConstants.headerPadding.w,
        bottom: 10.h,
      ),
      decoration: BoxDecoration(
        color: const Color(NotificationConstants.headerBackgroundColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: NotificationConstants.avatarSize.w,
                  height: NotificationConstants.avatarSize.h,
                  decoration: ShapeDecoration(
                    color: const Color(
                      NotificationConstants.avatarBackgroundColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        NotificationConstants.avatarBorderRadius,
                      ),
                    ),
                  ),
                  child: Center(
                    child: AppButton.button(
                      onPressed: () {
                        AppRouter.router.pop();
                      },
                      backgroundColor: Colors.transparent,
                      borderRadius: BorderRadius.zero,
                      widget: Icon(
                        Icons.arrow_back,
                        size: NotificationConstants.iconSize.w,
                        color: const Color(
                          NotificationConstants.activeFilterColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                AppText(
                  text: 'Notifications',
                  color: const Color(NotificationConstants.primaryTextColor),
                  fontSize: NotificationConstants.titleFontSize.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontConstant.bricolage,
                ),
              ],
            ),
          ),
          SizedBox(
            height: NotificationConstants.filterButtonHeight.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                final filter = filters[index];
                return NotificationFilterChip(
                  label: filter,
                  isSelected: selectedFilter == filter,
                  onTap: () => onFilterChanged(filter),
                  width: _getFilterWidth(filter),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  double _getFilterWidth(String filter) {
    switch (filter) {
      case NotificationConstants.filterComments ||
          NotificationConstants.filterSuggestions ||
          NotificationConstants.filterCommunity:
        return 92.w;
      default:
        return 83.w;
    }
  }
}
