import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/theme/theme_extensions.dart';
import '../../../domain/entities/weather_entity.dart';
import '../../../domain/entities/widget_config.dart';
import '../weather_widgets/weather_widget_factory.dart';

class EditableGrid extends StatelessWidget {
  final List<WidgetConfig> widgets;
  final Weather weather;
  final bool isEditing;
  final void Function(String widgetId)? onRemove;
  final void Function(String widgetId, int row, int col)? onMove;

  const EditableGrid({
    super.key,
    required this.widgets,
    required this.weather,
    this.isEditing = false,
    this.onRemove,
    this.onMove,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = List<WidgetConfig>.from(widgets)
      ..sort((a, b) => a.order.compareTo(b.order));

    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: sorted.map((config) {
        Widget child = WeatherWidgetFactory.build(config.type, weather);

        if (isEditing) {
          child = Stack(
            children: [
              child,

              // Delete button
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => onRemove?.call(config.id),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: context.appColors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 14,
                      color: context.appColors.onRed,
                    ),
                  ),
                ),
              ),
            ],
          );

          // Wrap in LongPressDraggable
          child = LongPressDraggable<WidgetConfig>(
            data: config,
            feedback: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Opacity(
                  opacity: 0.8,
                  child: WeatherWidgetFactory.build(config.type, weather),
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: WeatherWidgetFactory.build(config.type, weather),
            ),
            child: child,
          );
        }

        return StaggeredGridTile.count(
          crossAxisCellCount: config.spanX,
          mainAxisCellCount: config.spanY,
          child: child,
        );
      }).toList(),
    );
  }
}
