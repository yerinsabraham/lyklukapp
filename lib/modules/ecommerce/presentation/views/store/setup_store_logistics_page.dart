import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/app_error_widget.dart';
import 'package:lykluk/core/shared/widgets/custom_button.dart';
import 'package:lykluk/core/shared/widgets/exit_button.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/store_notifier.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/available_carriers_provider.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/state/store_state.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';
import 'package:lykluk/utils/router/app_router.dart';

class SetupLogisticsPage extends HookConsumerWidget {
  final int max;
  final int storeId;
  const SetupLogisticsPage({super.key, this.max = 1,   required this.storeId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(availableCarriersProvider);

    final selectedCarriers = useState<List<String>>([]);

    ref.listen(storeNotifierProvider, (prev, next) {
      next.maybeWhen(
        orElse: () {},
        settingCarriersSuccess: (msg, data) {
          context.pushNamed(Routes.storeSubscriptionRoute, extra: storeId);
        },
        settingCarriersFailed: (message) {
          ToastNotification.alertError(message);
        },
      );
    });
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(children: [ExitButton()]),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Chip(
              side: BorderSide.none,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              label: Text(
                'Step 3/4',
                style: context.body16.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              backgroundColor: context.colorScheme.primary.withValues(
                alpha: .2,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.sH,
          Center(child: Text('Setup Logistics', style: context.title32)),
          Center(
            child: Text(
              'Select preferred third party \nlogistics company',
              textAlign: TextAlign.center,
              style: context.body16Light,
            ),
          ),
          20.sH,

          asyncItem.when(
            loading: () => Center(child: CircularProgressIndicator()),
            error:
                (error, stackTrace) => Center(
                  child: AppErrorWidget(
                    errorText: error.toString(),
                    asyncValue: asyncItem,
                    onRetry: () {
                      ref.invalidate(availableCarriersProvider);
                    },
                  ),
                ),
            data: (data) {
              return Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 10.w,
                runSpacing: 30.h,
                children: List.generate(data.length, (i) {
                  final selected = selectedCarriers.value.contains(
                    data[i].serviceCode,
                  );
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatarButton(
                        path: data[i].pinImage ?? "",
                        // isSelected: selected.value == i,
                        isSelected: selected,
                        value: i,
                        onSelected: (v) {
                          if (selected) {
                            selectedCarriers.value.remove(data[i].serviceCode);
                          } else {
                            if (selectedCarriers.value.length >= max) {
                              ToastNotification.showCustomNotification(
                                subtitle:
                                    "You have removed maximun number of carriers",
                                title: "Carrier limit reached",
                                isSuccess: false,
                              );
                            } else {
                              selectedCarriers.value.add(
                                data[i].serviceCode ?? "",
                              );
                            }
                          }
                          selectedCarriers.value = [...selectedCarriers.value];
                        },
                      ),
                      5.sH,
                      Text(
                        data[i].name ?? "",
                        style: context.body16.copyWith(
                          color: context.colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
          ),
          Spacer(flex: 3),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomButton(
              isLoading: ref.watch(storeNotifierProvider) is SettingCarriers,
              isDisable: selectedCarriers.value.isEmpty,
              onTap: () {
                ref
                    .read(storeNotifierProvider.notifier)
                    .setCarriers(carrierCodes: selectedCarriers.value, storeId: storeId);
              },
              buttonText: "Continue",
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

// const _logistics = [
//   ImageAssets.absLogisticsImage,
//   ImageAssets.boltImage,
//   ImageAssets.kiwkLogisticsImage,
//   ImageAssets.gigLogisticsImage,
//   ImageAssets.dhlLogisticsImage,
//   ImageAssets.upsLogisticsImage,
//   ImageAssets.sltLogisticsImage,
// ];

class CircleAvatarButton<T> extends StatelessWidget {
  final String path;
  final Function(T)? onSelected;
  final bool isSelected;
  final T value;
  const CircleAvatarButton({
    super.key,
    required this.path,
    this.onSelected,
    required this.isSelected,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected?.call(value);
      },
      child: Badge(
        offset: Offset(-20, 10),
        backgroundColor: Colors.transparent,
        label: CircleAvatar(
          radius: 15.r,
          backgroundColor: context.colorScheme.primary,
          child: Center(
            child: Icon(Icons.check, size: 20.r, color: Colors.white),
          ),
        ),
        // label: Icon(Icons.verified_outlined, size: 20.r, color:context.colorScheme.primary),
        // label: SvgPicture.asset(
        //   IconAssets.greenCheckIcon,
        //   height: 40.h,
        //   width: 40.w,

        // ),
        isLabelVisible: isSelected,
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border:
                isSelected
                    ? Border.all(color: context.colorScheme.primary, width: 2)
                    : null,
          ),
          // child: CircleAvatar(radius: 40.r, backgroundImage: AssetImage(path)),
          child: CircleAvatar(
            radius: 30.r,
            backgroundImage: NetworkImage(path),
          ),
        ),
      ),
    );
  }
}


  // Wrap(
  //               alignment: WrapAlignment.spaceBetween,
  //               spacing: 10.w,
  //               runSpacing: 30.h,
  //               children: List.generate(_logistics.length, (i) {
  //                 return CircleAvatarButton(
  //                   path: _logistics[i],
  //                   isSelected: selected.value == i,
  //                   value: i,
  //                   onSelected: (v) {
  //                     selected.value = v;
  //                   },
  //                 );
  //               }),
  //             ),