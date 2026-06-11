import 'package:flutter/animation.dart';

abstract class AppAnimations {
  AppAnimations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 1000);

  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve easeIn = Curves.easeInCubic;
  static const Curve easeInOut = Curves.easeInOutCubic;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve spring = Curves.elasticOut;

  static Tween<double> buttonPressTween = Tween(begin: 1.0, end: 0.98);
  static Tween<double> emotionChipTween = Tween(begin: 1.0, end: 1.15);
  static Tween<double> fadeIn = Tween(begin: 0.0, end: 1.0);
}
