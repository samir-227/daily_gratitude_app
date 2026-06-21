import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/tokens/app_colors.dart';
import '../../../core/theme/tokens/app_typography.dart';
import '../../../core/theme/tokens/app_spacing.dart';
import '../../../core/theme/tokens/app_radius.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  bool get _isInteractive => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: _isInteractive,
      label: label,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(
              color: _isInteractive
                  ? AppColors.primary
                  : AppColors.outline.withValues(alpha: 0.3),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(AppRadius.standard),
            color: const Color(0x00000000),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: CupertinoActivityIndicator(
                    color: AppColors.primary,
                  ),
                )
              else if (icon != null) ...[
                Icon(icon, color: AppColors.primary, size: 18),
                SizedBox(width: AppSpacing.sm),
              ],
              Text(
                label,
                style: AppTextStyles.titleSmall.copyWith(
                  color: _isInteractive
                      ? AppColors.primary
                      : AppColors.outline.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
