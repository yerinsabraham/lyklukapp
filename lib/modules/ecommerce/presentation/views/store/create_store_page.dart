import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/store_notifier.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import '../../../../../core/shared/providers/util_providers.dart';
import '../../../../../utils/router/app_router.dart';
import '../../../domain/enums/product_enums.dart';
import '../../view_model/state/shop_state.dart';
import '../../widgets/agreement_checker.dart';



class CreateStorePage extends HookConsumerWidget {
  const CreateStorePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formkey = useMemoized(() => GlobalKey<FormState>());
    final category = useState<ProductType?>(null);
    String? validate(String? v) {
      if (v!.isEmpty) {
        return "Please enter this field";
      }
      return null;
    }

    ref.listen(storeNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        storeCreated: (store, msg) {
          context.showSnackBar(message: msg, backgroundColor: Colors.green);
          context.pushNamed(Routes.verifyStoreRoute, extra: store.id);
        },
        storeCreationFailed: (message) {
          context.showSnackBar(
            message: message,
            backgroundColor: Colors.red,
            action: "Retry",
            onPressed: () {},
          );
        },
      );
    });

    /// controllers
    final nameController = useTextEditingController();
    final countryController = useTextEditingController();
    final regionController = useTextEditingController();
    final addressController = useTextEditingController();
    final descriptionController = useTextEditingController();
    // final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final countryVlaue = useState<Country?>(null);
    final iAgree = useState(false);
    final code = useState<String?>(null);

    void onPickCategory() {
      countryController.text = category.value?.display ?? "";
    }

    useEffect(() {
      category.addListener(onPickCategory);
      countryVlaue.addListener(() {
        if (countryVlaue.value == null) return;
        ref.invalidate(
          statesProvider(countryVlaue.value!.countryCode.toUpperCase()),
        );
      });
      return () {
        category.removeListener(onPickCategory);
      };
    });

    ////////
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: context.colorScheme.surface,
        surfaceTintColor: context.colorScheme.surface,
        shadowColor: context.colorScheme.surface,
        title: Row(children: [ExitButton()]),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Chip(
              side: BorderSide.none,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              label: Text(
                'Step 1/4',
                style: context.body12.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: context.colorScheme.primary.withValues(
                alpha: .2,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.sH,
                Text('Create Shop', style: context.title32),
                Text(
                  'Sell items on LykLuk Commerce.',
                  style: context.body16Light,
                ),
                40.sH,
                AuthField(
                  label: 'Name of shop',
                  hint: 'Shop name',
                  textCapitalization: TextCapitalization.sentences,
                  controller: nameController,
                  validator: validate,
                ),

                20.sH,
                AuthField(
                  label: 'Shop country',
                  hint: 'Select country',
                  readOnly: true,
                  textCapitalization: TextCapitalization.sentences,
                  controller: countryController,
                  validator: validate,
                  preffix: countryVlaue.value == null
                          ? null
                          : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  Text(
                      countryVlaue.value?.flagEmoji ?? "",
                      style: context.title32,
                    ),
                  ),

                  suffix: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,

                        onSelect: (Country country) {
                          countryController.text = country.name;
                          countryVlaue.value = country;
                        },
                      );
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: context.colorScheme.inversePrimary,
                    ),
                  ),
                ),
                20.sH,
                // if (countryVlaue.value != null)
                HookConsumer(
                  builder: (_, WidgetRef ref, __) {
                    final ss =
                        ref
                            .watch(
                              statesProvider(
                                countryVlaue.value?.countryCode ?? "",
                              ),
                            )
                            .valueOrNull;
                    return AuthField(
                      readOnly: true,
                      controller: regionController,
                      label: 'Region/state',
                      hint: 'Select',
                      textCapitalization: TextCapitalization.sentences,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Please select state ";
                        }
                        return null;
                      },
                      suffix: PopupMenuButton(
                        itemBuilder: (context) {
                          // debugPrint(ss.toString());
                          if (ss == null) return [];
                          return List.generate(ss.length, (i) {
                            final e = ss[i];
                            return PopupMenuItem(
                              value: e.name,
                              child: Text(e.name, style: context.body14),
                              onTap: () {
                                regionController.text = e.name;
                              },
                            );
                          });
                        },
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: context.colorScheme.inversePrimary,
                        ),
                      ),
                    );
                  },
                ),

                // AuthField(
                20.sH,
                AuthField(
                  label: 'Street address',
                  hint: 'Street address',
                  textCapitalization: TextCapitalization.sentences,
                  controller: addressController,
                  validator: validate,
                ),
                20.sH,
                AuthField(
                  label: 'Shop description',
                  hint: 'Shop description',
                  textCapitalization: TextCapitalization.sentences,
                  controller: descriptionController,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,

                  // validator: validate,
                ),

                
                20.sH,
                AgreementChecker(iAgree: iAgree),

                20.sH,
                CustomButton(
                  isLoading: ref.watch(storeNotifierProvider) is StoreCreating,
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                        //  context.pushNamed(Routes.verifyStoreRoute);
                      final data = {
                        'name': nameController.text,
                        'country': countryController.text,
                        "region": regionController.text,
                        'address': addressController.text,
                        // 'location': addressController.text,
                        'description': descriptionController.text,
                        // "contactPhone": phoneController.text.trim(),
                        // "contactEmail": emailController.text.trim(),
                      };
                      ref
                          .read(storeNotifierProvider.notifier)
                          .createStore(data: data);
                    }
                  },
                  buttonText: "Continue",
                ),

                40.sH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
