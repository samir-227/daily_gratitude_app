import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/tokens/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/tokens/app_spacing.dart';

class AtherSplashScreen extends StatefulWidget {
  const AtherSplashScreen({super.key});

  @override
  State<AtherSplashScreen> createState() => _AtherSplashScreenState();
}

class _AtherSplashScreenState extends State<AtherSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;

  // مراحل الأنيميشن المتتالية
  late Animation<double> _dotReveal;
  late Animation<double> _rippleProgress;
  late Animation<double> _rippleOpacity;
  late Animation<double> _pathDrawing;
  late Animation<double> _textFadeIn;
  late Animation<double> _finalPulse;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5500),
    );

    // 1. ظهور النقطة البرتقالية لوحدها على الشمال
    _dotReveal = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.12, curve: Curves.easeOut),
      ),
    );

    // 2. انتشار موجة الـ Ripple الهادئة
    _rippleProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.10, 0.28, curve: Curves.easeOutCubic),
      ),
    );
    _rippleOpacity = Tween<double>(begin: 0.4, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.15, 0.28, curve: Curves.linear),
      ),
    );

    // 3. انطلاق النقطة لرسم المنحنى والابتعاد الانسيابي في النهاية دون أي قفزات
    _pathDrawing = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.28, 0.65, curve: Curves.easeInOutCubic),
      ),
    );

    // 4. ظهور كتلة النصوص
    _textFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.68, 0.78, curve: Curves.easeOut),
      ),
    );

    // 5. النبضة الختامية الهادئة للنقطة البرتقالية في مكانها النهائي
    _finalPulse = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.25), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.25, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.76, 0.86, curve: Curves.easeInOut),
      ),
    );

    _mainController.addStatusListener(_onAnimationComplete);
    _mainController.forward();
  }

  void _onAnimationComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final box = Hive.box(kSettingsBox);
        final done = box.get(kOnboardingComplete, defaultValue: false) as bool;
        context.go(done ? '/home' : '/onboarding');
      });
    }
  }

  @override
  void dispose() {
    _mainController.removeStatusListener(_onAnimationComplete);
    _mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.surface0 : const Color(0xFFFFFFFF);
    final primaryColor = AppColors.primary;
    final accentColor = AppColors.secondary;
    final textColor = isDark ? AppColors.textPrimary : AppColors.primary;

    return Scaffold(
      backgroundColor: bgColor,
      body: AnimatedBuilder(
        animation: _mainController,
        builder: (context, child) {
          const double leftStartOffset = -100.0;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 260.w,
                  height: 180.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_rippleProgress.value > 0 && _rippleOpacity.value > 0)
                        Transform.translate(
                          offset: Offset(leftStartOffset.w, 0),
                          child: Container(
                            width: 120.w * _rippleProgress.value,
                            height: 120.w * _rippleProgress.value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: accentColor.withValues(alpha: _rippleOpacity.value),
                                width: 1.5.w,
                              ),
                            ),
                          ),
                        ),

                      CustomPaint(
                        size: Size(260.w, 180.h),
                        painter: LogoPathPainter(
                          drawProgress: _pathDrawing.value,
                          dotReveal: _dotReveal.value,
                          isCompleted: _mainController.value > 0.65,
                          finalPulse: _finalPulse.value,
                          leftStartPoint: leftStartOffset,
                          lineColor: primaryColor,
                          dotColor: accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),

                Opacity(
                  opacity: _textFadeIn.value,
                  child: Transform.translate(
                    offset: Offset(0, AppSpacing.md * (1 - _textFadeIn.value)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'أَثَر',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          'كل امتنان بيسيب أثر',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            color: textColor.withValues(alpha: 0.7),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LogoPathPainter extends CustomPainter {
  final double drawProgress;
  final double dotReveal;
  final bool isCompleted;
  final double finalPulse;
  final double leftStartPoint;
  final Color lineColor;
  final Color dotColor;

  LogoPathPainter({
    required this.drawProgress,
    required this.dotReveal,
    required this.isCompleted,
    required this.finalPulse,
    required this.leftStartPoint,
    required this.lineColor,
    required this.dotColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // بناء مسار اللوجو الدائري والانسيابي بالملي
    final Path customPath = Path();
    
    // 1. نقطة البداية على اليسار
    customPath.moveTo(center.dx + leftStartPoint, center.dy);

    // 2. المنحنى الصاعد إلى القمة العريضة الدائرية
    customPath.cubicTo(
      center.dx - 70, center.dy + 35, 
      center.dx - 65, center.dy - 55, 
      center.dx - 30, center.dy - 40, 
    );

    // 3. المنحنى الهابط إلى القاع المركزي المنساب
    customPath.cubicTo(
      center.dx + 5, center.dy - 25,  
      center.dx - 5, center.dy + 45,  
      center.dx + 25, center.dy + 30, 
    );

    // 4. نهاية الخط المرسوم الفعلي للشعار (يقف عند dx + 70)
    customPath.cubicTo(
      center.dx + 45, center.dy + 20, 
      center.dx + 45, center.dy - 5,  
      center.dx + 70, center.dy - 2,  
    );

    // 5. امتداد خفي إضافي مدمج داخل نفس الـ Path (مسافة الأمان الانسيابية للنقطة)
    // النقطة سوف تتحرك عليه بنعومة فائقة لتصل لـ dx + 98 دون أي قفزات مفاجئة
    customPath.lineTo(center.dx + 98, center.dy - 2);

    final pathMetrics = customPath.computeMetrics().toList();
    if (pathMetrics.isEmpty) return; 
    final pathMetric = pathMetrics.first;

    // إجمالي طول المسار شاملاً الامتداد الخفي
    final double totalLength = pathMetric.length;
    
    // حساب الطول الفعلي للخط الملون قبل إضافة مسافة الأمان (حوالي 85% من الطول الكلي)
    // هذا يضمن أن الخط يتوقف عن النمو هندسياً عند نقطة اللوجو الأصلية بالضبط
    final double blueLineMaxLength = totalLength - 28.0; 

    // رسم الخط الأزرق البترولي الفاخر
    if (drawProgress > 0) {
      // الخط الأزرق ينمو تدريجياً ولكنه يتوقف تماماً عند حدوده الرسمية (blueLineMaxLength)
      final double currentLineLength = min(blueLineMaxLength, totalLength * drawProgress);
      final Path extractPath = pathMetric.extractPath(0, currentLineLength);

      final paintLine = Paint()
        ..color = lineColor 
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16.0 
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(extractPath, paintLine);
    }

    // تحديد موقع النقطة البرتقالية بشكل "اسموزي" ناعم 100%
    Offset dotPosition;
    if (drawProgress > 0) {
      // النقطة تتبع طول المسار الكلي تدريجياً لتبتعد بنعومة بالغة في الـ 15% الأخيرة من الحركة
      final double currentDotOffset = totalLength * drawProgress;
      final tangent = pathMetric.getTangentForOffset(currentDotOffset);
      dotPosition = tangent?.position ?? Offset(center.dx + leftStartPoint, center.dy);
    } else {
      dotPosition = Offset(center.dx + leftStartPoint, center.dy);
    }

    // رسم النقطة البرتقالية (Terracotta / Soft Orange) مع النبضة والـ Glow
    if (dotReveal > 0) {
      final double baseRadius = 9.5 * dotReveal * (isCompleted ? finalPulse : 1.0);

      final paintGlow = Paint()
        ..color = dotColor.withValues(alpha: 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
      canvas.drawCircle(dotPosition, baseRadius * 1.6, paintGlow);

      final paintDot = Paint()
        ..color = dotColor 
        ..style = PaintingStyle.fill;
      canvas.drawCircle(dotPosition, baseRadius, paintDot);
    }
  }

  @override
  bool shouldRepaint(covariant LogoPathPainter oldDelegate) {
    return oldDelegate.drawProgress != drawProgress ||
        oldDelegate.dotReveal != dotReveal ||
        oldDelegate.isCompleted != isCompleted ||
        oldDelegate.finalPulse != finalPulse ||
        oldDelegate.leftStartPoint != leftStartPoint ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.dotColor != dotColor;
  }
}