import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/widget_config.dart';
import '../../../storage/isar/schemas/widget_layout_schema.dart';
import '../../../storage/isar/services/isar_service.dart';
import 'widget_layout_event.dart';
import 'widget_layout_state.dart';

class WidgetLayoutBloc extends Bloc<WidgetLayoutEvent, WidgetLayoutState> {
  final IsarService _isarService;

  WidgetLayoutBloc({required IsarService isarService})
      : _isarService = isarService,
        super(WidgetLayoutInitial()) {
    on<LoadLayout>(_onLoad);
    on<AddWidget>(_onAdd);
    on<RemoveWidget>(_onRemove);
    on<MoveWidget>(_onMove);
    on<ResizeWidget>(_onResize);
    on<ReorderWidgets>(_onReorder);
    on<SaveLayout>(_onSave);
    on<ResetLayout>(_onReset);
    on<ToggleEditMode>(_onToggleEdit);
  }

  Future<void> _onLoad(
    LoadLayout event,
    Emitter<WidgetLayoutState> emit,
  ) async {
    final models = await _isarService.getWidgetLayouts(event.locationId);

    List<WidgetConfig> widgets;
    if (models.isEmpty) {
      widgets = WidgetConfig.defaultLayout();
    } else {
      widgets = models.map((m) {
        return WidgetConfig(
          id: '${m.widgetType}_${m.order}',
          type: WeatherWidgetType.values.firstWhere(
            (t) => t.name == m.widgetType,
            orElse: () => WeatherWidgetType.temperature,
          ),
          row: m.row,
          col: m.col,
          spanX: m.spanX,
          spanY: m.spanY,
          order: m.order,
        );
      }).toList();
    }

    emit(WidgetLayoutLoaded(
      locationId: event.locationId,
      widgets: widgets,
    ));
  }

  void _onAdd(AddWidget event, Emitter<WidgetLayoutState> emit) {
    final current = state;
    if (current is! WidgetLayoutLoaded) return;

    final updated = List<WidgetConfig>.from(current.widgets)..add(event.config);
    emit(current.copyWith(widgets: updated));
  }

  void _onRemove(RemoveWidget event, Emitter<WidgetLayoutState> emit) {
    final current = state;
    if (current is! WidgetLayoutLoaded) return;

    final updated =
        current.widgets.where((w) => w.id != event.widgetId).toList();
    emit(current.copyWith(widgets: updated));
  }

  void _onMove(MoveWidget event, Emitter<WidgetLayoutState> emit) {
    final current = state;
    if (current is! WidgetLayoutLoaded) return;

    final updated = current.widgets.map((w) {
      if (w.id == event.widgetId) {
        return w.copyWith(row: event.newRow, col: event.newCol);
      }
      return w;
    }).toList();

    emit(current.copyWith(widgets: updated));
  }

  void _onResize(ResizeWidget event, Emitter<WidgetLayoutState> emit) {
    final current = state;
    if (current is! WidgetLayoutLoaded) return;

    final updated = current.widgets.map((w) {
      if (w.id == event.widgetId) {
        return w.copyWith(
          spanX: event.newSpanX.clamp(1, 2),
          spanY: event.newSpanY.clamp(1, 2),
        );
      }
      return w;
    }).toList();

    emit(current.copyWith(widgets: updated));
  }

  void _onReorder(ReorderWidgets event, Emitter<WidgetLayoutState> emit) {
    final current = state;
    if (current is! WidgetLayoutLoaded) return;

    final reindexed = event.widgets.asMap().entries.map((e) {
      return e.value.copyWith(order: e.key);
    }).toList();

    emit(current.copyWith(widgets: reindexed));
  }

  Future<void> _onSave(
    SaveLayout event,
    Emitter<WidgetLayoutState> emit,
  ) async {
    final current = state;
    if (current is! WidgetLayoutLoaded) return;

    final models = current.widgets.map((w) {
      return WidgetLayoutModel()
        ..locationId = current.locationId
        ..widgetType = w.type.name
        ..row = w.row
        ..col = w.col
        ..spanX = w.spanX
        ..spanY = w.spanY
        ..order = w.order;
    }).toList();

    await _isarService.putWidgetLayouts(current.locationId, models);
  }

  void _onReset(ResetLayout event, Emitter<WidgetLayoutState> emit) {
    final current = state;
    if (current is! WidgetLayoutLoaded) return;

    emit(WidgetLayoutLoaded(
      locationId: current.locationId,
      widgets: WidgetConfig.defaultLayout(),
      isEditing: current.isEditing,
    ));
  }

  void _onToggleEdit(ToggleEditMode event, Emitter<WidgetLayoutState> emit) {
    final current = state;
    if (current is! WidgetLayoutLoaded) return;

    emit(current.copyWith(isEditing: !current.isEditing));
  }
}
