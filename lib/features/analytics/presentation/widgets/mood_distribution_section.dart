import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/analytics_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_theme.dart';

class MoodDistributionSection extends StatelessWidget {
  final AnalyticsLoadedState state;
  final Brightness brightness;

  const MoodDistributionSection({
    super.key,
    required this.state,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    final total = state.moodDistribution.values.fold(0, (a, b) => a + b);
    if (total == 0) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(AppSpacing.standard),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (final e in state.moodDistribution.entries) ...[
              if (e != state.moodDistribution.entries.first)
                SizedBox(width: AppSpacing.lg),
              _MoodColumn(
                pct: (e.value / total * 100).round(),
                moodData: _moodData(e.key),
                themeBrightness: brightness,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MoodColumn extends StatelessWidget {
  final int pct;
  final _MoodData moodData;
  final Brightness themeBrightness;

  const _MoodColumn({
    required this.pct,
    required this.moodData,
    required this.themeBrightness,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: moodData.color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          child: Icon(moodData.icon, color: moodData.color, size: 18.w),
        ),
        SizedBox(height: AppSpacing.compact),
        Text('$pct%',
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.onSurface(themeBrightness), fontWeight: FontWeight.bold)),
        Text(moodData.label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.onSurface(themeBrightness, secondary: true))),
      ],
    );
  }
}

class _MoodData {
  final Color color;
  final IconData icon;
  final String label;
  const _MoodData(this.color, this.icon, this.label);
}

_MoodData _moodData(String mood) {
  switch (mood) {
    case 'grateful':
    case 'joy':
      return _MoodData(AppColors.emotionJoy, CupertinoIcons.heart_fill, AppStrings.emotionJoy);
    case 'happy':
    case 'hope':
      return _MoodData(AppColors.emotionHope, CupertinoIcons.smiley_fill, AppStrings.emotionHope);
    case 'calm':
    case 'peace':
      return _MoodData(AppColors.emotionPeace, CupertinoIcons.moon_fill, AppStrings.emotionPeace);
    case 'loved':
      return _MoodData(AppColors.emotionLoved, CupertinoIcons.sparkles, AppStrings.emotionLoved);
    case 'grounded':
      return _MoodData(AppColors.emotionGrounded, CupertinoIcons.leaf_arrow_circlepath, AppStrings.emotionGrounded);
    default:
      return _MoodData(AppColors.textSecondary, CupertinoIcons.question_circle_fill, mood);
  }
}
