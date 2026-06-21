import 'package:flutter/cupertino.dart';

/// Opacity & state layer tokens for interactive components.
abstract class AppOpacity {
  AppOpacity._();

  static const double hover = 0.08;
  static const double focus = 0.12;
  static const double pressed = 0.16;
  static const double dragged = 0.20;
  static const double selected = 0.12;
  static const double disabled = 0.38;
  static const double scrim = 0.60;

  /// Shimmer / skeleton loading
  static const double shimmerBase = 0.10;
  static const double shimmerHighlight = 0.20;
}

/// Visual feedback helper for applying state layers composited over a color.
extension StateLayer on Color {
  Color withHover() => withValues(alpha: AppOpacity.hover);
  Color withFocus() => withValues(alpha: AppOpacity.focus);
  Color withPressed() => withValues(alpha: AppOpacity.pressed);
  Color withDisabled() => withValues(alpha: AppOpacity.disabled);
}
