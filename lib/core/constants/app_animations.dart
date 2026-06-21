import 'package:flutter/widgets.dart';

abstract class AppAnimations {
  AppAnimations._();

  // ━━━━━━━━━━━━━ DURATIONS ━━━━━━━━━━━━━

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 1000);

  // ━━━━━━━━━━━━━ CURVES ━━━━━━━━━━━━━

  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve easeIn = Curves.easeInCubic;
  static const Curve easeInOut = Curves.easeInOutCubic;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve spring = Curves.elasticOut;
  static const Curve decelerate = Curves.decelerate;

  // ━━━━━━━━━━━━━ PRESET TWEENS ━━━━━━━━━━━━━

  static Tween<double> buttonPressTween = Tween(begin: 1.0, end: 0.98);
  static Tween<double> emotionChipTween = Tween(begin: 1.0, end: 1.15);
  static Tween<double> fadeIn = Tween(begin: 0.0, end: 1.0);

  // ━━━━━━━━━━━━━ REDUCED MOTION HELPERS ━━━━━━━━━━━━━

  /// Returns [duration] if reduced motion is disabled, [Duration.zero] otherwise.
  static Duration resolveDuration(BuildContext context, Duration duration) {
    final reduced = MediaQuery.of(context).disableAnimations;
    return reduced ? Duration.zero : duration;
  }

  /// Returns [fast] or [zero] depending on reduced motion preference.
  static Duration fastOrZero(BuildContext context) =>
      resolveDuration(context, fast);

  /// Returns [normal] or [zero] depending on reduced motion preference.
  static Duration normalOrZero(BuildContext context) =>
      resolveDuration(context, normal);

  /// Returns a fade-only animation if reduced motion is enabled,
  /// otherwise returns the full animation including scale/offset.
  static Animation<double> sanitize(
    BuildContext context,
    Animation<double> animation,
  ) {
    final reduced = MediaQuery.of(context).disableAnimations;
    return reduced
        ? Tween<double>(begin: 1.0, end: 1.0).animate(animation)
        : animation;
  }
}
