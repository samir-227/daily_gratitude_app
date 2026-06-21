import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppRadius {
  AppRadius._();

  static double get tight => 4.r;
  static double get cozy => 8.r;
  static double get standard => 12.r;
  static double get generous => 16.r;
  static double get pill => 999.r;
}
