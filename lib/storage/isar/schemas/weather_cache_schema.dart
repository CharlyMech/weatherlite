import 'package:isar/isar.dart';

part 'weather_cache_schema.g.dart';

@collection
class WeatherCacheModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String locationId;

  late double temperature;
  late double windSpeed;
  late double windDirection;
  late double apparentTemperature;
  late int weatherCode;
  late List<double> hourlyTemperatures;
  late List<double> hourlyHumidity;
  late List<double> hourlyPrecipitationProb;
  late List<double> hourlyUvIndex;
  late List<double> dailyMax;
  late List<double> dailyMin;
  late List<String> dailySunrise;
  late List<String> dailySunset;

  late DateTime lastUpdated;
}
