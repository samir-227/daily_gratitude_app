import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../data/models/gratitude_entry.dart';

class ReflectionCard extends StatelessWidget {
  final VoidCallback onRecordTap;
  final Brightness brightness;
  final List<GratitudeEntry> allEntries;

  const ReflectionCard({
    super.key,
    required this.onRecordTap,
    required this.brightness,
    required this.allEntries,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthEntries = allEntries.where((e) =>
        e.createdAt.month == now.month && e.createdAt.year == now.year).toList();

    if (monthEntries.isEmpty) {
      return _buildEmptyReflection(context);
    }

    return _buildMonthlyInsights(context, monthEntries);
  }

  Widget _buildEmptyReflection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(kSpace16, kSpace12, kSpace16, kSpace12),
      decoration: BoxDecoration(
        color: AppColors.surface(2, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.reflectionTitle,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurface(brightness),
            ),
          ),
          SizedBox(height: kSpace6),
          Text(
            AppStrings.reflectionText,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurface(brightness, secondary: true),
              height: 1.5,
            ),
          ),
          SizedBox(height: kSpace12),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(AppRadius.standard),
              color: AppColors.secondary,
              padding: EdgeInsets.zero,
              onPressed: onRecordTap,
              child: Text(
                AppStrings.startGratitude,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textOnPrimaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyInsights(BuildContext context, List<GratitudeEntry> monthEntries) {
    final moodCounts = <String, int>{};
    final topicCounts = <String, int>{};
    for (final entry in monthEntries) {
      if (entry.moodTag != null) {
        moodCounts[entry.moodTag!] = (moodCounts[entry.moodTag!] ?? 0) + 1;
      }
      for (final topic in entry.topics) {
        topicCounts[topic] = (topicCounts[topic] ?? 0) + 1;
      }
    }

    String? topMood;
    int topMoodCount = 0;
    for (final entry in moodCounts.entries) {
      if (entry.value > topMoodCount) {
        topMoodCount = entry.value;
        topMood = entry.key;
      }
    }

    final topTopics = topicCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topThreeTopics = topTopics.take(3).map((e) => e.key).toList();

    final now = DateTime.now();
    const months = [
      'يناير', 'فبراير', 'مارس', 'إبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(kSpace16, kSpace12, kSpace16, kSpace12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.surface(1, brightness),
            AppColors.surface(2, brightness),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.book_fill, size: 14.w, color: AppColors.secondary),
              SizedBox(width: kSpace6),
              Text(
                '${AppStrings.monthlyReflection} — ${months[now.month - 1]}',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.onSurface(brightness),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: kSpace12),
          _buildInsightRow(
            icon: CupertinoIcons.calendar,
            label: '${monthEntries.length} ${AppStrings.daysWithEntries}',
            brightness: brightness,
          ),
          if (topMood != null) ...[
            SizedBox(height: kSpace8),
            _buildInsightRow(
              icon: CupertinoIcons.heart_fill,
              label: '${AppStrings.mostCommonMood}: ${AppStrings.moodLabel(topMood)}',
              brightness: brightness,
            ),
          ],
          if (topThreeTopics.isNotEmpty) ...[
            SizedBox(height: kSpace8),
            Wrap(
              spacing: kSpace6,
              runSpacing: kSpace4,
              children: topThreeTopics.map((topic) => Container(
                padding: EdgeInsets.symmetric(horizontal: kSpace8, vertical: kSpace4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  topic,
                  style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
                ),
              )).toList(),
            ),
          ],
          SizedBox(height: kSpace12),
          SizedBox(
            width: double.infinity,
            height: 36.h,
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(AppRadius.standard),
              color: AppColors.secondary,
              padding: EdgeInsets.zero,
              onPressed: onRecordTap,
              child: Text(
                AppStrings.startGratitude,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textOnPrimaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightRow({
    required IconData icon,
    required String label,
    required Brightness brightness,
  }) {
    return Row(
      children: [
        Icon(icon, size: 12.w, color: AppColors.primary),
        SizedBox(width: kSpace6),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurface(brightness, secondary: true),
            ),
          ),
        ),
      ],
    );
  }
}
