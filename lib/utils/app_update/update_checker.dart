import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/utils/theme/theme.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateChecker {
  static void checkForUpdate(BuildContext context) async {
    try {
      const appleId =
          '1234567890'; // If this value is null, its packagename will be considered
      const playStoreId =
          'com.lykluk.app'; // If this value is null, its packagename will be considered
      const country =
          'uk'; // If this value is null 'us' will be the default value

      final newVersionPlus = NewVersionPlus(
        androidId: playStoreId,
        androidPlayStoreCountry: country,
        iOSId: appleId,
        iOSAppStoreCountry: country,
      );
      final status = await newVersionPlus.getVersionStatus();
      debugPrint('version  1${status?.storeVersion ?? ''}');
      debugPrint('version 2 ${status?.localVersion ?? ''}');

      if (status != null && status.canUpdate) {
        String appStoreLink = status.appStoreLink;
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return SimpleDialog(
                  backgroundColor: Colors.transparent,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/update_image.png',
                            package: 'lykluk',
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                const Row(),
                                AppText(
                                  text: 'New Update Available!',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16.h),
                                AppText(
                                  text:
                                      'Subtrust has been updated with new features, kindly click the button below to update your app and start enjoying the new features.',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20.h),
                                GestureDetector(
                                  onTap: () async {
                                    debugPrint(appStoreLink);
                                    if (await canLaunchUrl(
                                      Uri.parse(appStoreLink),
                                    )) {
                                      await launchUrl(
                                        Uri.parse(appStoreLink),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    } else {}
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 166,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(
                                            AppColors.primaryColor,
                                          ).withValues(alpha: .5),
                                          const Color(AppColors.primaryColor),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'UPDATE NOW!',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      }
    } on SocketException {
      log.d('unable check for update, internet not available');
    } on TimeoutException {
      log.d('unable check for update, service timeout');
    } catch (e, s) {
      LoggerService.logError(error: e, stackTrace: s);
    }
  }
}
