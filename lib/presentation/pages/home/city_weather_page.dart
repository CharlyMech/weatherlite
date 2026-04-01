import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/animations/app_animations.dart';
import '../../../domain/entities/location_entity.dart';
import '../../../domain/entities/widget_config.dart';
import '../../blocs/weather/weather_bloc.dart';
import '../../blocs/weather/weather_event.dart';
import '../../blocs/weather/weather_state.dart';
import '../../blocs/widget_layout/widget_layout_bloc.dart';
import '../../blocs/widget_layout/widget_layout_event.dart';
import '../../blocs/widget_layout/widget_layout_state.dart';
import '../../widgets/layout/editable_grid.dart';
import '../../widgets/layout/weather_background.dart';
import '../../widgets/weather_widgets/weather_widget_skeleton.dart';

class CityWeatherPage extends StatefulWidget {
  final LocationEntity location;

  const CityWeatherPage({super.key, required this.location});

  @override
  State<CityWeatherPage> createState() => _CityWeatherPageState();
}

class _CityWeatherPageState extends State<CityWeatherPage> {
  static const _expandedHeight = 280.0;

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _collapseRatio = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<WeatherBloc>().add(
      FetchWeather(widget.location.lat, widget.location.lon),
    );
    context.read<WidgetLayoutBloc>().add(LoadLayout(widget.location.id));
  }

  void _onScroll() {
    final collapsedH =
        kToolbarHeight + MediaQuery.of(context).padding.top;
    final ratio =
        (_scrollController.offset / (_expandedHeight - collapsedH))
            .clamp(0.0, 1.0);
    _collapseRatio.value = ratio;
  }

  @override
  void dispose() {
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
            // Animated weather background
            WeatherBackground(weatherCode: weatherCode),
            // Scrollable content with SliverAppBar
            RefreshIndicator(
              onRefresh: () async {
                context.read<WeatherBloc>().add(ForceRefreshWeather());
                await context.read<WeatherBloc>().stream.firstWhere(
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
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.none,
                      background: _buildExpandedContent(context, weatherState),
                      title: _buildCollapsedTitle(context, weatherState),
                      centerTitle: true,
                      titlePadding: const EdgeInsets.only(bottom: 12),
                    ),
                  ),
                  // Widget grid content
                  SliverToBoxAdapter(
                    child: _buildContent(context, weatherState),
                  ),
                  // Bottom padding for floating navbar + system nav bar
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

  /// Large expanded header — translates up + scales down as we scroll.
  Widget _buildExpandedContent(BuildContext context, WeatherState state) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return ValueListenableBuilder<double>(
      valueListenable: _collapseRatio,
      builder: (context, ratio, _) {
        return Transform.translate(
          offset: Offset(0, ratio * -30),
          child: Transform.scale(
            scale: 1.0 - ratio * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // "My Location" GPS badge
                if (widget.location.isCurrentLocation)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.gps_fixed,
                          size: 12,
                          color: onSurface.withValues(alpha: 0.6)),
                      const SizedBox(width: 4),
                      Text(
                        'My Location',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                // City name
                Text(
                  widget.location.name,
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
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Compact collapsed title row — slides in from below + scales up as we scroll.
  Widget _buildCollapsedTitle(BuildContext context, WeatherState state) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return ValueListenableBuilder<double>(
      valueListenable: _collapseRatio,
      builder: (context, ratio, _) {
        final opacity = (ratio * 2 - 1).clamp(0.0, 1.0);
        if (opacity == 0) return const SizedBox.shrink();

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, (1 - ratio) * 20),
            child: Transform.scale(
              scale: 0.85 + ratio * 0.15,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.location.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (state is WeatherLoaded) ...[
                    const SizedBox(width: 8),
                    Text(
                      '${state.weather.temperature.round()}°',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: onSurface.withValues(alpha: 0.8),
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
                context.read<WidgetLayoutBloc>().add(MoveWidget(id, row, col));
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
              Icon(Icons.cloud_off,
                  size: 48,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.54)),
              const SizedBox(height: 12),
              Text(
                weatherState.message,
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.54)),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox(height: 300);
  }
}
