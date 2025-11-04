import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/model/store_model.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/product_notifier.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/store_notifier.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/providers/stores_provider.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/state/product_state.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';

import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../utils/helpers/choose_photo.dart';
import '../../../domain/enums/product_enums.dart';
import '../../../model/category_model.dart';
import '../../view_model/providers/categories_provider.dart';

class CreateProductPage extends HookConsumerWidget {
  // final int storeId;
  const CreateProductPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formkey = useMemoized(() => GlobalKey<FormState>());
    final selectedPhoto = useState<List<String>>([]);
    final curStore = ref.watch(currentStoreProvider);

    String? validate(String? v) {
      if (v!.isEmpty) {
        return "Please fill neccessary details ";
      }
      return null;
    }

    final selectedCategory = useState<CategoryModel?>(null);
    final nameController = useTextEditingController();
    final categoryController = TextEditingController(
      text: selectedCategory.value?.name,
    );
    final priceController = useTextEditingController();
    // final sellingPriceController = useTextEditingController();
    final currentStockController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final typeController = useTextEditingController();
    final selectStore = useState<StoreModel?>(curStore);

    ref.listen(productNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        createdProduct: (product, message) {
          // ref.read(navbarIndex.notifier).state = 4;
          // context.pushNamed(Routes.navBarRoute);
          context.pop();
        },
        createProductFailed: (message) {
          ToastNotification.alertError(message);
        },
      );
    });

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.colorScheme.surface,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            ExitButton(
              child: Icon(
                Icons.keyboard_backspace,
                color: context.colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 10.sH,
                Text('Create Product', style: context.title32),
                Text(
                  'Sell products on LykLuk Commerce.',
                  style: context.body16Light,
                ),
                20.sH,
                Text('Product images', style: context.body14Bold),
                10.sH,
                Row(
                  children: List.generate(2, (i) {
                    return Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: GestureDetector(
                        onTap: () async {
                          final res = await chooseImageBottomSheet(context);
                          if (res != null) {
                            /// insert the index and replace
                            selectedPhoto.value.replaceOrAddAt(i, res);
                            selectedPhoto.value = [...selectedPhoto.value];
                          }
                        },
                        child: DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            radius: Radius.circular(5.r),
                            color: context.colorScheme.primary,
                            strokeWidth: 1,
                            dashPattern: [10, 6],
                          ),

                          child: Container(
                            color: context.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            width: 70.w,
                            height: 70.h,
                            child:
                                selectedPhoto.value.isNotEmpty &&
                                        selectedPhoto.value.length > i
                                    ? Image.file(
                                      File(selectedPhoto.value[i]),
                                      fit: BoxFit.cover,
                                    )
                                    : Center(
                                      child: SvgPicture.asset(
                                        IconAssets.photoIconIcon,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                20.sH,
                AuthField(
                  controller: nameController,
                  label: 'Product name',
                  hint: 'Product name',
                  validator: validate,
                ),

                20.sH,
                AuthField(
                  controller: categoryController,
                  label: 'Category',
                  hint: 'Select category',
                  validator: validate,
                  readOnly: true,
                  suffix: Consumer(
                    builder: (_, WidgetRef ref, __) {
                      final categories =
                          ref.watch(categoriesProvider).valueOrNull ?? [];
                      return PopupMenuButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        iconSize: 20.w,
                        iconColor: context.colorScheme.inversePrimary,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                        ),
                        itemBuilder: (c) {
                          return categories
                              .map(
                                (e) => PopupMenuItem(
                                  value: e,
                                  onTap: () {
                                    selectedCategory.value = e;
                                  },
                                  child: Text(e.name, style: context.body14),
                                ),
                              )
                              .toList();
                        },
                      );
                    },
                  ),
                ),
                20.sH,
                AuthField(
                  readOnly: true,
                  controller: typeController,
                  label: "Product type",
                  hint: 'Select product type',
                  validator: validate,
                  suffix: PopupMenuButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    iconSize: 20.w,
                    iconColor: context.colorScheme.inversePrimary,
                    itemBuilder: (context) {
                      return ProductType.valuesList.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(
                            item.display.capitalize,
                            style: context.body14,
                          ),
                        );
                      }).toList();
                    },
                    onSelected: (value) {
                      typeController.text = value.display;
                    },
                  ),
                ),
                20.sH,
                AuthField(
                  fillColor: context.colorScheme.onSecondary.withValues(
                    alpha: 0.1,
                  ),
                  controller: useTextEditingController(
                    text: selectStore.value?.name ?? "",
                  ),

                  label: "Shop",
                  hint: selectStore.value?.name ?? "",
                  textCapitalization: TextCapitalization.sentences,
                  readOnly: true,
                  suffix: Consumer(
                    builder: (_, WidgetRef ref, __) {
                      final stores =
                          ref.watch(myStoresProvider).valueOrNull?.dataList ??
                          [];
                      return PopupMenuButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        iconSize: 20.w,
                        iconColor: context.colorScheme.inversePrimary,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                        ),
                        itemBuilder: (c) {
                          return stores
                              .map(
                                (e) => PopupMenuItem(
                                  value: e,
                                  onTap: () {
                                    selectStore.value = e;
                                  },
                                  child: Text(e.name, style: context.body14),
                                ),
                              )
                              .toList();
                        },
                      );
                    },
                  ),
                ),

                20.sH,
                AuthField(
                  controller: currentStockController,
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  label: "Current stock",
                  hint: 'Stock',
                  textCapitalization: TextCapitalization.sentences,
                  validator: validate,
                  suffix: Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    color: context.colorScheme.inversePrimary,
                  ),
                ),

                20.sH,
                AuthField(
                  controller: priceController,
                  label: "Unit price (\$)",
                  hint: 'Unit price (\$)',
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  validator: validate,
                ),
                20.sH,
                AuthField(
                  controller: descriptionController,
                  label: "Description",
                  hint: 'Description',
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,

                  validator: validate,
                ),

                20.sH,
                CustomButton(
                  isLoading:
                      ref.watch(productNotifierProvider) is CreatingProduct,
                  onTap: () {
                    if (selectedPhoto.value.isEmpty) {
                      ToastNotification.showSimpleNotification(
                        title: 'Please choose at least one image for your item',

                        isSuccess: false,
                      );
                      return;
                    }
                    if (formkey.currentState!.validate()) {
                      ref
                          .read(productNotifierProvider.notifier)
                          .createProduct(
                            images: selectedPhoto.value,
                            data: {
                              "name": nameController.text,
                              "description": descriptionController.text,
                              "price": double.tryParse(priceController.text),
                              "categoryId": selectedCategory.value?.id,
                              "type":
                                  ProductType.fromDisplay(
                                    typeController.text,
                                  ).value,
                              "inventory": int.parse(
                                currentStockController.text,
                              ),

                              "storeId": selectStore.value?.id,
                            },
                          );
                    }
                  },
                  buttonText: 'Submit',
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
