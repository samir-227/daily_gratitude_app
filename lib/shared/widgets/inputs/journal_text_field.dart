import 'package:flutter/cupertino.dart';
import '../../../core/theme/tokens/app_colors.dart';
import '../../../core/theme/tokens/app_typography.dart';
import '../../../core/theme/tokens/app_spacing.dart';
import '../../../core/theme/tokens/app_radius.dart';

class JournalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final int maxLines;
  final int? maxLength;
  final bool autocorrect;

  const JournalTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.maxLines = 5,
    this.maxLength,
    this.autocorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      autocorrect: autocorrect,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textPrimary,
      ),
      placeholder: hintText,
      placeholderStyle: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textTertiary,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppRadius.standard),
        border: Border.all(color: AppColors.outline),
      ),
      padding: EdgeInsets.all(AppSpacing.lg),
      cursorColor: AppColors.primary,
    );
  }
}
