import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../domain/entities/weather_entity.dart';
import 'weather_card.dart';

class SunriseWidget extends StatelessWidget {
  final Weather weather;

  const SunriseWidget({super.key, required this.weather});

  String _formatTime(String isoTime) {
    if (isoTime == '--:--') return isoTime;
    try {
      final dt = DateTime.parse(isoTime);
      final hour = dt.hour.toString().padLeft(2, '0');
      final minute = dt.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } catch (_) {
      return isoTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SUNRISE & SUNSET',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.appColors.inactive,
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    color: context.appColors.sun,
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(weather.sunrise),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Sunrise',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.54),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.nightlight_round,
                    color: context.appColors.night,
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(weather.sunset),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Sunset',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.54),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    ).animate().fadeIn(
          duration: AppAnimations.medium,
          delay: 300.ms,
        );
  }
}
