import 'package:flutter/cupertino.dart';
import '../../../core/theme/tokens/app_colors.dart';
import '../../../core/theme/tokens/app_spacing.dart';
import '../../../core/theme/tokens/app_radius.dart';
import '../../../core/constants/app_animations.dart';

class EmotionOption {
  final String id;
  final String emoji;
  final String label;

  const EmotionOption({
    required this.id,
    required this.emoji,
    required this.label,
  });
}

class EmotionSelector extends StatefulWidget {
  final List<EmotionOption> emotions;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  const EmotionSelector({
    super.key,
    required this.emotions,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  State<EmotionSelector> createState() => _EmotionSelectorState();
}

class _EmotionSelectorState extends State<EmotionSelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  String? _animatingId;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: AppAnimations.normal,
      vsync: this,
    );
  }

  void _handleTap(String id) {
    _animatingId = id;
    widget.onSelected(id);
    _pulseController
      ..value = 0.0
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'اختيار المشاعر',
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: widget.emotions.map((emotion) {
          final isSelected = widget.selectedId == emotion.id;
          final isAnimating = _animatingId == emotion.id;

          return Semantics(
            button: true,
            selected: isSelected,
            label: emotion.label,
            child: GestureDetector(
              onTap: () => _handleTap(emotion.id),
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  final scale = isAnimating
                      ? Tween<double>(begin: 1.0, end: 1.15)
                          .animate(_pulseController)
                          .value
                      : 1.0;

                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _emotionColor(emotion.id).withValues(alpha: 0.2)
                        : AppColors.surface2,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(
                      color: isSelected
                          ? _emotionColor(emotion.id)
                          : AppColors.outline,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(emotion.emoji, style: const TextStyle(fontSize: 18)),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        emotion.label,
                        style: TextStyle(
                          color: isSelected
                              ? _emotionColor(emotion.id)
                              : AppColors.textPrimary,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _emotionColor(String id) {
    return switch (id) {
      'joy' => AppColors.emotionJoy,
      'peace' => AppColors.emotionPeace,
      'love' => AppColors.emotionLoved,
      'hope' => AppColors.emotionHope,
      'grounded' => AppColors.emotionGrounded,
      _ => AppColors.primary,
    };
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
}
