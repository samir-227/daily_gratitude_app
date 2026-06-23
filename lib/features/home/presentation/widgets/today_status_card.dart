import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../data/models/user_stats.dart';
import '../../../../data/models/gratitude_entry.dart';

class TodayStatusCard extends StatelessWidget {
  final UserStats stats;
  final GratitudeEntry? todayEntry;
  final Brightness brightness;

  const TodayStatusCard({
    super.key,
    required this.stats,
    this.todayEntry,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(
              kSpace12,
              kSpace10,
              kSpace12,
              kSpace10,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface(2, brightness),
              borderRadius: BorderRadius.circular(AppRadius.standard),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stats.totalEntries}',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  AppStrings.entries,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.onSurface(brightness, secondary: true),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: kSpace10),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(
              kSpace12,
              kSpace10,
              kSpace12,
              kSpace10,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface(2, brightness),
              borderRadius: BorderRadius.circular(AppRadius.standard),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stats.currentStreak}',
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.streakFire,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  AppStrings.dayStreak,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.onSurface(brightness, secondary: true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
