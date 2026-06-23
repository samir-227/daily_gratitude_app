import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';

class RecordHeroCard extends StatelessWidget {
  final VoidCallback onRecordTap;
  final Brightness brightness;

  const RecordHeroCard({
    super.key,
    required this.onRecordTap,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      padding: EdgeInsets.fromLTRB(kSpace16, kSpace12, kSpace16, kSpace12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.generous),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0,
            top: 0,
            left: 66.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.recordPrompt,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: kSpace6),
                Text(
                  AppStrings.recordDescription,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 8.h,
            width: 60.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _BreathingRecordButton(onTap: onRecordTap),
                SizedBox(height: kSpace4),
                Text(
                  AppStrings.tapToRecordAction,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BreathingRecordButton extends StatefulWidget {
  final VoidCallback onTap;
  const _BreathingRecordButton({required this.onTap});

  @override
  State<_BreathingRecordButton> createState() => _BreathingRecordButtonState();
}

class _BreathingRecordButtonState extends State<_BreathingRecordButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
    _glow = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.textOnPrimary.withValues(alpha: 0.95),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textOnPrimary.withValues(
                      alpha: 0.15 * _glow.value,
                    ),
                    blurRadius: (12 + 8 * _glow.value).r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.mic_fill,
                  size: 20.w,
                  color: AppColors.surface0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
