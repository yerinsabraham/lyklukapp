import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/model/address_model.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/addresses_provider.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../utils/router/app_router.dart';

class SelectAddressPage extends HookConsumerWidget {
  const SelectAddressPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAddress = useState<AddressModel?>(null);
    // final addressList = useState<List<AddressModel>>([]);
    final asyncItems = ref.watch(addressesProvider);
    return Scaffold(
      appBar: CustomTileAppbar(
        backgroundColor: context.colorScheme.surface,
        leadingWidget: ExitButton(
          color: context.colorScheme.onSecondary.withValues(alpha: 0.08),
          size: 32.r,
          child: Icon(
            Icons.keyboard_backspace,
            size: 20.r,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Select delivery address',
          style: context.title24.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          asyncItems.when(
            loading: () => Center(child: LoadingWithText()),
            error: (err, stack) {
              return Center(
                child: AppErrorWidget(
                  errorText: err.toString(),
                  asyncValue: asyncItems,
                  onRetry: () {
                    ref.invalidate(addressesProvider);
                  },
                ),
              );
            },
            data: (data) {
              if (data.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 70.0,
                    horizontal: 20.w,
                  ),
                  child: Text(
                    'No saved address found. Add a new address to continue.',
                    style: context.body14Bold,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Expanded(
                child: ListView.separated(
                  // shrinkWrap: true,
                  separatorBuilder: (context, index) => 10.sH,
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (c, i) {
                    final loc = data[i];
                    return AddressTile(
                      address: loc,
                      selectedAddress: selectedAddress.value,
                      onTap: (v) {
                        selectedAddress.value = v;
                      },
                    );
                  },
                ),
              );
            },
          ),

          30.sH,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onTap: () {
                      if (selectedAddress.value != null) {
                        Navigator.pop(context, selectedAddress.value);
                      }
                    },
                    buttonText: 'Select address',
                  ),
                ),
                10.sW,
                CustomElevatedButton(
                  onTap: () async {
                   context.pushNamed(Routes.addAddressRoute);

                    // if (res != null) {
                    //   ref.read(addressesProvider.notifier).add(res);
                    //   // addressList.value.add(res);
                    //   // addressList.value = [...addressList.value];
                    // }
                  },
                  textColor: context.colorScheme.inversePrimary,
                  buttonText: '+',
                  textSize: 40.sp,
                  color: context.colorScheme.surface,
                  borderColor: context.colorScheme.onSecondary.withValues(
                    alpha: 0.2,
                  ),
                ),
              ],
            ),
          ),
          60.sH,
        ],
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final AddressModel address;
  final AddressModel? selectedAddress;
  final void Function(AddressModel) onTap;
  const AddressTile({
    super.key,
    required this.address,
    required this.onTap,
    this.selectedAddress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call(address);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(color: context.colorScheme.surface),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomRadio(
                  groupValue: selectedAddress,
                  onTap: (v) {
                    onTap.call(v!);
                  },
                  value: address,
                ),
                10.sW,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${address.firstName} ${address.lastName}".capitalize,
                      style: context.body14.copyWith(
                        color: context.colorScheme.inversePrimary,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        3.sH,
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 200.w),
                          child: Text(
                            // '45B Whitesand beach estate, Orchid street, Lekki-Ajah, Lagos',
                            address.address,
                            style: context.body10,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(left: 40.w),

              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(address.phoneNumber, style: context.body10),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.addAddressRoute, extra: address);
                    },
                    child: SvgPicture.asset(IconAssets.editPenIcon),
                  ),

                  // Icon(
                  //   Icons.edit,
                  //   size: 18.r,
                  //   color: context.colorScheme.primary,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
