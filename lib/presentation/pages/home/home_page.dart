import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/presentation/blocs/weather/weather_bloc.dart';
import 'package:weatherlite/presentation/blocs/weather/weather_event.dart';
import 'package:weatherlite/presentation/blocs/weather/weather_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is WeatherLoaded) {
              final w = state.weather;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${w.temperature.round()}°",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Wind ${w.windSpeed.round()} km/h",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }

            if (state is WeatherError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, size: 48),
                    const SizedBox(height: 12),
                    Text(state.message),
                  ],
                ),
              );
            }

            return const Center(
              child: Text(
                "WeatherLite",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<WeatherBloc>().add(FetchWeather(40.4168, -3.7038));
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
