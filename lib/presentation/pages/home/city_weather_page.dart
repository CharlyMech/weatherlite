import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/animations/app_animations.dart';
import '../../../domain/entities/location_entity.dart';
import '../../blocs/weather/weather_bloc.dart';
import '../../blocs/weather/weather_event.dart';
import '../../blocs/weather/weather_state.dart';

class CityWeatherPage extends StatefulWidget {
  final LocationEntity location;

  const CityWeatherPage({super.key, required this.location});

  @override
  State<CityWeatherPage> createState() => _CityWeatherPageState();
}

class _CityWeatherPageState extends State<CityWeatherPage> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(
      FetchWeather(widget.location.lat, widget.location.lon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<WeatherBloc>().add(RefreshWeather());
        // Wait for state change
        await context.read<WeatherBloc>().stream.firstWhere(
          (s) => s is WeatherLoaded || s is WeatherError,
        );
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        children: [
          // City name
          Text(
                widget.location.name,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.white54),
                textAlign: TextAlign.center,
              )
              .animate()
              .fadeIn(duration: AppAnimations.medium)
              .slideY(begin: -0.1, curve: AppAnimations.curve),

          const SizedBox(height: 8),

          // Weather content
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is WeatherLoaded) {
                final w = state.weather;
                return Column(
                  children: [
                    Text(
                          "${w.temperature.round()}°",
                          style: Theme.of(context).textTheme.displayLarge,
                        )
                        .animate()
                        .fadeIn(duration: AppAnimations.medium)
                        .slideY(begin: 0.05, curve: AppAnimations.curve),

                    const SizedBox(height: 4),

                    Text(
                      "Feels like ${w.apparentTemperature.round()}°",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).animate().fadeIn(
                      duration: AppAnimations.medium,
                      delay: 100.ms,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "H:${w.todayMax.round()}°  L:${w.todayMin.round()}°",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).animate().fadeIn(
                      duration: AppAnimations.medium,
                      delay: 200.ms,
                    ),

                    const SizedBox(height: 32),

                    // Quick stats row
                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _StatChip(
                              icon: Icons.air,
                              label: "${w.windSpeed.round()} km/h",
                            ),
                            _StatChip(
                              icon: Icons.water_drop,
                              label: "${w.humidity.round()}%",
                            ),
                            _StatChip(
                              icon: Icons.wb_sunny,
                              label: "UV ${w.uvIndex.round()}",
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(duration: AppAnimations.medium, delay: 300.ms)
                        .slideY(begin: 0.1, curve: AppAnimations.curve),
                  ],
                );
              }

              if (state is WeatherError) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.cloud_off, size: 48),
                        const SizedBox(height: 12),
                        Text(state.message),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox(height: 300);
            },
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white54),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
