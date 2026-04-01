import 'package:equatable/equatable.dart';

enum WeatherWidgetType {
  temperature,
  wind,
  rain,
  humidity,
  uv,
  sunrise,
  hourlyChart,
  dailyChart,
}

class WidgetConfig extends Equatable {
  final String id;
  final WeatherWidgetType type;
  final int row;
  final int col;
  final int spanX;
  final int spanY;
  final int order;

  const WidgetConfig({
    required this.id,
    required this.type,
    required this.row,
    required this.col,
    this.spanX = 1,
    this.spanY = 1,
    required this.order,
  });

  WidgetConfig copyWith({
    int? row,
    int? col,
    int? spanX,
    int? spanY,
    int? order,
  }) {
    return WidgetConfig(
      id: id,
      type: type,
      row: row ?? this.row,
      col: col ?? this.col,
      spanX: spanX ?? this.spanX,
      spanY: spanY ?? this.spanY,
      order: order ?? this.order,
    );
  }

  static List<WidgetConfig> defaultLayout() {
    return const [
      WidgetConfig(
        id: 'temp_main',
        type: WeatherWidgetType.temperature,
        row: 0, col: 0, spanX: 2, spanY: 2, order: 0,
      ),
      WidgetConfig(
        id: 'hourly_main',
        type: WeatherWidgetType.hourlyChart,
        row: 2, col: 0, spanX: 2, spanY: 1, order: 1,
      ),
      WidgetConfig(
        id: 'wind_main',
        type: WeatherWidgetType.wind,
        row: 3, col: 0, spanX: 1, spanY: 1, order: 2,
      ),
      WidgetConfig(
        id: 'humidity_main',
        type: WeatherWidgetType.humidity,
        row: 3, col: 1, spanX: 1, spanY: 1, order: 3,
      ),
      WidgetConfig(
        id: 'uv_main',
        type: WeatherWidgetType.uv,
        row: 4, col: 0, spanX: 1, spanY: 1, order: 4,
      ),
      WidgetConfig(
        id: 'sunrise_main',
        type: WeatherWidgetType.sunrise,
        row: 4, col: 1, spanX: 1, spanY: 1, order: 5,
      ),
      WidgetConfig(
        id: 'daily_main',
        type: WeatherWidgetType.dailyChart,
        row: 5, col: 0, spanX: 2, spanY: 1, order: 6,
      ),
    ];
  }

  @override
  List<Object?> get props => [id, type, row, col, spanX, spanY, order];
}
