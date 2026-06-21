import 'package:flutter/cupertino.dart';

class AnimatedTabIcon extends StatelessWidget {
  final int tabIndex;
  final int currentIndex;
  final IconData icon;

  const AnimatedTabIcon({
    super.key,
    required this.tabIndex,
    required this.currentIndex,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = tabIndex == currentIndex;
    return AnimatedScale(
      scale: isActive ? 1.2 : 1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: Icon(icon, size: 24),
    );
  }
}
