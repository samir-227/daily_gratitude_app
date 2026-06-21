import 'package:flutter/cupertino.dart';

abstract class AppColors {
  AppColors._();

  // ━━━━━━━━━━━━━ BRAND PRIMARY — Ocean ━━━━━━━━━━━━━
  /// Calm, deep ocean blue. Steady and reflective, without digital coldness.
  static const Color primary = Color(0xFF3D5A6C);
  static const Color primaryLight = Color(0xFF5A7E92);
  static const Color primaryDark = Color(0xFF2A3F4C);
  static const Color primaryContainer = Color(0xFF16242C);

  // ━━━━━━━━━━━━━ SECONDARY / ACCENT ━━━━━━━━━━━━━
  /// Warm coral — breaks the coldness of a typical "wellness blue"
  static const Color secondary = Color(0xFFE0825F);
  static const Color accent = Color(0xFFEFA585);

  // ━━━━━━━━━━━━━ DARK MODE SURFACES ━━━━━━━━━━━━━
  static const Color surface0 = Color(0xFF11171C);
  static const Color surface1 = Color(0xFF182026);
  static const Color surface2 = Color(0xFF212B33);
  static const Color surface3 = Color(0xFF2C3840);

  // ━━━━━━━━━━━━━ LIGHT MODE SURFACES ━━━━━━━━━━━━━
  static const Color surfaceLight0 = Color(0xFFF4F6F5);
  static const Color surfaceLight1 = Color(0xFFFFFFFF);
  static const Color surfaceLight2 = Color(0xFFE7ECEC);
  static const Color surfaceLight3 = Color(0xFFD9E1E1);

  // ━━━━━━━━━━━━━ TEXT — DARK MODE (WCAG AA Compliant) ━━━━━━━━━━━━━
  static const Color textPrimary = Color(0xFFE7EDEF);
  static const Color textSecondary = Color(0xFFA9B7BC);
  static const Color textTertiary = Color(0xFF859299);
  static const Color textDisabled = Color(0xFF5E6A70);

  // ━━━━━━━━━━━━━ TEXT — LIGHT MODE (WCAG AA Compliant) ━━━━━━━━━━━━━
  static const Color lightTextPrimary = Color(0xFF1A2226);
  static const Color lightTextSecondary = Color(0xFF566066);
  static const Color lightTextTertiary = Color(0xFF748086);

  // ━━━━━━━━━━━━━ TEXT ON PRIMARY ━━━━━━━━━━━━━
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnPrimaryLight = Color(0xFF1A2226);

  // ━━━━━━━━━━━━━ STATUS COLORS ━━━━━━━━━━━━━
  static const Color success = Color(0xFF5E8F6B);
  static const Color warning = Color(0xFFCB9248);
  static const Color error = Color(0xFFB5453B);
  static const Color info = Color(0xFF5A8AA0);
  static const Color streakFire = Color(0xFFD9714A);

  // ━━━━━━━━━━━━━ EMOTION PALETTE ━━━━━━━━━━━━━
  static const Color emotionJoy = Color(0xFFE0B24A);
  static const Color emotionPeace = Color(0xFF5A7E92);
  static const Color emotionLoved = Color(0xFFD6748C);
  static const Color emotionHope = Color(0xFF8E8FB0);
  static const Color emotionGrounded = Color(0xFF6E8A6F);

  // ━━━━━━━━━━━━━ BORDERS & DIVIDERS ━━━━━━━━━━━━━
  static const Color outline = Color(0xFF31404A);
  static const Color divider = Color(0xFF31404A);
  static const Color lightOutline = Color(0xFFD9E1E1);

  // ━━━━━━━━━━━━━ STATE LAYER OPACITIES ━━━━━━━━━━━━━
  static const double opacityHover = 0.08;
  static const double opacityFocus = 0.12;
  static const double opacityPressed = 0.16;
  static const double opacityDragged = 0.20;
  static const double opacitySelected = 0.12;
  static const double opacityDisabled = 0.38;
  static const double opacityScrim = 0.60;

  // ━━━━━━━━━━━━━ OVERLAY COLORS ━━━━━━━━━━━━━
  static const Color overlayHover = Color(0x14FFFFFF);
  static const Color overlayFocus = Color(0x1FFFFFFF);
  static const Color overlayPressed = Color(0x29FFFFFF);
  static const Color overlayDarkHover = Color(0x14000000);
  static const Color overlayDarkFocus = Color(0x1F000000);
  static const Color overlayDarkPressed = Color(0x29000000);

  // ━━━━━━━━━━━━━ HELPER GETTERS ━━━━━━━━━━━━━

  /// Get surface color by brightness and elevation level (0–3)
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

  /// Get text color by brightness and hierarchy
  static Color onSurface(
    Brightness brightness, {
    bool secondary = false,
    bool tertiary = false,
  }) {
    if (brightness == Brightness.dark) {
      if (tertiary) return textTertiary;
      return secondary ? textSecondary : textPrimary;
    }
    if (tertiary) return lightTextTertiary;
    return secondary ? lightTextSecondary : lightTextPrimary;
  }
}