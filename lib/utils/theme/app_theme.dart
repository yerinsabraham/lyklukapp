// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class AppExtension extends ThemeExtension<AppExtension> {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color? onBoardingColor;
  final TextTheme textTheme;
  final Color textColor;
  final InputBorder? inputBorder;
  final Color primaryButtonColor;
  final Color? errorColor;
  final ElevatedButtonTheme? elevatedButtonTheme;
  final ButtonStyle? buttonStyle;
  final InputDecorationTheme? inputDecorationTheme;

  AppExtension({
    required this.primary,
    required this.secondary,
    required this.background,
    this.onBoardingColor,
    required this.textTheme,
    required this.inputBorder,
    required this.textColor,
    this.errorColor = Colors.red,
    required this.elevatedButtonTheme,
    required this.primaryButtonColor,
    this.buttonStyle,
    this.inputDecorationTheme,
  });

  @override
  ThemeExtension<AppExtension> copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? onBoardingColor,
    TextTheme? textTheme,
    InputBorder? inputBorder,
    Color? errorCOlor,
    ElevatedButtonTheme? elevatedButtonTheme,
    Color? textColor,
    Color? primaryButtonColor,
  }) {
    return AppExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      onBoardingColor: onBoardingColor ?? const Color(0xFF020144),
      inputBorder: inputBorder ?? InputBorder.none,
      errorColor: errorColor ?? Colors.red,
      elevatedButtonTheme: elevatedButtonTheme ?? this.elevatedButtonTheme,
      textColor: textColor ?? this.textColor,
      textTheme: textTheme ?? this.textTheme,
      inputDecorationTheme: inputDecorationTheme,
      primaryButtonColor: primaryButtonColor ?? this.primaryButtonColor,
    );
  }

  @override
  ThemeExtension<AppExtension> lerp(
    covariant ThemeExtension<AppExtension>? other,
    double t,
  ) {
    if (other is! AppExtension) {
      return this;
    } else {
      return AppExtension(
        primary: Color.lerp(primary, other.primary, t)!,
        secondary: Color.lerp(secondary, other.secondary, t)!,
        background: Color.lerp(background, other.background, t)!,
        onBoardingColor: Color.lerp(onBoardingColor, other.onBoardingColor, t),
        textTheme: TextTheme.lerp(textTheme, other.textTheme, t),
        errorColor: Color.lerp(errorColor, other.errorColor, t),
        textColor: Color.lerp(textColor, other.textColor, t)!,
        elevatedButtonTheme: null,
        inputBorder: null,
        inputDecorationTheme: null,
        primaryButtonColor:
            Color.lerp(primaryButtonColor, other.primaryButtonColor, t)!,
      );
    }
  }
}

class AppTheme {
  static ThemeData light() => ThemeData(
    
    useMaterial3: true,
    fontFamily: FontConstant.bricolage,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    shadowColor: const Color(AppColors.greyColor),
    scaffoldBackgroundColor: const Color(AppColors.backgroundColor),
    cardColor: const Color(AppColors.backgroundColor),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(AppColors.buttonColor),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: const Color(AppColors.backgroundColor),
      surfaceTintColor: const Color(AppColors.backgroundColor),
      backgroundColor: const Color(AppColors.backgroundColor),
    ),
    radioTheme: RadioThemeData(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(AppColors.buttonColor);
        } else {
          return const Color.fromARGB(255, 0, 0, 0);
        }
      }),
    ),
    // typography: Typography.material2021(black: const TextTheme()),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: const BorderSide(
          width: 1,
          color: Color(AppColors.lightGreyColor),
        ),
      ),
      labelStyle: TextStyle(
        fontFamily: FontConstant.bricolage,
        fontWeight: FontWeight.w600,
        color: Color(AppColors.primaryTextColor),
      ),
    ),
    listTileTheme: ListTileThemeData(contentPadding: EdgeInsets.zero),
    iconTheme: const IconThemeData(color: Colors.black),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        shadowColor: const Color(AppColors.greyColor),
        backgroundColor: const Color(AppColors.backgroundColor),
        surfaceTintColor: const Color(AppColors.backgroundColor),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: TextStyle(
        color: const Color(AppColors.errorColor),
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        fontFamily: FontConstant.bricolage,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(
          color: const Color(AppColors.lightGreyColor),
          width: 0.5.h,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          color: const Color(AppColors.buttonColor),
          width: 0.5.h,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          color: const Color(AppColors.buttonColor),
          width: 0.5.h,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          color: const Color(AppColors.lightGreyColor),
          width: 0.5.h,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          color: const Color(AppColors.errorColor),
          width: 0.5.h,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          color: const Color(AppColors.lightGreyColor),
          width: 0.5.h,
        ),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: const Color(AppColors.primaryTextColor),
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        fontFamily: FontConstant.bricolage,
      ),
      titleLarge: TextStyle(
        color: const Color(AppColors.primaryTextColor),
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        fontFamily: FontConstant.bricolage,
      ),
      bodyLarge: TextStyle(
        color: const Color(AppColors.primaryTextColor),
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        fontFamily: FontConstant.bricolage,
      ),
      bodyMedium: TextStyle(
        color: const Color(AppColors.secondaryTextColor),
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        fontFamily: FontConstant.bricolage,
      ),
      bodySmall: TextStyle(
        color: const Color(AppColors.secondaryTextColor),
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontConstant.bricolage,
      ),
      labelSmall: TextStyle(
        color: const Color(AppColors.secondaryTextColor),
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontConstant.bricolage,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      // checkColor: const WidgetStatePropertyAll(Color(AppColors.primaryColor)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      checkColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(AppColors.white);
        } else {
          return  Color(AppColors.white);
        }
      }),
      // fillColor: const WidgetStatePropertyAll(Color(AppColors.white)),
      fillColor:  WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(AppColors.primaryColor);
        } else {
          return  Color(AppColors.white);
        }
      }),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const BorderSide(color: Color(AppColors.primaryColor));
        } else {
          return const BorderSide(color: Color(AppColors.primaryColor));
        }
      }),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: Color(AppColors.buttonColor),
      trackShape: RoundedRectSliderTrackShape(),
    ),
    timePickerTheme: const TimePickerThemeData(
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black),
      ),
      dayPeriodTextStyle: TextStyle(color: Colors.black),
      timeSelectorSeparatorColor: WidgetStatePropertyAll(Colors.black),
      timeSelectorSeparatorTextStyle: WidgetStatePropertyAll<TextStyle>(
        TextStyle(color: Colors.black),
      ),
    ),
    colorScheme: ColorScheme.light(
      ///  major color
      primary: const  Color(AppColors.primaryColor),
      primaryContainer: const  Color(AppColors.primaryColor).withValues(alpha: .1),
      primaryFixed: const  Color(AppColors.veryLightPrimaryColor),
      secondary: Color(AppColors.secondaryColor),
      outline: Color(AppColors.buttonColor),

      /// background color
      surface: Color(AppColors.backgroundColor),
      onSurface: Colors.white,

      /// error color
      error: Colors.red,

      /// text color
      onPrimary: const Color(AppColors.primaryTextColor),
      onSecondary: const   Color(AppColors.secondaryTextColor),
      onTertiaryContainer:  const Color(AppColors.tertiaryTextColor),
      onError: const Color(AppColors.errorColor),
      shadow: const Color(AppColors.greyColor),
      tertiary: Color(AppColors.orangeColor),
      onErrorContainer: Colors.red,
      onTertiary: const Color(AppColors.lightGreyColor),
      scrim: const Color(AppColors.hotRed),
      secondaryContainer: const Color(AppColors.blueContainerColor),
      surfaceContainerLow: const Color(AppColors.lightGreenColor),
      secondaryFixed: const Color(AppColors.secondaryContainerColor),
      onTertiaryFixed: const Color(AppColors.lightGreyColor),
      surfaceContainerHigh: const Color(AppColors.homeColor),
      onInverseSurface: const Color(AppColors.veryLightOrange),
      inversePrimary: Colors.black,
      onSecondaryFixed: const Color(AppColors.green2Color),
      onPrimaryFixedVariant: const Color(AppColors.buttonColor),
    ).copyWith(surface: Colors.white),
  );

  static ThemeData dark() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: FontConstant.bricolage,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    shadowColor: const Color(AppColors.greyColor),
    scaffoldBackgroundColor: const Color(
      AppColors.backgroundColor,
    ), // ✅ Add this to AppColors!
    cardColor: const Color(AppColors.backgroundColor),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(AppColors.primaryColor),
    ),

    radioTheme: RadioThemeData(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(AppColors.buttonColor);
        } else {
          return Colors.white; // Contrast for dark
        }
      }),
    ),

    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: const BorderSide(
          width: 1,
          color: Color(AppColors.backgroundColor), // Use darker border color
        ),
      ),
      labelStyle: TextStyle(
        fontFamily: FontConstant.bricolage,
        fontWeight: FontWeight.w600,
        color: Colors.white, // Text on dark
      ),
    ),

    iconTheme: const IconThemeData(color: Colors.white),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        shadowColor: const Color(AppColors.backgroundColor),
        backgroundColor: const Color(AppColors.backgroundColor),
        surfaceTintColor: const Color(AppColors.backgroundColor),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      errorStyle: TextStyle(
        color: const Color(AppColors.errorColor),
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        fontFamily: FontConstant.bricolage,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(
          color: const Color(AppColors.backgroundColor),
          width: 0.5.h,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          color: const Color(AppColors.buttonColor),
          width: 0.5.h,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          color: const Color(AppColors.buttonColor),
          width: 0.5.h,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          color: const Color(AppColors.backgroundColor),
          width: 0.5.h,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          color: const Color(AppColors.errorColor),
          width: 0.5.h,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          color: const Color(AppColors.backgroundColor),
          width: 0.5.h,
        ),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        fontFamily: FontConstant.bricolage,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        fontFamily: FontConstant.bricolage,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        fontFamily: FontConstant.bricolage,
      ),
      bodyMedium: TextStyle(
        color: const Color(AppColors.backgroundColor), // e.g., grey-400
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        fontFamily: FontConstant.bricolage,
      ),
      bodySmall: TextStyle(
        color: const Color(AppColors.backgroundColor),
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontConstant.bricolage,
      ),
      labelSmall: TextStyle(
        color: const Color(AppColors.backgroundColor),
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontConstant.bricolage,
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      checkColor: const WidgetStatePropertyAll(Color(AppColors.primaryColor)),
      fillColor: const WidgetStatePropertyAll(Color(AppColors.white)),
      side: WidgetStateBorderSide.resolveWith((states) {
        return const BorderSide(color: Color(AppColors.primaryColor));
      }),
    ),

    sliderTheme: const SliderThemeData(
      activeTrackColor: Color(AppColors.buttonColor),
      trackShape: RoundedRectSliderTrackShape(),
    ),

    timePickerTheme: const TimePickerThemeData(
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
      ),
      dayPeriodTextStyle: TextStyle(color: Colors.white),
      timeSelectorSeparatorColor: WidgetStatePropertyAll(Colors.white),
      timeSelectorSeparatorTextStyle: WidgetStatePropertyAll<TextStyle>(
        TextStyle(color: Colors.white),
      ),
    ),

    colorScheme: const ColorScheme.dark(
      primary: Color(AppColors.primaryColor),
      // ignore: use_full_hex_values_for_flutter_colors
      primaryFixedDim: Color(0xff8c37c31a),
      secondary: Color(AppColors.secondaryColor),
      outline: Color(AppColors.buttonColor),
      surface: Color(AppColors.backgroundColor),
      onSurface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Color(AppColors.backgroundColor),
      onTertiaryContainer: Color(AppColors.tertiaryTextColor),
      onError: Color(AppColors.errorColor),
      shadow: Color(AppColors.backgroundColor),
      tertiary: Color(AppColors.orangeColor),
      onErrorContainer: Colors.red,
      onTertiary: Color(AppColors.lightGreyColor),
      scrim: Color(AppColors.hotRed),
      secondaryContainer: Color(AppColors.blueContainerColor),
      surfaceContainerLow: Color(AppColors.lightGreenColor),
      secondaryFixed: Color(AppColors.secondaryContainerColor),
      onTertiaryFixed: Color(AppColors.lightGreyColor),
      surfaceContainerHigh: Color(AppColors.homeColor),
      onInverseSurface: Color(AppColors.veryLightOrange),
    ),
  );
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    loadTheme();
  }
  Future<void> loadTheme() async {
    final themeName =
        HiveStorage.appTheme; // Returns 'light', 'dark', or 'system'
    state = ThemeMode.values.firstWhere(
      (mode) => mode.name == themeName,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> toggleTheme(bool isDark) async {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
    HiveStorage.themeMode = state.name; // Save as String
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    HiveStorage.themeMode = mode.name;
  }
}
