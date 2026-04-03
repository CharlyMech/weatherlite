import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/animations/app_animations.dart';
import '../../../data/repositories/location_repository_impl.dart';
import '../../../domain/entities/location_entity.dart';
import '../../../domain/entities/widget_config.dart';
import '../../blocs/location/locations_bloc.dart';
import '../../blocs/location/locations_event.dart';
import '../../blocs/weather/weather_bloc.dart';
import '../../blocs/weather/weather_event.dart';
import '../../blocs/weather/weather_state.dart';
import '../../blocs/widget_layout/widget_layout_bloc.dart';
import '../../blocs/widget_layout/widget_layout_event.dart';
import '../../blocs/widget_layout/widget_layout_state.dart';
import '../../widgets/layout/editable_grid.dart';
import '../../widgets/weather_widgets/weather_widget_skeleton.dart';

class CityWeatherPage extends StatefulWidget {
  final LocationEntity location;

  const CityWeatherPage({super.key, required this.location});

  @override
  State<CityWeatherPage> createState() => _CityWeatherPageState();
}

class _CityWeatherPageState extends State<CityWeatherPage> {
  static const _expandedHeight = 280.0;
  static const _refreshInterval = Duration(minutes: 15);

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _collapseRatio = ValueNotifier(0.0);
  Timer? _periodicTimer;
  LocationEntity _location = const LocationEntity(
    id: '',
    name: '',
    country: '',
    lat: 0,
    lon: 0,
    isCurrentLocation: false,
    order: 0,
  );

  @override
  void initState() {
    super.initState();
    _location = widget.location;
    _scrollController.addListener(_onScroll);
    context.read<WeatherBloc>().add(FetchWeather(_location.lat, _location.lon));
    context.read<WidgetLayoutBloc>().add(LoadLayout(_location.id));

    if (_location.isCurrentLocation) {
      _periodicTimer = Timer.periodic(_refreshInterval, (_) {
        _refreshCurrentLocation();
      });
    }
  }

  Future<void> _refreshCurrentLocation() async {
    if (!_location.isCurrentLocation) return;
    try {
      final locationRepo = context.read<LocationRepositoryImpl>();
      final updated = await locationRepo.getCurrentLocation();
      await locationRepo.saveLocation(updated);
      if (mounted) {
        _location = updated;
        context.read<LocationsBloc>().add(LoadLocations());
        context.read<WeatherBloc>().add(FetchWeather(updated.lat, updated.lon));
      }
    } catch (_) {
      if (mounted) {
        context.read<WeatherBloc>().add(ForceRefreshWeather());
      }
    }
  }

  void _onScroll() {
    final collapsedH = kToolbarHeight + MediaQuery.of(context).padding.top;
    final ratio = (_scrollController.offset / (_expandedHeight - collapsedH))
        .clamp(0.0, 1.0);
    _collapseRatio.value = ratio;
  }

  @override
  void dispose() {
    _periodicTimer?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _collapseRatio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, weatherState) {
        final weatherCode = weatherState is WeatherLoaded
            ? weatherState.weather.weatherCode
            : 0;

        return Stack(
          fit: StackFit.expand,
          children: [
            RefreshIndicator(
              edgeOffset: MediaQuery.of(context).padding.top,
              onRefresh: () async {
                final weatherBloc = context.read<WeatherBloc>();
                if (_location.isCurrentLocation) {
                  await _refreshCurrentLocation();
                } else {
                  weatherBloc.add(ForceRefreshWeather());
                }
                await weatherBloc.stream.firstWhere(
                  (s) => s is WeatherLoaded || s is WeatherError,
                );
              },
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: _expandedHeight,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    forceMaterialTransparency: true,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.none,
                      background: _buildExpandedContent(context, weatherState),
                      title: _buildCollapsedTitle(context, weatherState),
                      centerTitle: false,
                      titlePadding: const EdgeInsets.only(left: 16, bottom: 12),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildContent(context, weatherState),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      bottom: 100 + MediaQuery.of(context).padding.bottom,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Large expanded header — vertically centered in the space below the page indicator.
  Widget _buildExpandedContent(BuildContext context, WeatherState state) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final topPad = MediaQuery.of(context).padding.top;

    // Reserve space for status bar + page indicator row
    const pageIndicatorBottom = 64.0;

    return ValueListenableBuilder<double>(
      valueListenable: _collapseRatio,
      builder: (context, ratio, _) {
        // Fade out in the first half of the scroll
        final fadeOpacity = (1.0 - ratio * 2).clamp(0.0, 1.0);
        // Slide content upward aggressively so it visually goes under the collapsing bar
        final slideOffset = ratio * -(_expandedHeight * 0.35);

        return Opacity(
          opacity: fadeOpacity,
          child: Transform.translate(
            offset: Offset(0, slideOffset),
            child: Padding(
              padding: EdgeInsets.only(top: topPad + pageIndicatorBottom),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_location.isCurrentLocation)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.gps_fixed,
                            size: 12,
                            color: onSurface.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'My Location',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    Text(
                      _location.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: onSurface.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (state is WeatherLoaded) ...[
                      Text(
                        '${state.weather.temperature.round()}°',
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: onSurface,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        'H:${state.weather.todayMax.round()}° L:${state.weather.todayMin.round()}°',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Collapsed badge — left-aligned pill, avoids the page indicator in the center.
  Widget _buildCollapsedTitle(BuildContext context, WeatherState state) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return ValueListenableBuilder<double>(
      valueListenable: _collapseRatio,
      builder: (context, ratio, _) {
        // Only appear in the second half of the scroll
        final opacity = ((ratio - 0.5) * 2).clamp(0.0, 1.0);
        if (opacity == 0) return const SizedBox.shrink();

        // Slide up from below as it appears
        final slideY = (1.0 - opacity) * 12.0;

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, slideY),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_location.isCurrentLocation) ...[
                    Icon(
                      Icons.gps_fixed,
                      size: 11,
                      color: onSurface.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    _location.name,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (state is WeatherLoaded) ...[
                    const SizedBox(width: 6),
                    Text(
                      '${state.weather.temperature.round()}°',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: onSurface.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonGrid(BuildContext context) {
    final layout = WidgetConfig.defaultLayout();
    final sorted = List<WidgetConfig>.from(layout)
      ..sort((a, b) => a.order.compareTo(b.order));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        children: sorted.map((config) {
          final height = config.spanY == 2 ? 200.0 : 140.0;
          return StaggeredGridTile.count(
            crossAxisCellCount: config.spanX,
            mainAxisCellCount: config.spanY,
            child: WeatherWidgetSkeleton(height: height),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WeatherState weatherState) {
    if (weatherState is WeatherLoading) {
      return _buildSkeletonGrid(context);
    }

    if (weatherState is WeatherLoaded) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<WidgetLayoutBloc, WidgetLayoutState>(
          builder: (context, layoutState) {
            if (layoutState is! WidgetLayoutLoaded) {
              return _buildSkeletonGrid(context);
            }

            return EditableGrid(
                  widgets: layoutState.widgets,
                  weather: weatherState.weather,
                  isEditing: layoutState.isEditing,
                  onRemove: (id) {
                    context.read<WidgetLayoutBloc>().add(RemoveWidget(id));
                  },
                  onMove: (id, row, col) {
                    context.read<WidgetLayoutBloc>().add(
                      MoveWidget(id, row, col),
                    );
                  },
                )
                .animate()
                .fadeIn(duration: AppAnimations.medium)
                .slideY(begin: 0.03, curve: AppAnimations.curve);
          },
        ),
      );
    }

    if (weatherState is WeatherError) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_off,
                size: 48,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.54),
              ),
              const SizedBox(height: 12),
              Text(
                weatherState.message,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.54),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox(height: 300);
  }
}
