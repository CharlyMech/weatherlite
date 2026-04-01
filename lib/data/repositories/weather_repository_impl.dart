import 'package:weatherlite/data/mappers/weather_mapper.dart';
import 'package:weatherlite/data/sources/local/weather_local_source.dart';
import 'package:weatherlite/data/sources/remote/weather_api_service.dart';
import 'package:weatherlite/domain/entities/weather_entity.dart';
import 'package:weatherlite/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService api;
  final WeatherLocalSource? localSource;

  WeatherRepositoryImpl(this.api, {this.localSource});

  @override
  Future<Weather> getWeather(double lat, double lon) async {
    final locationId = "${lat}_$lon";

    // Try cache first
    if (localSource != null) {
      final cached = await localSource!.getCachedWeather(locationId);
      if (cached != null) return cached;
    }

    // Fetch remote
    final dto = await api.fetchWeather(lat, lon);
    final weather = WeatherMapper.fromDto(dto);

    // Store in cache
    if (localSource != null) {
      await localSource!.cacheWeather(locationId, weather);
    }

    return weather;
  }

  @override
  Future<void> clearCache(double lat, double lon) async {
    final locationId = "${lat}_$lon";
    await localSource?.clearCacheForLocation(locationId);
  }
}
