import 'package:flutter/cupertino.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';

class SettingsSectionHeader extends StatelessWidget {
  final String title;
  final Brightness brightness;

  const SettingsSectionHeader({
    super.key,
    required this.title,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.compact),
      child: Text(title,
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.onSurface(brightness, secondary: true))),
    );
  }
}
