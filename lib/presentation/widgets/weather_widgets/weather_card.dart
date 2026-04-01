import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/theme_extensions.dart';

class WeatherCard extends StatelessWidget {
  final Widget child;
  final double? height;

  const WeatherCard({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.glassColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: context.appColors.outline.withValues(alpha: 0.15),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
