import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../domain/entities/weather_entity.dart';
import 'weather_card.dart';

class HourlyChartWidget extends StatelessWidget {
  final Weather weather;

  const HourlyChartWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final temps = weather.hourlyTemperatures;
    if (temps.isEmpty) {
      return WeatherCard(
        child: Center(
          child: Text(
            'No hourly data',
            style: TextStyle(
              color: context.appColors.inactive,
            ),
          ),
        ),
      );
    }

    // Show next 24 hours
    final displayTemps = temps.take(24).toList();
    final minTemp = displayTemps.reduce((a, b) => a < b ? a : b);
    final maxTemp = displayTemps.reduce((a, b) => a > b ? a : b);
    final range = (maxTemp - minTemp).clamp(1.0, double.infinity);

    return WeatherCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HOURLY FORECAST',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.appColors.inactive,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 6,
                      getTitlesWidget: (value, meta) {
                        final hour = value.toInt();
                        if (hour % 6 != 0) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${hour}h',
                            style: TextStyle(
                              fontSize: 10,
                              color: context.appColors.inactive,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minY: minTemp - range * 0.1,
                maxY: maxTemp + range * 0.1,
                lineBarsData: [
                  LineChartBarData(
                    spots: displayTemps
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value))
                        .toList(),
                    isCurved: true,
                    color: const Color(0xFF64FFDA),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF64FFDA).withValues(alpha: 0.1),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) => spots.map((spot) {
                      return LineTooltipItem(
                        '${spot.y.round()}°',
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList(),
                  ),
                ),
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
