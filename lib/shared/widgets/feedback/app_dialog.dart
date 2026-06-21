import 'package:flutter/cupertino.dart';
import '../../../core/theme/tokens/app_colors.dart';
import '../../../core/theme/tokens/app_typography.dart';
import '../../../core/theme/tokens/app_spacing.dart';

class AppDialog {
  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'تأكيد',
    String cancelLabel = 'إلغاء',
    Color? confirmColor,
  }) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => Semantics(
        label: title,
        child: CupertinoAlertDialog(
          title: Text(
            title,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          content: Padding(
            padding: EdgeInsets.only(top: AppSpacing.sm),
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelLabel),
            ),
            CupertinoDialogAction(
              isDestructiveAction: confirmColor == AppColors.error,
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                confirmLabel,
                style: TextStyle(color: confirmColor ?? AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
