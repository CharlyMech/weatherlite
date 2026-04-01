import 'package:equatable/equatable.dart';

import '../../../domain/entities/widget_config.dart';

abstract class WidgetLayoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WidgetLayoutInitial extends WidgetLayoutState {}

class WidgetLayoutLoaded extends WidgetLayoutState {
  final String locationId;
  final List<WidgetConfig> widgets;
  final bool isEditing;

  WidgetLayoutLoaded({
    required this.locationId,
    required this.widgets,
    this.isEditing = false,
  });

  WidgetLayoutLoaded copyWith({
    List<WidgetConfig>? widgets,
    bool? isEditing,
  }) {
    return WidgetLayoutLoaded(
      locationId: locationId,
      widgets: widgets ?? this.widgets,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  @override
  List<Object?> get props => [locationId, widgets, isEditing];
}
