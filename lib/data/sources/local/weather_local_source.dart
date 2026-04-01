import 'package:weatherlite/domain/entities/weather_entity.dart';

import '../../../storage/isar/services/isar_service.dart';

class WeatherLocalSource {
  final IsarService isarService;

  WeatherLocalSource(this.isarService);

  Future<Weather?> getCachedWeather(String locationId) {
    return isarService.getWeatherCache(locationId);
  }

  Future<void> cacheWeather(String locationId, Weather weather) {
    return isarService.putWeatherCache(locationId, weather);
  }

  Future<void> clearCacheForLocation(String locationId) {
    return isarService.deleteWeatherCache(locationId);
  }
}
