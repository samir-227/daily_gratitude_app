import 'package:flutter/cupertino.dart';
import '../../../core/theme/tokens/app_colors.dart';
import '../../../core/theme/tokens/app_typography.dart';
import '../../../core/theme/tokens/app_spacing.dart';
import '../../../core/theme/tokens/app_radius.dart';

class AppBottomSheet {
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required Widget child,
    double? height,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (context) => Semantics(
        label: title,
        child: Container(
          height: height ?? MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: AppColors.surface1,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.generous),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 36,
                height: 4,
                margin: EdgeInsets.only(top: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.outline,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: AppColors.textTertiary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: AppColors.divider,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
