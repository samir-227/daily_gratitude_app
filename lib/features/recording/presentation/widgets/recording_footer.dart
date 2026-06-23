import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_theme.dart';
import '../bloc/recording_cubit.dart';

class RecordingFooter extends StatelessWidget {
  final RecordingState state;
  final Brightness brightness;

  const RecordingFooter({
    super.key,
    required this.state,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = state is RecordingDoneState;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isDone)
          SizedBox(
            height: 50.sp,
            child: CupertinoButton.filled(
              borderRadius: BorderRadius.circular(AppRadius.standard),
              padding: EdgeInsets.zero,
              onPressed: (state as RecordingDoneState).text.trim().isEmpty
                  ? null
                  : () => context.read<RecordingCubit>().saveEntry(),
              child: Text(AppStrings.save,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textOnPrimary, fontWeight: FontWeight.w600)),
            ),
          )
        else if (state is RecordingIdleState || state is RecordingErrorState)
          SizedBox(
            height: 36.h,
            child: CupertinoButton(
              color: AppColors.surface(2, brightness),
              borderRadius: BorderRadius.circular(AppRadius.standard),
              padding: EdgeInsets.zero,
              onPressed: () => context.read<RecordingCubit>().startRecording(),
              child: Text(AppStrings.startRecordingText,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.onSurface(brightness), fontWeight: FontWeight.w600)),
            ),
          ),
      ],
    );
  }
}
