import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/presentation/blocs/location/locations_bloc.dart';
import 'package:weatherlite/presentation/blocs/location/locations_state.dart';

import '../../../domain/entities/location_entity.dart';
import '../../blocs/weather/weather_bloc.dart';
import '../../blocs/weather/weather_event.dart';
import '../../widgets/layout/city_page_indicator.dart';
import '../location/location_page.dart';
import 'city_weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index, List<LocationEntity> locations) {
    setState(() => _currentPage = index);
    if (index < locations.length) {
      final loc = locations[index];
      context.read<WeatherBloc>().add(FetchWeather(loc.lat, loc.lon));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LocationsBloc, LocationsState>(
          builder: (context, state) {
            if (state is LocationsLoaded && state.locations.isNotEmpty) {
              final locations = state.locations;

              return Column(
                children: [
                  // Top bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _openLocationPage(context),
                        ),
                        CityPageIndicator(
                          count: locations.length,
                          currentIndex: _currentPage,
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            // Settings page — Phase 20
                          },
                        ),
                      ],
                    ),
                  ),

                  // City pages
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: locations.length,
                      onPageChanged: (i) => _onPageChanged(i, locations),
                      itemBuilder: (context, index) {
                        return CityWeatherPage(location: locations[index]);
                      },
                    ),
                  ),
                ],
              );
            }

            // Empty state
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cloud_queue,
                    size: 64,
                    color: Colors.white24,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "WeatherLite",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Add a city to get started",
                    style: TextStyle(color: Colors.white54),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _openLocationPage(context),
                    icon: const Icon(Icons.add),
                    label: const Text("Add City"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _openLocationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return BlocProvider.value(
            value: context.read<LocationsBloc>(),
            child: const LocationPage(),
          );
        },
      ),
    );
  }
}
