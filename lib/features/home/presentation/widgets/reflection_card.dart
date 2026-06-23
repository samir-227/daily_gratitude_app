import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_theme.dart';

class ReflectionCard extends StatelessWidget {
  final VoidCallback onRecordTap;
  final Brightness brightness;

  const ReflectionCard({
    super.key,
    required this.onRecordTap,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
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
}
