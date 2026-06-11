import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bloc/analytics_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/di/injection.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return BlocProvider(
      create: (_) {
        final cubit = sl<AnalyticsCubit>();
        cubit.loadAnalytics();
        return cubit;
      },
      child: CupertinoPageScaffold(
        backgroundColor: AppColors.surface(0, brightness),
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppColors.surface(1, brightness),
          border: Border(bottom: BorderSide(color: AppColors.divider, width: 0.5)),
          middle: Text(AppStrings.analytics,
            style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
        ),
        child: SafeArea(
          child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
            builder: (context, state) {
              if (state is AnalyticsLoadingState) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (state is AnalyticsErrorState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onSurface(brightness, secondary: true))),
                      const SizedBox(height: AppSpacing.standard),
                      CupertinoButton(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.standard),
                        onPressed: () => context.read<AnalyticsCubit>().loadAnalytics(),
                        child: Text(AppStrings.retry,
                          style: AppTextStyles.titleSmall.copyWith(color: CupertinoColors.white)),
                      ),
                    ],
                  ),
                );
              }
              if (state is AnalyticsLoadedState) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.standard),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatsRow(context, state),
                      const SizedBox(height: AppSpacing.generous),
                      _buildSectionTitle(AppStrings.weeklyActivity, brightness),
                      const SizedBox(height: AppSpacing.cozy),
                      _buildWeeklyChart(context, state),
                      if (state.topTopics.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.generous),
                        _buildSectionTitle(AppStrings.topTopics, brightness),
                        const SizedBox(height: AppSpacing.cozy),
                        _buildTopTopics(context, state, brightness),
                      ],
                      if (state.moodDistribution.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.generous),
                        _buildSectionTitle(AppStrings.moodDistribution, brightness),
                        const SizedBox(height: AppSpacing.cozy),
                        _buildMoodDistribution(context, state, brightness),
                      ],
                      const SizedBox(height: AppSpacing.spacious),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  static Widget _buildSectionTitle(String title, Brightness brightness) {
    return Text(title,
      style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness)));
  }

  static Widget _buildStatsRow(BuildContext context, AnalyticsLoadedState state) {
    return Row(
      children: [
        Expanded(child: _buildStatCard(
          context, '${state.stats.currentStreak}', AppStrings.currentStreak, AppColors.streakFire)),
        const SizedBox(width: AppSpacing.cozy),
        Expanded(child: _buildStatCard(
          context, '${state.stats.longestStreak}', AppStrings.longestStreak, AppColors.primary)),
        const SizedBox(width: AppSpacing.cozy),
        Expanded(child: _buildStatCard(
          context, '${state.stats.totalEntries}', AppStrings.totalEntries, AppColors.emotionPeace)),
      ],
    );
  }

  static Widget _buildStatCard(
      BuildContext context, String value, String label, Color accentColor) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cozy),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.standard),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        children: [
          Text(value,
            style: AppTextStyles.headline.copyWith(color: accentColor, fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.compact),
          Text(label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onSurface(brightness, secondary: true)),
            textAlign: TextAlign.center),
        ],
      ),
    );
  }

  static Widget _buildWeeklyChart(BuildContext context, AnalyticsLoadedState state) {
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    final days = state.weekActivity.entries.toList();
    final maxVal = days.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return Container(
      height: 200,
      padding: const EdgeInsets.all(AppSpacing.standard),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: (maxVal + 1).toDouble(),
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx >= 0 && idx < days.length) {
                    const weekdays = ['إث', 'ثل', 'أر', 'خم', 'جم', 'سب', 'أح'];
                    return Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.tight),
                      child: Text(weekdays[days[idx].key.weekday - 1],
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.onSurface(brightness, secondary: true))),
                    );
                  }
                  return const Text('');
                },
                reservedSize: 24,
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: days.asMap().entries.map((entry) {
            final isToday = _isToday(entry.value.key);
            return BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value.value.toDouble(),
                  color: isToday ? AppColors.primary : AppColors.primary.withValues(alpha: 0.3),
                  width: 20,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  static bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  static Widget _buildTopTopics(
      BuildContext context, AnalyticsLoadedState state, Brightness brightness) {
    final themeBrightness = brightness;
    final maxCount = state.topTopics.values.reduce((a, b) => a > b ? a : b);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.standard),
      decoration: BoxDecoration(
        color: AppColors.surface(1, themeBrightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        children: state.topTopics.entries.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.compact),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(e.key,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurface(themeBrightness)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.tight),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.tight),
                    child: Container(
                      height: 20,
                      color: AppColors.primary.withValues(alpha: 0.1),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: maxCount > 0 ? e.value / maxCount : 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, AppColors.primaryLight],
                            ),
                            borderRadius: BorderRadius.circular(AppRadius.tight),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.tight),
                SizedBox(
                  width: 24,
                  child: Text('${e.value}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurface(themeBrightness, secondary: true)),
                    textAlign: TextAlign.end),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  static Widget _buildMoodDistribution(
      BuildContext context, AnalyticsLoadedState state, Brightness brightness) {
    final themeBrightness = brightness;
    final total = state.moodDistribution.values.fold(0, (a, b) => a + b);
    if (total == 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.standard),
      decoration: BoxDecoration(
        color: AppColors.surface(1, themeBrightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: state.moodDistribution.entries.map((e) {
          final pct = (e.value / total * 100).round();
          final moodData = _moodData(e.key);
          return Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: moodData.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.standard),
                ),
                child: Icon(moodData.icon, color: moodData.color, size: 22),
              ),
              const SizedBox(height: AppSpacing.compact),
              Text('$pct%',
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.onSurface(themeBrightness), fontWeight: FontWeight.bold)),
              Text(moodData.label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onSurface(themeBrightness, secondary: true))),
            ],
          );
        }).toList(),
      ),
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
    case 'peace':
      return _MoodData(AppColors.emotionPeace, CupertinoIcons.smiley_fill, AppStrings.emotionPeace);
    case 'calm':
      return _MoodData(AppColors.emotionLoved, CupertinoIcons.moon_fill, AppStrings.emotionLoved);
    case 'loved':
    case 'hope':
      return _MoodData(AppColors.emotionHope, CupertinoIcons.sparkles, AppStrings.emotionHope);
    case 'grounded':
      return _MoodData(AppColors.emotionGrounded, CupertinoIcons.leaf_arrow_circlepath, AppStrings.emotionGrounded);
    default:
      return _MoodData(AppColors.textSecondary, CupertinoIcons.question_circle_fill, mood);
  }
}
