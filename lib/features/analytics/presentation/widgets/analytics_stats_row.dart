import 'package:flutter/cupertino.dart';
import '../bloc/analytics_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_theme.dart';

class AnalyticsStatsRow extends StatelessWidget {
  final AnalyticsLoadedState state;
  final Brightness brightness;

  const AnalyticsStatsRow({
    super.key,
    required this.state,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatCard(
          value: '${state.stats.currentStreak}',
          label: AppStrings.currentStreak,
          accentColor: AppColors.streakFire,
          brightness: brightness,
        )),
        SizedBox(width: AppSpacing.cozy),
        Expanded(child: _StatCard(
          value: '${state.stats.longestStreak}',
          label: AppStrings.longestStreak,
          accentColor: AppColors.primary,
          brightness: brightness,
        )),
        SizedBox(width: AppSpacing.cozy),
        Expanded(child: _StatCard(
          value: '${state.stats.totalEntries}',
          label: AppStrings.totalEntries,
          accentColor: AppColors.emotionPeace,
          brightness: brightness,
        )),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color accentColor;
  final Brightness brightness;

  const _StatCard({
    required this.value,
    required this.label,
    required this.accentColor,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.cozy),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.standard),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        children: [
          Text(value,
            style: AppTextStyles.titleLarge.copyWith(color: accentColor, fontWeight: FontWeight.bold)),
          SizedBox(height: AppSpacing.compact),
          Text(label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onSurface(brightness, secondary: true)),
            textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
