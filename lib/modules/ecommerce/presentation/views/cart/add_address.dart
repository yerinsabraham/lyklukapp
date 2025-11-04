import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/model/address_model.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/addresses_provider.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';

class AddAddressPage extends HookConsumerWidget {
  final AddressModel? address;
  const AddAddressPage({super.key, this.address});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstnamecontroller = useTextEditingController(
      text: address?.firstName,
    );
    final lastnamecontroller = useTextEditingController(
      text: address?.lastName,
    );
    final phonecontroller = useTextEditingController(
      text: address?.phoneNumber,
    );
    final addresscontroller = useTextEditingController(text: address?.address);
    final citycontroller = useTextEditingController(text: address?.city);
    final statecontroller = useTextEditingController(text: address?.state);
    final isdefault = useState(address?.isDefault ?? false);
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
          'Add new address',
          style: context.title24.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.sH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: context.width * 0.43,
                  child: AuthField(
                    label: 'First name',
                    hint: 'First name',
                    controller: firstnamecontroller,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'First name is required';
                      }
                      return null;
                    },
                    maxLines: 1,

                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                10.sW,
                SizedBox(
                  width: context.width * 0.43,
                  child: AuthField(
                    label: 'Last name',
                    hint: 'Last name',
                    controller: lastnamecontroller,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Last name is required';
                      }
                      return null;
                    },
                    maxLines: 1,

                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
              ],
            ),
            20.sH,
            AuthField(
              label: 'Phone number',
              // hint: '+234',
              controller: phonecontroller,
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return 'phone number is required';
                }
                if (value.length != 10) {
                  return 'phone number should be 10 digits';
                }
                return null;
              },
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
              preffix: CountryCodePicker(
                textStyle: context.body14,
                onChanged: print,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'NG',
                favorite: ['+234', 'NG'],
                // optional. Shows only country name and flag
                showCountryOnly: true,
                // optional. Shows only country name and flag when popup is closed.
                showOnlyCountryWhenClosed: false,
                // optional. aligns the flag and the Text left
                alignLeft: false,
              ),
            ),
            20.sH,
            AuthField(
              label: 'Delivery Address',

              hint: 'Address',
              controller: addresscontroller,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Address is required';
                }
                return null;
              },
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
            ),
            20.sH,

            AuthField(
              label: 'Region/State',
              hint: 'Select',
              controller: statecontroller,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return 'State is required';
                }
                return null;
              },
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
              // suffix: Icon(
              //   Icons.keyboard_arrow_down,
              //   size: 20.r,
              //   color: Colors.black,
              // ),
            ),
            20.sH,
            AuthField(
              label: 'City',
              hint: 'Select',
              controller: citycontroller,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return 'City is required';
                }
                return null;
              },
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
              // suffix: Icon(
              //   Icons.keyboard_arrow_down,
              //   size: 20.r,
              //   color: Colors.black,
              // ),
            ),

            20.sH,
            CheckboxListTile(
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: isdefault.value,
              onChanged: (v) {
                isdefault.value = v!;
              },
              title: Text('Set as default address', style: context.body14),
            ),
            20.sH,
            Visibility(
              visible: address == null,
              replacement: CustomButton(
                onTap: () {
                  debugPrint('edit');
                  final newAddress = address?.copyWith(
                    address: addresscontroller.text,
                    city: citycontroller.text,
                    state: statecontroller.text,
                    firstName: firstnamecontroller.text,
                    lastName: lastnamecontroller.text,
                    phoneNumber: phonecontroller.text,
                    isDefault: isdefault.value,
                  );
                  if(address!= null){
                  ref.read(addressesProvider.notifier).updateAddress(newAddress!);
                  }
                  Navigator.pop(context);
                },
                buttonText: "Edit",
              ),
              child: CustomButton(
                onTap: () {
                  debugPrint('save');
                  final address = AddressModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    address: addresscontroller.text,
                    city: citycontroller.text,
                    state: statecontroller.text,
                    firstName: firstnamecontroller.text,
                    lastName: lastnamecontroller.text,
                    phoneNumber: phonecontroller.text,
                    isDefault: isdefault.value,
                  );
                   ref.read(addressesProvider.notifier).add(address);
                  Navigator.pop(context);
                },
                buttonText: "Save",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
