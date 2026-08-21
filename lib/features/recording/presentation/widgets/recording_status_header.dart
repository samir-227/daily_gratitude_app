import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../bloc/recording_cubit.dart';

class RecordingStatusHeader extends StatelessWidget {
  final RecordingState state;
  final Brightness brightness;

  const RecordingStatusHeader({
    super.key,
    required this.state,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    final isRecording = state is RecordingInProgressState;
    final isDone = state is RecordingDoneState;
    String title;
    String subtitle;
    Color accent;

    if (isRecording) {
      title = AppStrings.recordingInProgress;
      subtitle = AppStrings.recordingHint;
      accent = AppColors.error;
    } else if (isDone) {
      title = AppStrings.doneRecording;
      subtitle = AppStrings.addFeelingsOrText;
      accent = AppColors.primary;
    } else {
      title = AppStrings.startRecordingText;
      subtitle = AppStrings.tapToRecord;
      accent = AppColors.primary;
    }

    return Container(
      padding: EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 3.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          SizedBox(width: kSpace12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
                SizedBox(height: kSpace4),
                Text(subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onSurface(brightness, secondary: true))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
