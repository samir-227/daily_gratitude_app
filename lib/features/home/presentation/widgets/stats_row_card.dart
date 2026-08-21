import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../data/models/user_stats.dart';
import '../../../../data/models/gratitude_entry.dart';

class StatsRowCard extends StatelessWidget {
  final UserStats stats;
  final GratitudeEntry? todayEntry;
  final Brightness brightness;

  const StatsRowCard({
    super.key,
    required this.stats,
    this.todayEntry,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildMiniCard(
          icon: CupertinoIcons.heart_fill,
          iconColor: AppColors.accent,
          title: AppStrings.howDoYouFeel,
          subtitle: stats.currentStreak > 3 ? AppStrings.emotionLoved : AppStrings.recordNow,
          brightness: brightness,
        ),
        SizedBox(width: kSpace10),
        _buildMiniCard(
          icon: CupertinoIcons.checkmark_circle_fill,
          iconColor: todayEntry != null
              ? AppColors.success
              : AppColors.textTertiary,
          title: AppStrings.today,
          subtitle: todayEntry != null
              ? AppStrings.entrySaved
              : AppStrings.noEntryToday,
          brightness: brightness,
        ),
      ],
    );
  }

  Widget _buildMiniCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Brightness brightness,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(kSpace12, kSpace10, kSpace12, kSpace10),
        decoration: BoxDecoration(
          color: AppColors.surface(2, brightness),
          borderRadius: BorderRadius.circular(AppRadius.standard),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16.w, color: iconColor),
            SizedBox(height: kSpace6),
            Text(
              title,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onSurface(brightness, secondary: true),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onSurface(brightness),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
