import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/widgets/staggered_fade_in.dart';
import '../../../../data/models/gratitude_entry.dart';

class RecentEntriesCarousel extends StatelessWidget {
  final List<GratitudeEntry> entries;
  final VoidCallback onRecordTap;
  final Brightness brightness;

  const RecentEntriesCarousel({
    super.key,
    required this.entries,
    required this.onRecordTap,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return _buildEmptyState(context);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: kSpace4, bottom: kSpace8),
          child: Text(
            AppStrings.recentEntries,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurface(brightness),
            ),
          ),
        ),
        SizedBox(
          height: 130.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: entries.length,
            separatorBuilder: (_, _) => SizedBox(width: kSpace10),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return StaggeredFadeIn(
                index: index,
                child: _EntryCard(entry: entry, brightness: brightness),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(kSpace16, kSpace16, kSpace16, kSpace12),
        decoration: BoxDecoration(
          color: AppColors.surface(1, brightness),
          borderRadius: BorderRadius.circular(AppRadius.generous),
        ),
        child: Column(
          children: [
            Text(
              AppStrings.noEntriesYet,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.onSurface(brightness),
              ),
            ),
            SizedBox(height: kSpace6),
            Text(
              AppStrings.noEntriesSubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.onSurface(brightness, secondary: true),
                height: 1.5,
              ),
            ),
            SizedBox(height: kSpace12),
            SizedBox(
              width: double.infinity,
              height: 36.h,
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(AppRadius.standard),
                padding: EdgeInsets.zero,
                onPressed: onRecordTap,
                child: Text(
                  AppStrings.recordNow,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  final GratitudeEntry entry;
  final Brightness brightness;

  const _EntryCard({
    required this.entry,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    final moodColors = {
      'grateful': AppColors.emotionJoy,
      'happy': AppColors.emotionHope,
      'calm': AppColors.emotionPeace,
      'loved': AppColors.emotionLoved,
      'reflective': AppColors.emotionLoved,
      'grounded': AppColors.emotionGrounded,
    };
    final moodColor = moodColors[entry.moodTag] ?? AppColors.primary;
    return GestureDetector(
      onTap: () => context.push('/entry-detail', extra: entry),
      child: Container(
        width: 180.w,
        padding: EdgeInsets.all(kSpace12),
        decoration: BoxDecoration(
          color: AppColors.surface(1, brightness),
          borderRadius: BorderRadius.circular(AppRadius.generous),
          border: Border.all(color: AppColors.surface(2, brightness)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: kSpace8,
                    vertical: kSpace4,
                  ),
                  decoration: BoxDecoration(
                    color: moodColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    AppStrings.moodLabel(entry.moodTag),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: moodColor,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: kSpace8),
            Expanded(
              child: Text(
                entry.text,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.onSurface(brightness),
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: kSpace6),
            Text(
              '${entry.createdAt.day}/${entry.createdAt.month}',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onSurface(brightness, tertiary: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
