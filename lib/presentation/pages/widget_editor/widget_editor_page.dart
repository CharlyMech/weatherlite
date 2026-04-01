import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/weather_entity.dart';
import '../../../domain/entities/widget_config.dart';
import '../../blocs/widget_layout/widget_layout_bloc.dart';
import '../../blocs/widget_layout/widget_layout_event.dart';
import '../../blocs/widget_layout/widget_layout_state.dart';
import '../../widgets/common/adaptive_back_button.dart';
import '../../widgets/layout/editable_grid.dart';
import '../../widgets/weather_widgets/weather_widget_factory.dart';

class WidgetEditorPage extends StatelessWidget {
  final Weather weather;

  const WidgetEditorPage({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AdaptiveBackButton(),
        title: const Text('Edit Layout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            tooltip: 'Reset to default',
            onPressed: () {
              context.read<WidgetLayoutBloc>().add(ResetLayout());
            },
          ),
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Done',
            onPressed: () {
              context.read<WidgetLayoutBloc>().add(SaveLayout());
              context.read<WidgetLayoutBloc>().add(ToggleEditMode());
              context.pop();
            },
          ),
        ],
      ),
      body: BlocBuilder<WidgetLayoutBloc, WidgetLayoutState>(
        builder: (context, state) {
          if (state is! WidgetLayoutLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: EditableGrid(
              widgets: state.widgets,
              weather: weather,
              isEditing: true,
              onRemove: (id) {
                context.read<WidgetLayoutBloc>().add(RemoveWidget(id));
              },
              onMove: (id, row, col) {
                context.read<WidgetLayoutBloc>().add(MoveWidget(id, row, col));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddWidgetSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddWidgetSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Widget',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: WeatherWidgetType.values.map((type) {
                  return ActionChip(
                    avatar: Icon(
                      WeatherWidgetFactory.icon(type),
                      size: 18,
                    ),
                    label: Text(WeatherWidgetFactory.label(type)),
                    onPressed: () {
                      final id =
                          '${type.name}_${DateTime.now().millisecondsSinceEpoch}';
                      final layoutState =
                          context.read<WidgetLayoutBloc>().state;
                      final order = layoutState is WidgetLayoutLoaded
                          ? layoutState.widgets.length
                          : 0;

                      context.read<WidgetLayoutBloc>().add(
                            AddWidget(WidgetConfig(
                              id: id,
                              type: type,
                              row: 99,
                              col: 0,
                              spanX:
                                  type == WeatherWidgetType.hourlyChart ||
                                          type == WeatherWidgetType.dailyChart
                                      ? 2
                                      : 1,
                              spanY: type == WeatherWidgetType.temperature
                                  ? 2
                                  : 1,
                              order: order,
                            )),
                          );
                      Navigator.pop(ctx);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
