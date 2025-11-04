import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lykluk/utils/theme/texts.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

/// Unified selectable item widget that can handle different display modes
/// Consolidates insights_item, tools_item, goal_selection_item, and audience_option_item
class SelectableItemWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? value;
  final String? svgIconPath;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final SelectableItemMode mode;
  final Color? backgroundColor;
  final Color? selectedColor;

  const SelectableItemWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.value,
    this.svgIconPath,
    this.icon,
    this.isSelected = false,
    this.onTap,
    required this.mode,
    this.backgroundColor,
    this.selectedColor,
  });

  /// Factory constructor for insights display (with label and value)
  factory SelectableItemWidget.insights({
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return SelectableItemWidget(
      title: label,
      value: value,
      onTap: onTap,
      mode: SelectableItemMode.insights,
    );
  }

  /// Factory constructor for tools display (with icon)
  factory SelectableItemWidget.tools({
    required String title,
    IconData? icon,
    String? svgIconPath,
    VoidCallback? onTap,
  }) {
    return SelectableItemWidget(
      title: title,
      icon: icon,
      svgIconPath: svgIconPath,
      onTap: onTap,
      mode: SelectableItemMode.tools,
    );
  }

  /// Factory constructor for goal selection (with selection state)
  factory SelectableItemWidget.goalSelection({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return SelectableItemWidget(
      title: title,
      isSelected: isSelected,
      onTap: onTap,
      mode: SelectableItemMode.goalSelection,
    );
  }

  /// Factory constructor for audience option (with subtitle)
  factory SelectableItemWidget.audienceOption({
    required String title,
    String? subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return SelectableItemWidget(
      title: title,
      subtitle: subtitle,
      isSelected: isSelected,
      onTap: onTap,
      mode: SelectableItemMode.audienceOption,
    );
  }

  /// Factory constructor for menu option (with icon and arrow)
  factory SelectableItemWidget.menuOption({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return SelectableItemWidget(
      title: title,
      icon: icon,
      onTap: onTap,
      mode: SelectableItemMode.menuOption,
      backgroundColor: textColor,
      selectedColor: iconColor,
    );
  }

  /// Factory constructor for settings list item (with icon and arrow)
  factory SelectableItemWidget.settingsItem({
    required String title,
    IconData? icon,
    required VoidCallback onTap,
    Color? titleColor,
    Color? iconColor,
    bool showArrow = true,
  }) {
    return SelectableItemWidget(
      title: title,
      icon: icon,
      onTap: onTap,
      mode: SelectableItemMode.settingsItem,
      backgroundColor: titleColor,
      selectedColor: iconColor,
      isSelected: showArrow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: _getContainerDecoration(),
        padding: _getContainerPadding(),
        child: _buildContent(context),
      ),
    );
  }

  /// Get container decoration based on mode and selection state
  BoxDecoration? _getContainerDecoration() {
    switch (mode) {
      case SelectableItemMode.goalSelection:
      case SelectableItemMode.audienceOption:
        return BoxDecoration(
          color: backgroundColor ?? const Color(AppColors.transparent),
          border:
              isSelected
                  ? Border.all(
                    color: selectedColor ?? const Color(AppColors.blueColor),
                    width: 2.w,
                  )
                  : null,
          borderRadius: BorderRadius.circular(8.r),
        );
      default:
        return null;
    }
  }

  /// Get container padding based on mode
  EdgeInsets _getContainerPadding() {
    switch (mode) {
      case SelectableItemMode.goalSelection:
      case SelectableItemMode.audienceOption:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h);
      case SelectableItemMode.menuOption:
        return EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h);
      case SelectableItemMode.settingsItem:
        return EdgeInsets.symmetric(vertical: 12.h);
      default:
        return EdgeInsets.zero;
    }
  }

  /// Build content based on mode
  Widget _buildContent(BuildContext context) {
    switch (mode) {
      case SelectableItemMode.insights:
        return _buildInsightsContent(context);
      case SelectableItemMode.tools:
        return _buildToolsContent(context);
      case SelectableItemMode.goalSelection:
        return _buildGoalSelectionContent(context);
      case SelectableItemMode.audienceOption:
        return _buildAudienceOptionContent(context);
      case SelectableItemMode.menuOption:
        return _buildMenuOptionContent(context);
      case SelectableItemMode.settingsItem:
        return _buildSettingsItemContent(context);
    }
  }

  /// Build insights content (label + value)
  Widget _buildInsightsContent(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200.w,
          child: AppText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(AppColors.textColor3),
            fontFamily: 'Figtree',
            height: 1.22,
          ),
        ),
        const Spacer(),
        AppText(
          text: value ?? '',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(AppColors.textColor3),
          fontFamily: 'Figtree',
          height: 1.22,
        ),
        SizedBox(width: 13.w),
        Container(
          width: 12.w,
          height: 12.h,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(right: 3.w),
          decoration: const BoxDecoration(),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 12.sp,
            color: const Color(AppColors.secondaryTextColor2),
          ),
        ),
      ],
    );
  }

  /// Build tools content (icon + title)
  Widget _buildToolsContent(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 270.w,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20.w,
                height: 20.h,
                child:
                    svgIconPath == null || svgIconPath == ''
                        ? Icon(
                          icon ?? Icons.circle,
                          size: 20.sp,
                          color: const Color(AppColors.textColor3),
                        )
                        : SvgPicture.asset(
                          svgIconPath!,
                          width: 20.w,
                          height: 20.h,
                        ),
              ),
              SizedBox(width: 15.w),
              AppText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(AppColors.textColor3),
                fontFamily: 'Figtree',
                height: 1.22,
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          width: 12.w,
          height: 12.h,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(right: 3.w),
          decoration: const BoxDecoration(),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 12.sp,
            color: const Color(AppColors.secondaryTextColor2),
          ),
        ),
      ],
    );
  }

  /// Build goal selection content (title + selection indicator)
  Widget _buildGoalSelectionContent(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 279.w,
          child: AppText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(AppColors.textColor3),
            fontFamily: 'Figtree',
            height: 1.22,
          ),
        ),
        SizedBox(width: 58.w),
        Container(
          width: 20.w,
          height: 20.h,
          decoration: ShapeDecoration(
            color:
                isSelected
                    ? const Color(AppColors.backArrowBlueColor)
                    : const Color(AppColors.transparent),
            shape: const OvalBorder(),
            gradient:
                isSelected
                    ? const LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [
                        Color(AppColors.backArrowBlueColor),
                        Color(0xFF5A1C96),
                      ],
                    )
                    : null,
          ),
          child:
              isSelected
                  ? Icon(
                    Icons.check,
                    size: 12.sp,
                    color: const Color(AppColors.white),
                  )
                  : Container(
                    decoration: ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 1.w,
                          color: const Color(0xFFCBD3DA),
                        ),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }

  /// Build audience option content (title + subtitle + selection indicator)
  Widget _buildAudienceOptionContent(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 279.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(AppColors.textColor3),
                fontFamily: 'Figtree',
                height: 1.22,
              ),
              if (subtitle != null) ...[
                SizedBox(height: 10.h),
                AppText(
                  text: subtitle!,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6C7278),
                  fontFamily: 'Figtree',
                  height: 1.33,
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: 58.w),
        Container(
          width: 20.w,
          height: 20.h,
          decoration: ShapeDecoration(
            color:
                isSelected
                    ? const Color(AppColors.backArrowBlueColor)
                    : const Color(AppColors.transparent),
            shape: const OvalBorder(),
            gradient:
                isSelected
                    ? const LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [
                        Color(AppColors.backArrowBlueColor),
                        Color(0xFF5A1C96),
                      ],
                    )
                    : null,
          ),
          child:
              isSelected
                  ? Icon(
                    Icons.check,
                    size: 12.sp,
                    color: const Color(AppColors.white),
                  )
                  : Container(
                    decoration: ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 1.w,
                          color: const Color(0xFFCBD3DA),
                        ),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }

  /// Build menu option content (title + icon, no arrow)
  Widget _buildMenuOptionContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AppText(
            text: title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: backgroundColor ?? const Color(AppColors.textColor3),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 12.w),
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Icon(
            icon ?? Icons.circle,
            size: 24.sp,
            color: selectedColor ?? const Color(AppColors.textColor3),
          ),
        ),
      ],
    );
  }

  /// Build settings item content (icon + title + arrow)
  Widget _buildSettingsItemContent(BuildContext context) {
    return Row(
      children: [
        // Icon container
        SizedBox(
          width: 24.w,
          height: 24.h,
          child:
              icon != null
                  ? Icon(
                    icon,
                    size: 24.sp,
                    color:
                        selectedColor ??
                        const Color(AppColors.secondaryTextColor2),
                  )
                  : const SizedBox(),
        ),
        SizedBox(width: 10.w),

        // Title
        Expanded(
          child: AppText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: backgroundColor ?? const Color(AppColors.textColor3),
            fontFamily: 'Figtree',
            height: 1.22,
          ),
        ),

        // Arrow (if enabled)
        if (isSelected)
          SizedBox(
            width: 18.w,
            height: 18.h,
            child: Icon(
              Icons.chevron_right,
              size: 18.sp,
              color: const Color(AppColors.secondaryTextColor2),
            ),
          ),
      ],
    );
  }
}

/// Enum for different selectable item modes
enum SelectableItemMode {
  insights, // For displaying metrics with label and value
  tools, // For displaying tools with icon and arrow
  goalSelection, // For goal selection with radio button
  audienceOption, // For audience options with title, subtitle, and radio button
  menuOption, // For menu options with icon (no arrow)
  settingsItem, // For settings list items with icon and arrow
}
