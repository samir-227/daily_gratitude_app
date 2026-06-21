import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_theme.dart';

String _milestoneMessage(int streak) {
  switch (streak) {
    case 3: return AppStrings.threeDayMilestone;
    case 7: return AppStrings.oneWeekMilestone;
    case 14: return AppStrings.twoWeekMilestone;
    case 30: return AppStrings.oneMonthMilestone;
    case 60: return AppStrings.twoMonthMilestone;
    case 100: return AppStrings.hundredDayMilestone;
    default: return AppStrings.defaultMilestone;
  }
}

Future<bool?> showMilestoneDialog(BuildContext context, int streak) {
  return showCupertinoDialog<bool>(
    context: context,
    builder: (ctx) => CupertinoAlertDialog(
      title: _MilestoneCelebration(streak: streak),
      content: const SizedBox.shrink(),
      actions: [
        CupertinoDialogAction(
          child: Text(AppStrings.keepGoing,
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.primary, fontWeight: FontWeight.w600)),
          onPressed: () => Navigator.of(ctx).pop(true),
        ),
      ],
    ),
  );
}

class _MilestoneCelebration extends StatefulWidget {
  final int streak;
  const _MilestoneCelebration({required this.streak});

  @override
  State<_MilestoneCelebration> createState() => _MilestoneCelebrationState();
}

class _MilestoneCelebrationState extends State<_MilestoneCelebration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.cozy),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: const Interval(0.0, 0.45, curve: Curves.elasticOut),
            ),
            child: Container(
              width: kSpace48,
              height: kSpace48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primaryDark,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(CupertinoIcons.star_fill,
                  color: AppColors.textOnPrimary, size: 24.w),
              ),
            ),
          ),
          SizedBox(height: AppSpacing.cozy),
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _controller,
              curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
            )),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
              ),
              child: Text(
                '${widget.streak} ${AppStrings.dayStreak}!',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.compact),
          FadeTransition(
            opacity: CurvedAnimation(
              parent: _controller,
              curve: const Interval(0.4, 0.85, curve: Curves.easeOut),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.compact),
              child: Text(
                _milestoneMessage(widget.streak),
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
