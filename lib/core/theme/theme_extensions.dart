import 'package:flutter/cupertino.dart';
import 'tokens/app_colors.dart';

/// InheritedWidget that provides theme-aware color tokens
/// throughout the widget tree.
///
/// This is the Cupertino-native equivalent of Material's ThemeExtension.
/// Usage:
/// ```dart
/// final colors = AppColorTheme.of(context);
/// ```
class AppColorTheme extends InheritedWidget {
  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color secondary;
  final Color accent;
  final Color surface0;
  final Color surface1;
  final Color surface2;
  final Color surface3;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color textOnPrimary;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color outline;
  final Color divider;

  const AppColorTheme({
    super.key,
    required super.child,
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.secondary,
    required this.accent,
    required this.surface0,
    required this.surface1,
    required this.surface2,
    required this.surface3,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textOnPrimary,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.outline,
    required this.divider,
  });

  static const _dark = AppColorTheme(
    primary: AppColors.primary,
    primaryLight: AppColors.primaryLight,
    primaryDark: AppColors.primaryDark,
    secondary: AppColors.secondary,
    accent: AppColors.accent,
    surface0: AppColors.surface0,
    surface1: AppColors.surface1,
    surface2: AppColors.surface2,
    surface3: AppColors.surface3,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    textTertiary: AppColors.textTertiary,
    textDisabled: AppColors.textDisabled,
    textOnPrimary: AppColors.textOnPrimary,
    success: AppColors.success,
    warning: AppColors.warning,
    error: AppColors.error,
    info: AppColors.info,
    outline: AppColors.outline,
    divider: AppColors.divider,
    child: SizedBox.shrink(),
  );

  static const _light = AppColorTheme(
    primary: AppColors.primary,
    primaryLight: AppColors.primaryLight,
    primaryDark: AppColors.primaryDark,
    secondary: AppColors.secondary,
    accent: AppColors.accent,
    surface0: AppColors.surfaceLight0,
    surface1: AppColors.surfaceLight1,
    surface2: AppColors.surfaceLight2,
    surface3: AppColors.surfaceLight3,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textTertiary: AppColors.lightTextTertiary,
    textDisabled: AppColors.textDisabled,
    textOnPrimary: AppColors.textOnPrimaryLight,
    success: AppColors.success,
    warning: AppColors.warning,
    error: AppColors.error,
    info: AppColors.info,
    outline: AppColors.lightOutline,
    divider: AppColors.lightOutline,
    child: SizedBox.shrink(),
  );

  /// Returns the dark theme color set (without InheritedWidget wrapper).
  static AppColorTheme dark(Brightness brightness) =>
      brightness == Brightness.dark ? _dark : _light;

  /// Look up the closest [AppColorTheme] in the widget tree.
  static AppColorTheme of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppColorTheme>();
    assert(result != null, 'No AppColorTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppColorTheme oldWidget) {
    return primary != oldWidget.primary ||
        surface0 != oldWidget.surface0 ||
        surface1 != oldWidget.surface1 ||
        textPrimary != oldWidget.textPrimary ||
        textSecondary != oldWidget.textSecondary;
  }
}
