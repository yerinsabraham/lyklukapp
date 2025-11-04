import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/core/shared/widgets/show_sheet.dart';
import 'package:lykluk/modules/ecommerce/domain/enums/document_type.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/notifers/store_notifier.dart';
import 'package:lykluk/modules/ecommerce/presentation/view_model/state/store_state.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/choose_photo.dart';
import 'package:lykluk/utils/helpers/toast_notification.dart';
import 'package:lykluk/utils/theme/theme.dart';

import '../../../../../utils/router/app_router.dart';

class VerifyStorePage extends HookConsumerWidget {
  final int storeId;
  const VerifyStorePage({super.key, required this.storeId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formkey = useMemoized(() => GlobalKey<FormState>());

    String? validate(String? v) {
      if (v!.isEmpty) {
        return "Please enter this field";
      }
      return null;
    }

    ref.listen(storeNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        storeIndentityVerified: (msg) {
          // ToastNotification.alertSuccess(msg);
          showSheet(
            context,
            showHandle: false,
            maxHeight: context.height * 0.5,
            child: VerifyWidget(storeId: storeId),
          );
        },
        storeVerificationIndentityFailed: (message) {
           ToastNotification.alertError(message);
          // context.showSnackBar(
          //   message: message,
          //   backgroundColor: Colors.red,
          //   action: "Retry",
          //   onPressed: () {},
          // );
        },
      );
    });

    /// controllers
    final typeController = useTextEditingController();
    final idController = useTextEditingController();
    final expiryDateController = useTextEditingController();
    final document = useState<String?>(null);
    final expiry = useState<DateTime?>(null);
    final documentType = useState<DocumentType?>(null);

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
                'Step 2/4',
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
                // 20.sH,
                Text('Verify Identity', style: context.title32),
                Text(
                  'We verify all store owners to maintain trust in our marketplace. This is a one-time process.',
                  style: context.body14Light,
                ),
                20.sH,
                AuthFieldWithDropDown(
                  readOnly: true,
                  // items: ["NIN", "Passport", "Driver’s License", "Voter ID"],
                  items: DocumentType.values,
                  onSelectedItemChanged: (v) {
                    typeController.text = v.label;
                    documentType.value = v;
                  },
                  label: 'Document Type',
                  hint: 'NIN',
                  textCapitalization: TextCapitalization.sentences,
                  controller: typeController,
                  validator: validate,
                ),

                20.sH,
                AuthField(
                  label: 'Document ID Number',
                  hint: 'Document ID Number',
                  textCapitalization: TextCapitalization.sentences,
                  controller: idController,
                  validator: validate,
                ),

                // AuthField(
                20.sH,
                AuthFieldDatePicker(
                  readOnly: true,
                  label: 'Expiry Date',
                  hint: 'Expiry Date',
                  textCapitalization: TextCapitalization.sentences,
                  controller: expiryDateController,
                  onSelectedItemChanged: (v) {
                    expiryDateController.text = v.date;
                    expiry.value = v;
                  },
                  // validator: validate,
                ),
                20.sH,
                Text(
                  'Upload ID',
                  style: context.body14.copyWith(
                    color: context.colorScheme.inversePrimary,
                  ),
                ),
                StoreDocUploader(
                  onDocumentSelected: (v) {
                    document.value = v;
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    IconAssets.warning2Icon,
                    // ignore: deprecated_member_use
                    color: Color(AppColors.warning2Color),
                  ),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  title: Text(
                    'Document must be original full size, unedited, readable and still valid',
                    style: context.body12.copyWith(
                      color: Color(AppColors.warning2Color),
                    ),
                  ),
                ),
                20.sH,
                CustomButton(
                  isLoading:
                      ref.watch(storeNotifierProvider)
                          is StoreIdentityVerifying,
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                    
                      final data = {
                        "storeId": storeId,
                        "documentType": documentType.value!.value,
                        "documentNumber": idController.text,
                        "expiryDate": expiry.value?.datedash,
                        "documentFileId": document.value,
                      };
                      ref
                          .read(storeNotifierProvider.notifier)
                          .verifyStoreIndentity(data: data);
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

class StoreDocUploader extends HookConsumerWidget {
  const StoreDocUploader({super.key, this.onDocumentSelected});

  final Function(String)? onDocumentSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final document = useState<File?>(null);
    final urlValue = useState<String?>(null);
    ref.listen(storeNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        storeDocUploading: (v){
          urlValue.value=null;
        },
        storeDocUploaded: (msg, url) {
          urlValue.value = url;
          onDocumentSelected?.call(url);
        },
      );
    });
    // useEffect(() {
    //   urlValue.addListener(() {
    //     if (urlValue.value == null) return;
    //     // WidgetsBinding.instance.addPostFrameCallback((_) {
    //     onDocumentSelected?.call(urlValue.value!);
    //   });
    //   return () {};
    // }, [urlValue.value]);

    final uploadState = ref.watch(storeNotifierProvider);
    return GestureDetector(
      onTap: () async {
        final res = await chooseFileBottomSheet(context);
        if (res != null) {
          document.value = File(res);

          /// upload to server
          ref.read(storeNotifierProvider.notifier).storeDocUpload(File(res));
        }
      },
      child: FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (v) {
          if (urlValue.value == null) {
            return "Please upload a document";
          }
          // if (document.value == null) {
          //   return "Please upload a document";
          // }
          return null;
        },
        builder: (formstate) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: SizedBox(
              height: 170.h,
              width: double.infinity,
              child: DottedBorder(
                options: RectDottedBorderOptions(
                  dashPattern: [4, 9],
                  strokeWidth: formstate.hasError ? 5 : 2,

                  color:
                      formstate.hasError
                          ? context.colorScheme.error
                          : context.colorScheme.primary,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 14.0,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: .04),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: uploadState.maybeWhen(
                    storeDocUploading: (progress) {
                    
                      return Center(
                        child: Slider(
                          onChanged: (v) {},
                          value: progress,
                          min: 0.0,
                          max: 100,
                          activeColor: context.colorScheme.primary,
                          inactiveColor: context.colorScheme.secondary,
                        ),
                       
                      );
                    },
                    storeDocUploaded: (msg, url) {
                      onDocumentSelected?.call(url);
                      // urlValue.value = url;
                      return Center(
                        child: Text(
                          "${document.value!.fileName} uploaded ✅",
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                    storeDocuUploadFailed: (message) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: context.body14.copyWith(
                              color: context.colorScheme.error,
                            ),
                          ),
                          5.sH,
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(storeNotifierProvider.notifier)
                                  .storeDocUpload(document.value!);
                            },
                            icon: Icon(
                              CupertinoIcons.refresh,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ],
                      );
                    },
                    orElse: () {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          document.value != null
                              ? Text(
                                "${document.value!.fileName} ${document.value!.size}",
                                style: context.body14,
                              )
                              : SvgPicture.asset(IconAssets.scanCardIcon),
                          5.sH,
                          Text(
                            'Tap here to upload',
                            style: context.body14.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                          Text(
                            'Images must not be less than 500px X 500px',
                            style: context.body10.copyWith(
                              color: context.colorScheme.primary.withValues(
                                alpha: .5,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class VerifyWidget extends StatelessWidget {
  final int storeId;
  const VerifyWidget({required this.storeId, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 8.sH,
          Center(
            child: Container(
              width: 150.w,
              height: 3.h,
              color: context.colorScheme.onSecondary.withValues(alpha: 0.4),
            ),
          ),
          20.sH,
          SvgPicture.asset(IconAssets.timerFrameIcon),
          30.sH,
          Text(
            'We are verifying your store',
            style: context.title24.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "We are reviewing your information to ensure everything is in order. This usually takes 24-48 hours. We'll notify you via email once your store is approved and ready to go live.",
            style: context.body16Light.copyWith(
              color: context.colorScheme.inversePrimary,
            ),
            textAlign: TextAlign.center,
          ),
          20.sH,
          CustomElevatedButton(
            width: context.width * 0.7,
            color: context.colorScheme.onSecondary.withValues(alpha: 0.03),
            onTap: () {
              context.pop();
              context.pushNamed(
                Routes.setupStoreLogisticsRoute,
                extra: storeId,
              );
            },
            buttonText: "Got it",
            textColor: context.colorScheme.inversePrimary,
          ),
        ],
      ),
    );
  }
}
