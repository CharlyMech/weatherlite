import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../domain/entities/weather_entity.dart';
import 'weather_card.dart';

class RainWidget extends StatelessWidget {
  final Weather weather;

  const RainWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final prob = weather.precipitationProb;

    return WeatherCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RAIN',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.appColors.inactive,
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          Center(
            child: Text(
              '${prob.round()}%',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: prob / 100),
            duration: AppAnimations.slow,
            curve: AppAnimations.curve,
            builder: (context, value, _) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 6,
                  backgroundColor: context.glassColor,
                  valueColor: AlwaysStoppedAnimation(
                    Color.lerp(
                      const Color(0xFF64FFDA),
                      const Color(0xFF1E88E5),
                      value,
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
        ],
      ),
    ).animate().fadeIn(
          duration: AppAnimations.medium,
          delay: 150.ms,
        );
  }
}
