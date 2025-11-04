import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/auth/presentation/views/components/agreement_sheet.dart';
import 'package:lykluk/modules/auth/presentation/views/components/login_sheet.dart';
import 'package:lykluk/modules/auth/presentation/views/components/sign_up_sheet.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/components/draft_settings_sheet.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/components/location_search_screen.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/components/post_settings_sheet.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/components/song_picker_sheet.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/post_action_sheets.dart';
import 'package:lykluk/modules/profile/presentation/views/widgets/settings_option_sheet.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/show_sheet.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/app_colors.dart';
import 'package:lykluk/utils/theme/buttons.dart';
import 'package:lykluk/utils/theme/texts.dart';

class AppSheet {
  static Future<T?> _showSheet<T>({
    required BuildContext context,
    required Widget child,
    double? minHeight,
    double? maxHeightFactor,
    bool useWhiteBackground = true,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final minH = (minHeight ?? 500.h).clamp(0.0, screenHeight);
    final maxH = (maxHeightFactor ?? 0.80) * screenHeight;

    bool isScrollable(Widget widget) {
      return widget is ListView ||
          widget is GridView ||
          widget is CustomScrollView ||
          widget is SingleChildScrollView;
    }

    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'BottomSheet',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 550),
      pageBuilder: (ctx, anim, secAnim) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: EdgeInsets.zero,
            child: Material(
              color:
                  useWhiteBackground
                      ? Color(AppColors.white)
                      : Colors.transparent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minH, maxHeight: maxH),
                child: LayoutBuilder(
                  builder: (ctx, box) {
                    if (isScrollable(child)) {
                      return child;
                    }
                    return SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: box.maxHeight),
                        child: child,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (ctx, animation, secondary, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeIn,
        );

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }

  static void showAgreementSheet(BuildContext context) {
    final overlay = Navigator.of(context).overlay!;
    final overlayBox = overlay.context.findRenderObject() as RenderBox;

    final buttonBox = context.findRenderObject() as RenderBox;
    final buttonSize = buttonBox.size;
    final buttonTopLeft = buttonBox.localToGlobal(
      Offset.zero,
      ancestor: overlayBox,
    );
    final buttonCenter =
        buttonTopLeft + Offset(buttonSize.width / 2, buttonSize.height / 2);

    final origin = Alignment(
      (buttonCenter.dx / overlayBox.size.width) * 2 - 1,
      (buttonCenter.dy / overlayBox.size.height) * 2 - 1,
    );

    showGeneralDialog(
      context: overlay.context,
      barrierDismissible: true,
      barrierLabel: 'AgreementDialog',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (ctx, anim, secAnim) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Dismissible(
              key: const ValueKey('agreement_dialog'),
              direction: DismissDirection.vertical,
              onDismissed: (_) => Navigator.of(ctx).maybePop(),
              child: Dialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 40.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 20.h,
                    maxHeight: MediaQuery.of(ctx).size.height * 0.3,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AgreementSheet(),
                        SizedBox(height: 10.h),
                        AppButton(
                          isLoading: false,
                          isDisabled: false,
                          onPressed: () {
                            AppRouter.router.pop();
                            AppRouter.router.goNamed(Routes.navBarRoute);
                          },
                          borderRadius: BorderRadius.circular(5.r),
                          backgroundColor: Color(AppColors.buttonColor),
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                text: 'Agree and Continue',
                                fontSize: 14.sp,
                                color: Color(AppColors.primaryColor),
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (ctx, animation, secondaryAnimation, child) {
        final curvedIn = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeIn,
        );

        final slideFromButton = Tween<Offset>(
          begin: Offset(origin.x * 0.05, origin.y * 0.05),
          end: Offset.zero,
        ).animate(curvedIn);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slideFromButton,
            child: Transform.scale(
              alignment: origin,
              scale:
                  Tween<double>(begin: 0.85, end: 1.0).animate(curvedIn).value,
              child: child,
            ),
          ),
        );
      },
    );
  }

  static void showAuthSheet(BuildContext context) {
    _showSheet(
      context: context,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [SignUpSheet()],
      ),
      minHeight: 500.h,
      maxHeightFactor: 0.80,
    );
  }

  static void showLoginSheet(BuildContext context) {
    _showSheet(
      context: context,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [LoginSheet()],
      ),
      minHeight: 500.h,
      maxHeightFactor: 0.90,
    );
  }

  static void showSignUpSheet(BuildContext context) {
    _showSheet(
      context: context,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [SignUpSheet()],
      ),
      minHeight: 500.h,
      maxHeightFactor: 0.90,
    );
  }

  static void showErrorSheet(
    BuildContext context,
    String message, {
    String? title,
    VoidCallback? onAction,
    String? buttonText,
  }) {
    _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 8.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: const Color(0xFFDEE2E6),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          // ErrorView(message: message, title: title, buttonText: buttonText),
          SizedBox(height: 16.h),
        ],
      ),
      minHeight: 500.h,
      maxHeightFactor: 0.80,
    );
  }

  static void showWarningSheet(
    BuildContext context,
    String message, {
    String? title,
    VoidCallback? onAction,
    required String buttonText,
  }) {
    _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 8.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: const Color(0xFFDEE2E6),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          // WarningView(message: message, title: title, onAction: onAction, buttonText: buttonText),
          SizedBox(height: 16.h),
        ],
      ),
      minHeight: 500.h,
      maxHeightFactor: 0.80,
    );
  }

  static void showSongPickerSheet(BuildContext context) {
    _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [const SongPickerSheet()],
      ),
      minHeight: 500.h,
      maxHeightFactor: 0.80,
    );
  }

  static void showPostSettingsSheet(BuildContext context) {
    _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [const PostSettingsSheet()],
      ),
      minHeight: 500.h,
      maxHeightFactor: 0.62,
    );
  }

  static void showLocationSettingsSheet(BuildContext context) {
    _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [const LocationSearchScreen()],
      ),
      minHeight: 500.h,
      maxHeightFactor: 0.80,
    );
  }

  static void showDraftSettingsSheet(
    BuildContext context, {
    VoidCallback? onDiscard,
    VoidCallback? onSaveDraft,
  }) {
    _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          DraftSettingsSheet(onDiscard: onDiscard, onSaveDraft: onSaveDraft),
        ],
      ),
      minHeight: 150.h,
      maxHeightFactor: .23,
    );
  }

  static Future<void> showSettingOptionsSheet(BuildContext context) {
    return showSheet(
      context,
      child: const SettingsOptionsSheet(),
      showDragHandle: false,
      maxHeight: context.height * 0.5,
      scrollControlDisabledMaxHeightRatio: 0.5

      // minHeight: 200.h,
      // maxHeightFactor: .28,
    );
  }

  /// OPTIONS (Save / Not interested / Hide icons / Copy link / Share to / Mute / Block / Report)
  static Future<void> showPostOptionsSheet(
    BuildContext context, {
    required String authorName,
    required ImageProvider avatar,
    VoidCallback? onSave,
    VoidCallback? onNotInterested,
    VoidCallback? onToggleIcons,
    VoidCallback? onCopyLink,
    VoidCallback? onShareTo,
  }) {
    return _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          OptionsSheet(
            authorName: authorName,
            avatar: avatar,
            onSave: onSave,
            onNotInterested: onNotInterested,
            onToggleIcons: onToggleIcons,
            onCopyLink: onCopyLink,
            onShareTo: onShareTo,
          ),
        ],
      ),
      minHeight: 420.h,
      maxHeightFactor: 0.58,
    );
  }

  /// MUTE CONFIRM
  static Future<void> showMuteConfirmSheet(
    BuildContext context, {
    required String authorName,
    required ImageProvider avatar,
    required VoidCallback onMute,
  }) {
    return _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          MuteSheet(authorName: authorName, avatar: avatar, onMute: onMute),
        ],
      ),
      minHeight: 420.h,
      maxHeightFactor: 0.75,
    );
  }

  /// BLOCK CONFIRM
  static Future<void> showBlockConfirmSheet(
    BuildContext context, {
    required String authorName,
    required ImageProvider avatar,
    required VoidCallback onBlock,
  }) {
    return _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlockSheet(authorName: authorName, avatar: avatar, onBlock: onBlock),
        ],
      ),
      minHeight: 420.h,
      maxHeightFactor: 0.75,
    );
  }

  /// BLOCKED RESULT (Undo / Ok)
  static Future<void> showBlockedResultSheet(
    BuildContext context, {
    required String authorName,
    required ImageProvider avatar,
    VoidCallback? onUndo,
    VoidCallback? onOk,
  }) {
    return _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlockedResultSheet(
            authorName: authorName,
            avatar: avatar,
            onUndo: onUndo,
            onOk: onOk,
          ),
        ],
      ),
      minHeight: 360.h,
      maxHeightFactor: 0.60,
    );
  }

  /// REPORT REASONS
  static Future<void> showReportReasonsSheet(
    BuildContext context, {
    required VoidCallback onDone,
  }) {
    return _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [ReportSheet(onDone: onDone)],
      ),
      minHeight: 520.h,
      maxHeightFactor: 0.85,
    );
  }

  /// COMMENTS (cover + count header, list, input bar)
  static Future<void> showCommentsSheet(
    BuildContext context, {
    required String coverAssetOrUrl,
    int totalComments = 0,
  }) {
    return _showSheet(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [CommentsSheet(cover: coverAssetOrUrl, total: totalComments)],
      ),

      minHeight: 560.h,
      maxHeightFactor: 0.95,
    );
  }
}
