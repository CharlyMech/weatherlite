import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconoir_flutter/regular/edit_pencil.dart' as iconoir_edit;
import 'package:weatherlite/core/router/app_router.dart';
import 'package:weatherlite/presentation/blocs/location/locations_bloc.dart';
import 'package:weatherlite/presentation/blocs/location/locations_state.dart';

import '../../../domain/entities/location_entity.dart';
import '../../blocs/weather/weather_bloc.dart';
import '../../blocs/weather/weather_event.dart';
import '../../blocs/widget_layout/widget_layout_bloc.dart';
import '../../blocs/widget_layout/widget_layout_event.dart';
import '../../blocs/widget_layout/widget_layout_state.dart';
import '../../widgets/layout/city_page_indicator.dart';
import '../../widgets/layout/widget_picker_sheet.dart';
import 'city_weather_page.dart';

class HomePage extends StatefulWidget {
  final String? initialLocationId;

  const HomePage({super.key, this.initialLocationId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _didScrollToInitial = false;

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

  void _showWidgetPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<WidgetLayoutBloc>(),
        child: const WidgetPickerSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<LocationsBloc, LocationsState>(
            builder: (context, state) {
              if (state is LocationsLoaded && state.locations.isNotEmpty) {
                final locations = state.locations;

                if (!_didScrollToInitial &&
                    widget.initialLocationId != null) {
                  _didScrollToInitial = true;
                  final idx = locations.indexWhere(
                      (l) => l.id == widget.initialLocationId);
                  if (idx >= 0) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _pageController.jumpToPage(idx);
                      setState(() => _currentPage = idx);
                    });
                  }
                }

                return Stack(
                  children: [
                    // City pages — full screen
                    Positioned.fill(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: locations.length,
                        onPageChanged: (i) => _onPageChanged(i, locations),
                        itemBuilder: (context, index) {
                          return CityWeatherPage(
                            location: locations[index],
                          );
                        },
                      ),
                    ),

                    // Transparent top overlay: indicator + edit button
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 6,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: [
                          const SizedBox(width: 48),
                          Expanded(
                            child: Center(
                              child: CityPageIndicator(
                                count: locations.length,
                                currentIndex: _currentPage,
                                onAddTap: () =>
                                    context.push(AppRoutes.addCity),
                              ),
                            ),
                          ),
                          BlocBuilder<WidgetLayoutBloc, WidgetLayoutState>(
                            builder: (context, layoutState) {
                              final isEditing =
                                  layoutState is WidgetLayoutLoaded &&
                                      layoutState.isEditing;
                              return SizedBox(
                                width: 48,
                                child: IconButton(
                                  icon: isEditing
                                      ? Icon(
                                          Icons.check,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        )
                                      : iconoir_edit.EditPencil(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          width: 22,
                                          height: 22,
                                        ),
                                  onPressed: () {
                                    context
                                        .read<WidgetLayoutBloc>()
                                        .add(ToggleEditMode());
                                    if (!isEditing) {
                                      _showWidgetPicker(context);
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ],
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
                    Icon(
                      Icons.cloud_queue,
                      size: 64,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.24),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'WeatherLite',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add a city to get started',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.54),
                      ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () => context.push(AppRoutes.addCity),
                      icon: const Icon(Icons.add),
                      label: const Text('Add City'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
