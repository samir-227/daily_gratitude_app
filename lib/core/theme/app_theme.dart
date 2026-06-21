import 'package:flutter/cupertino.dart';
import 'tokens/app_colors.dart';
import 'tokens/app_typography.dart';

abstract class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Cairo';

  static final CupertinoThemeData dark = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    primaryContrastingColor: AppColors.textOnPrimary,
    scaffoldBackgroundColor: AppColors.surface0,
    barBackgroundColor: AppColors.surface1,
    textTheme: AppTextStyles.buildDarkTheme(),
  );

  static final CupertinoThemeData light = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    primaryContrastingColor: AppColors.textOnPrimary,
    scaffoldBackgroundColor: AppColors.surfaceLight0,
    barBackgroundColor: AppColors.surfaceLight1,
    textTheme: AppTextStyles.buildLightTheme(),
  );
}
