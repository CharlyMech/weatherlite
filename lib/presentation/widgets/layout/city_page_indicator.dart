import 'package:flutter/material.dart';

import '../../../core/animations/app_animations.dart';

class CityPageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final VoidCallback? onAddTap;

  const CityPageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(count, (index) {
          final isActive = index == currentIndex;
          return AnimatedContainer(
            duration: AppAnimations.medium,
            curve: AppAnimations.curve,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: isActive ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: isActive
                  ? onSurface.withValues(alpha: 0.85)
                  : onSurface.withValues(alpha: 0.3),
            ),
          );
        }),
        if (onAddTap != null)
          GestureDetector(
            onTap: onAddTap,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: onSurface.withValues(alpha: 0.15),
              ),
              child: Icon(
                Icons.add,
                size: 12,
                color: onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
      ],
    );
  }
}
