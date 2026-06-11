import 'package:flutter/cupertino.dart';

abstract class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2DD4A4);
  static const Color primaryDark = Color(0xFF10B981);
  static const Color primaryLight = Color(0xFF5EE7B6);
  static const Color primaryContainer = Color(0xFF1A3D35);

  static const Color surface0 = Color(0xFF0F1419);
  static const Color surface1 = Color(0xFF1A1F26);
  static const Color surface2 = Color(0xFF252D37);
  static const Color surface3 = Color(0xFF2E3847);

  static const Color surfaceLight0 = Color(0xFFFAFBFC);
  static const Color surfaceLight1 = Color(0xFFFFFFFF);
  static const Color surfaceLight2 = Color(0xFFF3F4F6);
  static const Color surfaceLight3 = Color(0xFFE5E7EB);

  static const Color textPrimary = Color(0xFFE5E7EB);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textTertiary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF4B5563);

  static const Color lightTextPrimary = Color(0xFF1F2937);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextTertiary = Color(0xFF9CA3AF);

  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  static const Color streakFire = Color(0xFFFF6B35);

  static const Color emotionJoy = Color(0xFFFFD85C);
  static const Color emotionPeace = Color(0xFF5B9BD5);
  static const Color emotionLoved = Color(0xFFE85A8F);
  static const Color emotionHope = Color(0xFFA78BFA);
  static const Color emotionGrounded = Color(0xFF84A366);

  static const Color outline = Color(0xFF374151);
  static const Color divider = Color(0xFF374151);
  static const Color lightOutline = Color(0xFFE5E7EB);

  static Color surface(int level, Brightness brightness) {
    if (brightness == Brightness.dark) {
      return switch (level) {
        0 => surface0,
        1 => surface1,
        2 => surface2,
        3 => surface3,
        _ => surface1,
      };
    }
    return switch (level) {
      0 => surfaceLight0,
      1 => surfaceLight1,
      2 => surfaceLight2,
      3 => surfaceLight3,
      _ => surfaceLight1,
    };
  }

  static Color onSurface(Brightness brightness, {bool secondary = false, bool tertiary = false}) {
    if (brightness == Brightness.dark) {
      if (tertiary) return textTertiary;
      return secondary ? textSecondary : textPrimary;
    }
    if (tertiary) return lightTextTertiary;
    return secondary ? lightTextSecondary : lightTextPrimary;
  }
}
