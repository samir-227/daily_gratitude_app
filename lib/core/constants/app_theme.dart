import 'package:flutter/cupertino.dart';
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

  static const TextStyle display = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
    letterSpacing: -0.5,
  );

  static const TextStyle headline = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.29,
    letterSpacing: -0.3,
  );

  static const TextStyle titleLarge = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.33,
  );

  static const TextStyle titleMedium = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle titleSmall = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.1,
  );

  static const TextStyle bodyLarge = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
  );

  static const TextStyle labelLarge = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    inherit: false,
    fontFamily: AppTheme.fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.27,
    letterSpacing: 0.5,
  );
}

abstract class AppSpacing {
  AppSpacing._();

  static const double compact = 4;
  static const double tight = 8;
  static const double cozy = 12;
  static const double standard = 16;
  static const double generous = 24;
  static const double spacious = 32;
  static const double abundant = 48;
}

abstract class AppRadius {
  AppRadius._();

  static const double tight = 4;
  static const double cozy = 8;
  static const double standard = 12;
  static const double generous = 16;
  static const double pill = 999;
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
