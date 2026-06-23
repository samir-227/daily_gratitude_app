import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../bloc/recording_cubit.dart';

class RecordingButton extends StatelessWidget {
  final RecordingState state;
  final Brightness brightness;

  const RecordingButton({
    super.key,
    required this.state,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    final isRecording = state is RecordingInProgressState;
    final isDone = state is RecordingDoneState;

    return Container(
      padding: EdgeInsets.all(kSpace16),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous + 4),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (isRecording) {
                context.read<RecordingCubit>().stopRecording();
              } else if (!isDone) {
                context.read<RecordingCubit>().startRecording();
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isRecording
                    ? const LinearGradient(
                        colors: [AppColors.error, Color(0xFFDC2626)])
                    : const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark]),
                boxShadow: [
                  BoxShadow(
                    color: (isRecording ? AppColors.error : AppColors.primary)
                        .withValues(alpha: 0.3),
                    blurRadius: 28.r,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  isRecording
                      ? CupertinoIcons.stop_fill
                      : CupertinoIcons.mic_fill,
                  color: AppColors.textOnPrimary,
                  size: 28.w,
                ),
              ),
            ),
          ),
          SizedBox(height: kSpace12),
          Text(
            isRecording ? AppStrings.stopRecordingText : AppStrings.tapToRecordAction,
            style: AppTextStyles.labelLarge.copyWith(
              color: isRecording ? AppColors.error : AppColors.onSurface(brightness),
              fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
