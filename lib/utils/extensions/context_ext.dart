import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

extension ContextExt on BuildContext {
  ThemeData get theme {
    return Theme.of(this);
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  double get height {
    return MediaQuery.of(this).size.height;
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }

  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }

  /// common text style
  TextStyle get bodySmall => textTheme.bodySmall!;
  TextStyle get body10 => textTheme.bodySmall!.copyWith(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    fontFamily: FontConstant.bricolage,
      height: 1.2,
  );
  TextStyle get body12 => textTheme.bodySmall!.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: FontConstant.bricolage,
      height: 1.2,
  );
  TextStyle get body12Bold => textTheme.bodySmall!.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: const Color(AppColors.primaryTextColor),
    fontFamily: FontConstant.bricolage,
    height: 1.2,
  );
  TextStyle get body14 => textTheme.bodyMedium!.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: FontConstant.bricolage,
      height: 1.2,
  );
  TextStyle get body14DarkLight => textTheme.bodyMedium!.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: const Color(AppColors.black),
    fontFamily: FontConstant.bricolage,
      height: 1.2,
  );
  TextStyle get body14ExtraLight => textTheme.bodyMedium!.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
    fontFamily: FontConstant.bricolage,
     color: Color(AppColors.textColor2),
       height: 1.2,
  );
  TextStyle get body14Light => textTheme.bodyMedium!.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: FontConstant.bricolage,
     color: Color(AppColors.textColor2),
       height: 1.2,
  );
  TextStyle get body14Bold => textTheme.bodyMedium!.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: const Color(AppColors.primaryTextColor),
    fontFamily: FontConstant.bricolage,
  );
  TextStyle get body16Light => textTheme.bodyMedium!.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: FontConstant.bricolage,
    color: Color(AppColors.textColor2),
      height: 1.2,
  );
  TextStyle get body16 => textTheme.bodyLarge!.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    fontFamily: FontConstant.bricolage,
      height: 1.2,
  );
  TextStyle get body16Bold => textTheme.bodyLarge!.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    fontFamily: FontConstant.bricolage,
    color: const Color(AppColors.primaryTextColor),
      height: 1.2,
  );
  TextStyle get bodySmall18 => textTheme.bodyLarge!.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: FontConstant.bricolage,
      height: 1.2,
  );

  TextStyle get title32 => textTheme.displayLarge!.copyWith(
    fontSize: 32.sp,
    fontFamily: FontConstant.bricolage,
    color: const Color(AppColors.primaryTextColor),
    fontWeight: FontWeight.w700,
    height: 1.5,
  );
  TextStyle get title24 => textTheme.displayLarge!.copyWith(
    fontSize: 24.sp,
    fontFamily: FontConstant.bricolage,
    color: const Color(AppColors.primaryTextColor),
    fontWeight: FontWeight.w600,
    height: 1.5,
  );
  TextStyle get title24Bold => textTheme.displayLarge!.copyWith(
    fontSize: 24.sp,
    fontFamily: FontConstant.bricolage,
    color: const Color(AppColors.primaryTextColor),
    fontWeight: FontWeight.w700,
    height: 1.5,
  );
   
  TextStyle get title20 => textTheme.displayLarge!.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    fontFamily: FontConstant.bricolage,
    color: const Color(AppColors.primaryTextColor),
    height: 1.5,
  );

  /// on current route name with go router
  // static String get currentRoute {
  //   final RouteMatch lastMatch =
  //       AppRouter.router.routerDelegate.currentConfiguration.last;
  //   final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
  //       ? lastMatch.matches
  //       : AppRouter.router.routerDelegate.currentConfiguration;
  //   final String location = matchList.uri.toString();
  //   return location;
  // }

  // String get routeName {
  //   return ModalRoute.of(this)!.settings.name!;
  // }

  /// show snack bar with a retry button and message
  void showSnackBar({
    required String message,
    Color? backgroundColor,
    Function()? onPressed,
    String? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? Colors.red,
        duration: const Duration(seconds: 2),
        content: Text(message, style: bodySmall.copyWith(color: Colors.white)),
        action: SnackBarAction(
          label: action ?? '',
          onPressed: onPressed ?? () {},
          textColor: Colors.white,
        ),
      ),
    );
  }
}
