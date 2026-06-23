import 'package:flutter/cupertino.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';
import '../bloc/recording_cubit.dart';

class LiveTextDisplay extends StatelessWidget {
  final RecordingInProgressState state;
  final Brightness brightness;

  const LiveTextDisplay({
    super.key,
    required this.state,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    if (state.liveText.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(kSpace12),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
      ),
      child: Text(state.liveText,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.onSurface(brightness), height: 1.6)),
    );
  }
}
