import 'package:weatherlite/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(double lat, double lon);
  Future<void> clearCache(double lat, double lon);
}
