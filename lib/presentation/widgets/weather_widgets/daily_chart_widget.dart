import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../domain/entities/weather_entity.dart';
import 'weather_card.dart';

class DailyChartWidget extends StatelessWidget {
  final Weather weather;

  const DailyChartWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final maxTemps = weather.dailyMax;
    final minTemps = weather.dailyMin;

    if (maxTemps.isEmpty || minTemps.isEmpty) {
      return WeatherCard(
        child: Center(
          child: Text(
            'No daily data',
            style: TextStyle(
              color: context.appColors.inactive,
            ),
          ),
        ),
      );
    }

    final days = math.min(maxTemps.length, minTemps.length);
    final allTemps = [...maxTemps.take(days), ...minTemps.take(days)];
    final globalMin = allTemps.reduce(math.min);
    final globalMax = allTemps.reduce(math.max);
    final range = (globalMax - globalMin).clamp(1.0, double.infinity);

    final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return WeatherCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DAILY FORECAST',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.appColors.inactive,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BarChart(
              BarChartData(
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
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        final now = DateTime.now();
                        final day = now.add(Duration(days: idx));
                        final label = idx < dayLabels.length
                            ? dayLabels[day.weekday - 1]
                            : '';
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            label,
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
                minY: globalMin - range * 0.15,
                maxY: globalMax + range * 0.15,
                barGroups: List.generate(days, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        fromY: minTemps[i],
                        toY: maxTemps[i],
                        width: 12,
                        borderRadius: BorderRadius.circular(4),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xFF1E88E5), Color(0xFFFF7043)],
                        ),
                      ),
                    ],
                  );
                }),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        'H:${rod.toY.round()}° L:${rod.fromY.round()}°',
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
          duration: AppAnimations.medium,
          delay: 350.ms,
        );
  }
}
