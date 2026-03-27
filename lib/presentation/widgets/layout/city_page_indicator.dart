import 'package:flutter/material.dart';

import '../../../core/animations/app_animations.dart';

class CityPageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const CityPageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: AppAnimations.medium,
          curve: AppAnimations.curve,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive
                ? Theme.of(context).colorScheme.secondary
                : Colors.white24,
          ),
        );
      }),
    );
  }
}
