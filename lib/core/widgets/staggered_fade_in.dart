import 'package:flutter/widgets.dart';

class StaggeredFadeIn extends StatelessWidget {
  final int index;
  final Widget child;
  final double offset;

  const StaggeredFadeIn({
    super.key,
    required this.index,
    required this.child,
    this.offset = 20,
  });

  @override
  Widget build(BuildContext context) {
    final delay = (index * 80 / 400).clamp(0.0, 0.8);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Interval(delay, 1.0, curve: Curves.easeOutCubic),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, offset * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
