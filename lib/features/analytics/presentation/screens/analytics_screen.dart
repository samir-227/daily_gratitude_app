import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/analytics_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/di/injection.dart';
import '../widgets/analytics_stats_row.dart';
import '../widgets/weekly_chart.dart';
import '../widgets/top_topics_section.dart';
import '../widgets/mood_distribution_section.dart';

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
                      SizedBox(height: AppSpacing.standard),
                      CupertinoButton(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.standard),
                        onPressed: () => context.read<AnalyticsCubit>().loadAnalytics(),
                        child: Text(AppStrings.retry,
                          style: AppTextStyles.titleSmall.copyWith(color: AppColors.textOnPrimary)),
                      ),
                    ],
                  ),
                );
              }
              if (state is AnalyticsLoadedState) {
                final hasData = state.stats.totalEntries > 0;
                if (!hasData) {
                  return _buildEmptyAnalytics(context, brightness);
                }
                return SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.standard),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnalyticsStatsRow(state: state, brightness: brightness),
                      SizedBox(height: AppSpacing.standard),
                      Text(AppStrings.weeklyActivity,
                        style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
                      SizedBox(height: AppSpacing.cozy),
                      WeeklyChart(state: state, brightness: brightness),
                      if (state.topTopics.isNotEmpty) ...[
                        SizedBox(height: AppSpacing.standard),
                        Text(AppStrings.topTopics,
                          style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
                        SizedBox(height: AppSpacing.compact),
                        TopTopicsSection(state: state, brightness: brightness),
                      ],
                      if (state.moodDistribution.isNotEmpty) ...[
                        SizedBox(height: AppSpacing.standard),
                        Text(AppStrings.moodDistribution,
                          style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
                        SizedBox(height: AppSpacing.compact),
                        MoodDistributionSection(state: state, brightness: brightness),
                      ],
                      SizedBox(height: AppSpacing.lg),
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

  static Widget _buildEmptyAnalytics(BuildContext context, Brightness brightness) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.standard),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.emotionPeace.withValues(alpha: 0.2),
                    AppColors.emotionPeace.withValues(alpha: 0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.chart_bar_fill,
                size: 32.w,
                color: AppColors.emotionPeace,
              ),
            ),
            SizedBox(height: AppSpacing.standard),
            Text(
              AppStrings.analyticsEmptyTitle,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.onSurface(brightness),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSpacing.compact),
            Text(
              AppStrings.analyticsEmptySubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurface(brightness, secondary: true),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
