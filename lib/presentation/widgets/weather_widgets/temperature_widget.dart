import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../domain/entities/weather_entity.dart';
import 'weather_card.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;

  const TemperatureWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TEMPERATURE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.appColors.inactive,
              letterSpacing: 1,
            ),
          ),
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: weather.temperature),
              duration: AppAnimations.slow,
              curve: AppAnimations.curve,
              builder: (context, value, _) {
                return Text(
                  '${value.round()}°',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w200,
                    letterSpacing: -2,
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Feels ${weather.apparentTemperature.round()}°',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.54),
                  fontSize: 13,
                ),
              ),
              Text(
                'H:${weather.todayMax.round()}° L:${weather.todayMin.round()}°',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.54),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: AppAnimations.medium).slideY(
          begin: 0.05,
          curve: AppAnimations.curve,
        );
  }
}
