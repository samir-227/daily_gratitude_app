import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';

class AudioSavedIndicator extends StatelessWidget {
  final Brightness brightness;

  const AudioSavedIndicator({super.key, required this.brightness});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.mic_fill, size: 14.w,
          color: AppColors.onSurface(brightness, tertiary: true)),
        SizedBox(width: kSpace8),
        Text(AppStrings.audioSavedWithEntry,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.onSurface(brightness, tertiary: true))),
      ],
    );
  }
}
