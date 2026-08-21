import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

const String _cairo = 'Cairo';

abstract class AppTextStyles {
  AppTextStyles._();

  // ━━━━━━━━━━━━━ DISPLAY ━━━━━━━━━━━━━
  static TextStyle get display => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 0.0,
      );

  // ━━━━━━━━━━━━━ HEADLINE ━━━━━━━━━━━━━
  static TextStyle get headline => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: 0.0,
      );

  // ━━━━━━━━━━━━━ TITLE ━━━━━━━━━━━━━
  static TextStyle get titleLarge => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: 0.0,
      );

  static TextStyle get titleMedium => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 1.35,
        letterSpacing: 0.0,
      );

  static TextStyle get titleSmall => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.0,
      );

  // ━━━━━━━━━━━━━ BODY ━━━━━━━━━━━━━
  static TextStyle get bodyLarge => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        height: 1.6,
        letterSpacing: 0.0,
      );

  static TextStyle get bodyMedium => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 1.55,
        letterSpacing: 0.0,
      );

  static TextStyle get bodySmall => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.0,
      );

  // ━━━━━━━━━━━━━ LABEL ━━━━━━━━━━━━━
  static TextStyle get labelLarge => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.0,
      );

  static TextStyle get labelMedium => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        height: 1.35,
        letterSpacing: 0.0,
      );

  static TextStyle get labelSmall => TextStyle(
        inherit: false,
        fontFamily: _cairo,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: 0.0,
      );

  // ━━━━━━━━━━━━━ THEME DATA ━━━━━━━━━━━━━

  static CupertinoTextThemeData buildDarkTheme() {
    return CupertinoTextThemeData(
      primaryColor: AppColors.primary,
      textStyle: bodyLarge.copyWith(color: AppColors.textPrimary),
      actionTextStyle: titleSmall.copyWith(color: AppColors.primary),
      tabLabelTextStyle: labelSmall.copyWith(color: AppColors.textSecondary),
      navActionTextStyle: titleSmall.copyWith(color: AppColors.primary),
      navLargeTitleTextStyle: headline.copyWith(color: AppColors.textPrimary),
      navTitleTextStyle: titleLarge.copyWith(color: AppColors.textPrimary),
      pickerTextStyle: bodyLarge.copyWith(color: AppColors.textPrimary),
      dateTimePickerTextStyle: bodyLarge.copyWith(color: AppColors.textPrimary),
    );
  }

  static CupertinoTextThemeData buildLightTheme() {
    return CupertinoTextThemeData(
      primaryColor: AppColors.primary,
      textStyle: bodyLarge.copyWith(color: AppColors.lightTextPrimary),
      actionTextStyle: titleSmall.copyWith(color: AppColors.primary),
      tabLabelTextStyle: labelSmall.copyWith(color: AppColors.lightTextSecondary),
      navActionTextStyle: titleSmall.copyWith(color: AppColors.primary),
      navLargeTitleTextStyle: headline.copyWith(color: AppColors.lightTextPrimary),
      navTitleTextStyle: titleLarge.copyWith(color: AppColors.lightTextPrimary),
      pickerTextStyle: bodyLarge.copyWith(color: AppColors.lightTextPrimary),
      dateTimePickerTextStyle: bodyLarge.copyWith(color: AppColors.lightTextPrimary),
    );
  }
}
