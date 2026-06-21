import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/tokens/app_colors.dart';
import '../../../core/theme/tokens/app_spacing.dart';
import '../../../core/theme/tokens/app_radius.dart';

enum SnackbarType { success, error, warning, info }

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    final color = switch (type) {
      SnackbarType.success => AppColors.success,
      SnackbarType.error => AppColors.error,
      SnackbarType.warning => AppColors.warning,
      SnackbarType.info => AppColors.info,
    };

    final icon = switch (type) {
      SnackbarType.success => CupertinoIcons.checkmark_alt_circle_fill,
      SnackbarType.error => CupertinoIcons.exclamationmark_circle_fill,
      SnackbarType.warning => CupertinoIcons.exclamationmark_triangle_fill,
      SnackbarType.info => CupertinoIcons.info_circle_fill,
    };

    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        child: Semantics(
          liveRegion: true,
          label: message,
          child: GestureDetector(
            onTap: () => entry.remove(),
            child: Container(
              padding: EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surface3,
                borderRadius: BorderRadius.circular(AppRadius.standard),
                border: Border.all(color: color, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.2),
                    blurRadius: 12.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(icon, color: color, size: 20),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  ),
                  if (actionLabel != null) ...[
                    SizedBox(width: AppSpacing.sm),
                    GestureDetector(
                      onTap: () {
                        entry.remove();
                        onAction?.call();
                      },
                      child: Text(
                        actionLabel,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(duration, () {
      if (entry.mounted) entry.remove();
    });
  }
}
