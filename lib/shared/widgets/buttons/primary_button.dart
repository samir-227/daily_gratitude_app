import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/tokens/app_colors.dart';
import '../../../core/theme/tokens/app_typography.dart';
import '../../../core/theme/tokens/app_spacing.dart';
import '../../../core/theme/tokens/app_radius.dart';
import '../../../core/constants/app_animations.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.fast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  bool get _isInteractive => !widget.isDisabled && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: _isInteractive,
      label: widget.label,
      child: GestureDetector(
        onTapDown: _isInteractive
            ? (_) {
                _controller.forward();
                HapticFeedback.mediumImpact();
              }
            : null,
        onTapUp: _isInteractive
            ? (_) {
                _controller.reverse();
                widget.onPressed();
              }
            : null,
        onTapCancel: _isInteractive ? () => _controller.reverse() : null,
        child: ScaleTransition(
          scale: AppAnimations.sanitize(context, _scaleAnimation),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              gradient: _isInteractive
                  ? const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.5),
                        AppColors.primaryDark.withValues(alpha: 0.5),
                      ],
                    ),
              borderRadius: BorderRadius.circular(AppRadius.standard),
              boxShadow: _isInteractive
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.isLoading)
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CupertinoActivityIndicator(
                      color: AppColors.textOnPrimary,
                    ),
                  )
                else if (widget.icon != null) ...[
                  Icon(widget.icon, color: AppColors.textOnPrimary, size: 20.w),
                  SizedBox(width: AppSpacing.sm),
                ],
                Text(
                  widget.label,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textOnPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
