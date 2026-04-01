import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../domain/entities/weather_entity.dart';
import 'weather_card.dart';

class HumidityWidget extends StatelessWidget {
  final Weather weather;

  const HumidityWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HUMIDITY',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.appColors.inactive,
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: weather.humidity / 100),
                duration: AppAnimations.slow,
                curve: AppAnimations.curve,
                builder: (context, value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: value,
                        strokeWidth: 6,
                        backgroundColor: context.glassColor,
                        valueColor: const AlwaysStoppedAnimation(
                          Color(0xFF64FFDA),
                        ),
                      ),
                      Text(
                        '${(value * 100).round()}%',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    ).animate().fadeIn(
          duration: AppAnimations.medium,
          delay: 200.ms,
        );
  }
}
