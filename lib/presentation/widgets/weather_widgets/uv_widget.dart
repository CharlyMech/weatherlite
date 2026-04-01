import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../domain/entities/weather_entity.dart';
import 'weather_card.dart';

class UvWidget extends StatelessWidget {
  final Weather weather;

  const UvWidget({super.key, required this.weather});

  Color _uvColor(double uv) {
    if (uv <= 2) return const Color(0xFF4CAF50);
    if (uv <= 5) return const Color(0xFFFFEB3B);
    if (uv <= 7) return const Color(0xFFFF9800);
    if (uv <= 10) return const Color(0xFFF44336);
    return const Color(0xFF9C27B0);
  }

  String _uvLabel(double uv) {
    if (uv <= 2) return 'Low';
    if (uv <= 5) return 'Moderate';
    if (uv <= 7) return 'High';
    if (uv <= 10) return 'Very High';
    return 'Extreme';
  }

  @override
  Widget build(BuildContext context) {
    final uv = weather.uvIndex;

    return WeatherCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UV INDEX',
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
              uv.round().toString(),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w300,
                color: _uvColor(uv),
              ),
            ),
          ),
          Center(
            child: Text(
              _uvLabel(uv),
              style: TextStyle(
                fontSize: 14,
                color: _uvColor(uv),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    ).animate().fadeIn(
          duration: AppAnimations.medium,
          delay: 250.ms,
        );
  }
}
