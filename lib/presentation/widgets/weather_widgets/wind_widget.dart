import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../domain/entities/weather_entity.dart';
import 'weather_card.dart';

class WindWidget extends StatelessWidget {
  final Weather weather;

  const WindWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WIND',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.appColors.inactive,
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0,
                end: weather.windDirection * math.pi / 180,
              ),
              duration: AppAnimations.slow,
              curve: AppAnimations.curve,
              builder: (context, angle, child) {
                return Transform.rotate(
                  angle: angle,
                  child: Icon(
                    Icons.navigation,
                    size: 36,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          Center(
            child: Text(
              '${weather.windSpeed.round()} km/h',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
          duration: AppAnimations.medium,
          delay: 100.ms,
        );
  }
}
