import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

abstract class AppElevation {
  AppElevation._();

  /// Subtle — cards, containers on surface1
  static const BoxShadow elevation1 = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 6,
    offset: Offset(0, 2),
  );

  /// Medium — elevated cards, dropdowns, popovers
  static const BoxShadow elevation2 = BoxShadow(
    color: Color(0x29000000),
    blurRadius: 10,
    offset: Offset(0, 4),
  );

  /// High — FABs, modals, bottom sheets
  static const BoxShadow elevation3 = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  // ━━━━━━━━━━━━━ LIGHT MODE (brand-tinted) ━━━━━━━━━━━━━
  static BoxShadow lightElevation1 = BoxShadow(
    color: AppColors.primary.withValues(alpha: 0.08),
    blurRadius: 4,
    offset: const Offset(0, 1),
  );

  static BoxShadow lightElevation2 = BoxShadow(
    color: AppColors.primary.withValues(alpha: 0.12),
    blurRadius: 8,
    offset: const Offset(0, 3),
  );

  static BoxShadow lightElevation3 = BoxShadow(
    color: AppColors.primary.withValues(alpha: 0.16),
    blurRadius: 16,
    offset: const Offset(0, 6),
  );
}
