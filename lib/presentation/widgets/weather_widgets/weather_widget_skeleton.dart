import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/theme_extensions.dart';

class WeatherWidgetSkeleton extends StatefulWidget {
  final double? height;

  const WeatherWidgetSkeleton({super.key, this.height});

  @override
  State<WeatherWidgetSkeleton> createState() => _WeatherWidgetSkeletonState();
}

class _WeatherWidgetSkeletonState extends State<WeatherWidgetSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = context.glassColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value;
            final alpha = lerpDouble(0.08, 0.28, t)!;
            return Container(
              height: widget.height,
              decoration: BoxDecoration(
                color: base.withValues(alpha: alpha),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: context.appColors.outline.withValues(alpha: 0.15),
                  width: 1.2,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
