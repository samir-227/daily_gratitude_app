import 'package:flutter/cupertino.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 0.5, color: AppColors.divider);
  }
}

class SettingsSwitchTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Brightness brightness;

  const SettingsSwitchTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard, vertical: AppSpacing.tight),
      child: Row(
        children: [
          Text(label,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface(brightness))),
          const Spacer(),
          CupertinoSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class SettingsNavTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Brightness brightness;
  final bool isLast;

  const SettingsNavTile({
    super.key,
    required this.label,
    required this.onTap,
    required this.brightness,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard, vertical: AppSpacing.tight),
      borderRadius: isLast
          ? BorderRadius.only(
              bottomLeft: Radius.circular(AppRadius.standard),
              bottomRight: Radius.circular(AppRadius.standard))
          : BorderRadius.zero,
      onPressed: onTap,
      child: Row(
        children: [
          Text(label,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface(brightness))),
          const Spacer(),
          Icon(CupertinoIcons.chevron_left, color: AppColors.onSurface(brightness, secondary: true), size: 16),
        ],
      ),
    );
  }
}

class SettingsStatusTile extends StatelessWidget {
  final String label;
  final String statusText;
  final Color statusColor;
  final Brightness brightness;

  const SettingsStatusTile({
    super.key,
    required this.label,
    required this.statusText,
    required this.statusColor,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard, vertical: AppSpacing.tight),
      child: Row(
        children: [
          Text(label,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface(brightness))),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.tight, vertical: AppSpacing.compact),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(statusText,
              style: AppTextStyles.labelSmall.copyWith(color: statusColor)),
          ),
        ],
      ),
    );
  }
}

class SettingsActionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final Brightness brightness;
  final bool isLast;
  final bool isDestructive;

  const SettingsActionTile({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    required this.brightness,
    this.isLast = false,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard, vertical: AppSpacing.tight),
      borderRadius: isLast
          ? BorderRadius.only(
              bottomLeft: Radius.circular(AppRadius.standard),
              bottomRight: Radius.circular(AppRadius.standard))
          : BorderRadius.zero,
      onPressed: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: isDestructive ? AppColors.error : AppColors.primary),
          SizedBox(width: AppSpacing.tight),
          Text(label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDestructive ? AppColors.error : AppColors.onSurface(brightness))),
          const Spacer(),
          Icon(CupertinoIcons.chevron_left,
            color: AppColors.onSurface(brightness, secondary: true), size: 16),
        ],
      ),
    );
  }
}

class SettingsInfoTile extends StatelessWidget {
  final String label;
  final String value;
  final Brightness brightness;
  final bool isLast;

  const SettingsInfoTile({
    super.key,
    required this.label,
    required this.value,
    required this.brightness,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard, vertical: AppSpacing.tight),
      child: Row(
        children: [
          Text(label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurface(brightness, secondary: true))),
          const Spacer(),
          Text(value,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface(brightness))),
        ],
      ),
    );
  }
}
