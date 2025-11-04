import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/posts/presentation/views/notifications/domain/notification_constants.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/bottom_sheet_wrapper.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/search_field.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/router/app_router.dart';
import 'package:lykluk/utils/theme/theme.dart';

class LocationSearchScreen extends HookConsumerWidget {
  const LocationSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState('');
    final items = const [
      '10 Downing Street, Westminster',
      'Admiralty Way, Lekki Phase 1',
      'Lekki-Epe Expressway, Ajah',
      'Allen Avenue, Ikeja',
      'Herbert Macaulay Way, Yaba',
      'Warehouse Road, Apapa',
      'Broad Street, Marina, Lagos Island',
    ];

    final filtered =
        items
            .where(
              (loc) => loc.toLowerCase().contains(query.value.toLowerCase()),
            )
            .toList();

    return BottomSheetWrapper(
      title: '',
      child: Container(
        decoration: BoxDecoration(color: Color(AppColors.buttonColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.verticalSpace,
            _HeaderBar(
              onBack: () {
                if (Navigator.of(context).canPop()) {
                  AppRouter.router.pop();
                }
              },
              onChanged: (val) => query.value = val,
            ),
            5.verticalSpace,
            ListTile(
              dense: true,
              leading: SvgPicture.asset(IconAssets.currentlocation),
              title: AppText(
                text: 'Current location',
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(AppColors.black),
              ),
              onTap: () => Navigator.pop(context, 'Current location'),
            ),
            5.verticalSpace,
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => Divider(height: 1.h, thickness: 0.5),
              itemBuilder:
                  (_, i) => ListTile(
                    dense: true,
                    leading: SvgPicture.asset(IconAssets.locationIcon),
                    title: AppText(
                      text: filtered[i],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(AppColors.black),
                    ),
                    onTap: () => Navigator.pop(context, filtered[i]),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  final VoidCallback onBack;
  final ValueChanged<String>? onChanged;
  const _HeaderBar({required this.onBack, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20.h,
        left: 16.w,
        right: 16.w,
        bottom: 12.h,
      ),
      child: Row(
        children: [
          // back pill
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 45.w,
              height: 45.w,
              decoration: ShapeDecoration(
                color: const Color(0xFFF3E9FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    NotificationConstants.avatarBorderRadius,
                  ),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Color(AppColors.primaryColor),
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: SearchField(
              hint: 'Search specific location',
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
