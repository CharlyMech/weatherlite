import '../../../domain/entities/widget_config.dart';

abstract class WidgetLayoutEvent {}

class LoadLayout extends WidgetLayoutEvent {
  final String locationId;
  LoadLayout(this.locationId);
}

class AddWidget extends WidgetLayoutEvent {
  final WidgetConfig config;
  AddWidget(this.config);
}

class RemoveWidget extends WidgetLayoutEvent {
  final String widgetId;
  RemoveWidget(this.widgetId);
}

class MoveWidget extends WidgetLayoutEvent {
  final String widgetId;
  final int newRow;
  final int newCol;

  MoveWidget(this.widgetId, this.newRow, this.newCol);
}

class ResizeWidget extends WidgetLayoutEvent {
  final String widgetId;
  final int newSpanX;
  final int newSpanY;

  ResizeWidget(this.widgetId, this.newSpanX, this.newSpanY);
}

class ReorderWidgets extends WidgetLayoutEvent {
  final List<WidgetConfig> widgets;
  ReorderWidgets(this.widgets);
}

class SaveLayout extends WidgetLayoutEvent {}

class ResetLayout extends WidgetLayoutEvent {}

class ToggleEditMode extends WidgetLayoutEvent {}
