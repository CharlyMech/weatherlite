import 'package:isar/isar.dart';

part 'widget_layout_schema.g.dart';

@collection
class WidgetLayoutModel {
  Id isarId = Isar.autoIncrement;

  @Index()
  late String locationId;

  late String
  widgetType; // temperature, wind, rain, humidity, uv, sunrise, hourlyChart, dailyChart
  late int row;
  late int col;
  late int spanX;
  late int spanY;
  late int order;
}
