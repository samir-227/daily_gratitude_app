import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 4-pt spacing system.
///
/// Rationale:
/// - More granular than 8pt for dense UI (icon-to-text gaps, internal padding)
/// - Aligns with iOS HIG conventions (8, 12, 16)
/// - Better for RTL layouts where symmetric/asymmetric balance is nuanced
abstract class AppSpacing {
  AppSpacing._();

  static double get xxs => 2.w;
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get lg => 16.w;
  static double get xl => 20.w;
  static double get xxl => 24.w;
  static double get xxxl => 32.w;
  static double get huge => 40.w;
  static double get massive => 48.w;
  static double get giant => 64.w;

  // ━━━━━━━━━━━━━ COMPATIBILITY ALIASES ━━━━━━━━━━━━━
  static double get compact => xs;
  static double get tight => sm;
  static double get cozy => md;
  static double get standard => lg;
  static double get generous => xxl;
  static double get spacious => xxxl;
  static double get abundant => massive;
}
