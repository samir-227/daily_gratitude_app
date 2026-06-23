import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/analytics_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';

class TopTopicsSection extends StatelessWidget {
  final AnalyticsLoadedState state;
  final Brightness brightness;

  const TopTopicsSection({
    super.key,
    required this.state,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    final maxCount = state.topTopics.values.reduce((a, b) => a > b ? a : b);
    return Container(
      padding: EdgeInsets.all(AppSpacing.standard),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        children: state.topTopics.entries.map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.compact),
            child: Row(
              children: [
                SizedBox(
                  width: 80.w,
                  child: Text(e.key,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurface(brightness)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: AppSpacing.tight),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.tight),
                    child: Container(
                      height: 18.h,
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
                SizedBox(width: AppSpacing.tight),
                SizedBox(
                  width: 24.w,
                  child: Text('${e.value}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurface(brightness, secondary: true)),
                    textAlign: TextAlign.end),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
