import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

abstract class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Cairo';

  static final CupertinoThemeData dark = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    primaryContrastingColor: CupertinoColors.white,
    scaffoldBackgroundColor: AppColors.surface0,
    barBackgroundColor: AppColors.surface1,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.primary,
      textStyle: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
      navTitleTextStyle: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
      navLargeTitleTextStyle: AppTextStyles.headline.copyWith(color: AppColors.textPrimary),
      actionTextStyle: AppTextStyles.titleSmall.copyWith(color: AppColors.primary),
      tabLabelTextStyle: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary),
    ),
  );

  static final CupertinoThemeData light = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryDark,
    primaryContrastingColor: CupertinoColors.white,
    scaffoldBackgroundColor: AppColors.surfaceLight0,
    barBackgroundColor: AppColors.surfaceLight1,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.primaryDark,
      textStyle: AppTextStyles.bodyLarge.copyWith(color: AppColors.lightTextPrimary),
      navTitleTextStyle: AppTextStyles.titleLarge.copyWith(color: AppColors.lightTextPrimary),
      navLargeTitleTextStyle: AppTextStyles.headline.copyWith(color: AppColors.lightTextPrimary),
      actionTextStyle: AppTextStyles.titleSmall.copyWith(color: AppColors.primaryDark),
      tabLabelTextStyle: AppTextStyles.labelMedium.copyWith(color: AppColors.lightTextSecondary),
    ),
  );
}

abstract class AppTextStyles {
  AppTextStyles._();

  static TextStyle get display => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    height: 1.25,
    letterSpacing: -0.5,
  );

  static TextStyle get headline => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    height: 1.29,
    letterSpacing: -0.3,
  );

  static TextStyle get titleLarge => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.33,
  );

  static TextStyle get titleMedium => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static TextStyle get titleSmall => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.1,
  );

  static TextStyle get bodyLarge => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
  );

  static TextStyle get bodySmall => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
  );

  static TextStyle get labelLarge => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 1.27,
    letterSpacing: 0.5,
  );
}

abstract class AppSpacing {
  AppSpacing._();

  static double get compact => 4.w;
  static double get tight => 8.w;
  static double get cozy => 12.w;
  static double get standard => 16.w;
  static double get generous => 24.w;
  static double get spacious => 32.w;
  static double get abundant => 48.w;
}

abstract class AppRadius {
  AppRadius._();

  static double get tight => 4.r;
  static double get cozy => 8.r;
  static double get standard => 12.r;
  static double get generous => 16.r;
  static double get pill => 999.r;
}

abstract class AppElevation {
  AppElevation._();

  static const BoxShadow elevation1 = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.20),
    blurRadius: 8,
    offset: Offset(0, 2),
  );

  static const BoxShadow elevation2 = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.25),
    blurRadius: 16,
    offset: Offset(0, 4),
  );

  static const BoxShadow elevation3 = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.30),
    blurRadius: 24,
    offset: Offset(0, 8),
  );
}
