import 'package:flutter/cupertino.dart';
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
      title: Column(
        children: [
          Container(
            width: kSpace64,
            height: kSpace64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.streakFire,
                  AppColors.warning,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(CupertinoIcons.flame_fill,
                color: CupertinoColors.white, size: 32),
            ),
          ),
          SizedBox(height: AppSpacing.cozy),
          Text(
            '\u{1F389} $streak ${AppStrings.dayStreak}!',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Padding(
        padding: EdgeInsets.only(top: AppSpacing.cozy),
        child: Text(
          _milestoneMessage(streak),
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ),
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
