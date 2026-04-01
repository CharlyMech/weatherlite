import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../domain/entities/widget_config.dart';
import '../../blocs/widget_layout/widget_layout_bloc.dart';
import '../../blocs/widget_layout/widget_layout_event.dart';
import '../../blocs/widget_layout/widget_layout_state.dart';
import '../weather_widgets/weather_widget_factory.dart';

/// Natural span for each widget type (spanX, spanY).
const _widgetSpans = {
  WeatherWidgetType.temperature: (x: 2, y: 2),
  WeatherWidgetType.hourlyChart: (x: 2, y: 1),
  WeatherWidgetType.dailyChart: (x: 2, y: 1),
  WeatherWidgetType.wind: (x: 1, y: 1),
  WeatherWidgetType.humidity: (x: 1, y: 1),
  WeatherWidgetType.uv: (x: 1, y: 1),
  WeatherWidgetType.sunrise: (x: 1, y: 1),
  WeatherWidgetType.rain: (x: 1, y: 1),
};

const _sizeLabel = {
  '1x1': 'Small (1×1)',
  '2x1': 'Wide (2×1)',
  '1x2': 'Tall (1×2)',
  '2x2': 'Large (2×2)',
};

String _spanKey(int x, int y) => '${x}x$y';

class WidgetPickerSheet extends StatelessWidget {
  const WidgetPickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.0,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            if (notification.extent < 0.05) {
              context.read<WidgetLayoutBloc>().add(ToggleEditMode());
            }
            return false;
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: context.glassColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                  border: Border.all(
                    color: context.appColors.outline.withValues(alpha: 0.15),
                    width: 1.2,
                  ),
                ),
                child: BlocBuilder<WidgetLayoutBloc, WidgetLayoutState>(
                  builder: (context, state) {
                    final presentTypes = state is WidgetLayoutLoaded
                        ? state.widgets.map((w) => w.type).toSet()
                        : <WeatherWidgetType>{};

                    return ListView(
                      controller: scrollController,
                      padding: EdgeInsets.only(
                        top: 12,
                        bottom: 24 + MediaQuery.of(context).padding.bottom,
                      ),
                      children: [
                        // ── Drag handle ─────────────────────────────────────
                        Center(
                          child: Container(
                            width: 36,
                            height: 4,
                            decoration: BoxDecoration(
                              color: context.appColors.inactive
                                  .withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── Add Location button ──────────────────────────────
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: context.appColors.outline
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.push(AppRoutes.addCity);
                            },
                            icon: const Icon(Icons.add_location_alt_outlined),
                            label: const Text('Add Location'),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── Widget sections by size ──────────────────────────
                        ..._buildSections(context, presentTypes),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildSections(
    BuildContext context,
    Set<WeatherWidgetType> presentTypes,
  ) {
    // Group available types by span key
    final Map<String, List<WeatherWidgetType>> groups = {};
    for (final type in WeatherWidgetType.values) {
      final span = _widgetSpans[type]!;
      final key = _spanKey(span.x, span.y);
      groups.putIfAbsent(key, () => []).add(type);
    }

    // Ordered keys
    const order = ['1x1', '2x1', '1x2', '2x2'];
    final sections = <Widget>[];

    for (final key in order) {
      final types = groups[key];
      if (types == null || types.isEmpty) continue;

      sections.add(
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            _sizeLabel[key] ?? key,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: context.appColors.inactive,
            ),
          ),
        ),
      );

      sections.add(
        _WidgetRow(
          types: types,
          presentTypes: presentTypes,
          spanKey: key,
        ),
      );
      sections.add(const SizedBox(height: 16));
    }

    return sections;
  }
}

class _WidgetRow extends StatelessWidget {
  final List<WeatherWidgetType> types;
  final Set<WeatherWidgetType> presentTypes;
  final String spanKey;

  const _WidgetRow({
    required this.types,
    required this.presentTypes,
    required this.spanKey,
  });

  @override
  Widget build(BuildContext context) {
    final span = spanKey.split('x');
    final spanX = int.parse(span[0]);
    final spanY = int.parse(span[1]);

    // Cell width = (screen - 32 margin - 12 gap) / 2
    final screenW = MediaQuery.of(context).size.width;
    final cellW = (screenW - 32 - 12) / 2;
    // Preview is scaled down to 40% of natural size
    const scale = 0.4;
    final previewW = cellW * spanX * scale;
    final previewH = cellW * spanY * scale * 0.9;

    return SizedBox(
      height: previewH + 32, // +32 for label below
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: types.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final type = types[index];
          final alreadyPresent = presentTypes.contains(type);

          return _WidgetPreviewItem(
            type: type,
            spanX: spanX,
            spanY: spanY,
            previewW: previewW,
            previewH: previewH,
            alreadyPresent: alreadyPresent,
          );
        },
      ),
    );
  }
}

class _WidgetPreviewItem extends StatelessWidget {
  final WeatherWidgetType type;
  final int spanX;
  final int spanY;
  final double previewW;
  final double previewH;
  final bool alreadyPresent;

  const _WidgetPreviewItem({
    required this.type,
    required this.spanX,
    required this.spanY,
    required this.previewW,
    required this.previewH,
    required this.alreadyPresent,
  });

  WidgetConfig _makeConfig() => WidgetConfig(
        id: '${type.name}_${DateTime.now().millisecondsSinceEpoch}',
        type: type,
        row: 99,
        col: 0,
        spanX: spanX,
        spanY: spanY,
        order: 99,
      );

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final label = WeatherWidgetFactory.label(type);
    final icon = WeatherWidgetFactory.icon(type);

    final preview = _PreviewCard(
      width: previewW,
      height: previewH,
      icon: icon,
      label: label,
      dimmed: alreadyPresent,
    );

    if (alreadyPresent) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          preview,
          const SizedBox(height: 6),
          SizedBox(
            width: previewW,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: onSurface.withValues(alpha: 0.3),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    return Draggable<WidgetConfig>(
      data: _makeConfig(),
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.85,
          child: _PreviewCard(
            width: previewW,
            height: previewH,
            icon: icon,
            label: label,
            dimmed: false,
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: preview,
      ),
      onDragEnd: (details) {
        // Add widget to layout when dropped anywhere on screen
        context.read<WidgetLayoutBloc>().add(AddWidget(_makeConfig()));
      },
      child: GestureDetector(
        onTap: () {
          context.read<WidgetLayoutBloc>().add(AddWidget(_makeConfig()));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            preview,
            const SizedBox(height: 6),
            SizedBox(
              width: previewW,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final String label;
  final bool dimmed;

  const _PreviewCard({
    required this.width,
    required this.height,
    required this.icon,
    required this.label,
    required this.dimmed,
  });

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final alpha = dimmed ? 0.3 : 1.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: context.glassColor.withValues(alpha: dimmed ? 0.08 : 0.18),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.appColors.outline.withValues(
                alpha: dimmed ? 0.08 : 0.2,
              ),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: (width * 0.28).clamp(14, 28),
                color: onSurface.withValues(alpha: alpha * 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
