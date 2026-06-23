import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bloc/analytics_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';

class WeeklyChart extends StatelessWidget {
  final AnalyticsLoadedState state;
  final Brightness brightness;

  const WeeklyChart({
    super.key,
    required this.state,
    required this.brightness,
  });

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final days = state.weekActivity.entries.toList();
    final maxVal = days.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return Container(
      height: 180.h,
      padding: EdgeInsets.all(AppSpacing.standard),
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
                      padding: EdgeInsets.only(top: AppSpacing.tight),
                      child: Text(weekdays[days[idx].key.weekday - 1],
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.onSurface(brightness, secondary: true))),
                    );
                  }
                  return const Text('');
                },
                reservedSize: 24.w,
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
                  width: 20.w,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
