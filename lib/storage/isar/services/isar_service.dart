import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weatherlite/domain/entities/weather_entity.dart';

import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/location_entity.dart';
import '../schemas/location_schema.dart';
import '../schemas/weather_cache_schema.dart';
import '../schemas/widget_layout_schema.dart';

class IsarService {
  late final Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      LocationModelSchema,
      WeatherCacheModelSchema,
      WidgetLayoutModelSchema,
    ], directory: dir.path);
  }

  // ── Locations ──

  Future<void> putLocation(LocationEntity entity) async {
    await isar.writeTxn(() async {
      // Remove existing with same id
      final existing = await isar.locationModels
          .where()
          .idEqualTo(entity.id)
          .findFirst();
      if (existing != null) {
        await isar.locationModels.delete(existing.isarId);
      }

      final model = LocationModel()
        ..id = entity.id
        ..name = entity.name
        ..country = entity.country
        ..region = entity.region
        ..lat = entity.lat
        ..lon = entity.lon
        ..isCurrentLocation = entity.isCurrentLocation
        ..order = entity.order;

      await isar.locationModels.put(model);
    });
  }

  Future<List<LocationEntity>> getLocations() async {
    final models = await isar.locationModels.where().sortByOrder().findAll();

    return models
        .map(
          (m) => LocationEntity(
            id: m.id,
            name: m.name,
            country: m.country,
            region: m.region,
            lat: m.lat,
            lon: m.lon,
            isCurrentLocation: m.isCurrentLocation,
            order: m.order,
          ),
        )
        .toList();
  }

  Future<void> deleteLocation(String id) async {
    await isar.writeTxn(() async {
      final model = await isar.locationModels.where().idEqualTo(id).findFirst();
      if (model != null) {
        await isar.locationModels.delete(model.isarId);
      }
    });
  }

  // ── Weather Cache ──

  Future<void> putWeatherCache(String locationId, Weather weather) async {
    await isar.writeTxn(() async {
      final existing = await isar.weatherCacheModels
          .where()
          .locationIdEqualTo(locationId)
          .findFirst();
      if (existing != null) {
        await isar.weatherCacheModels.delete(existing.isarId);
      }

      final model = WeatherCacheModel()
        ..locationId = locationId
        ..temperature = weather.temperature
        ..windSpeed = weather.windSpeed
        ..windDirection = weather.windDirection
        ..apparentTemperature = weather.apparentTemperature
        ..weatherCode = weather.weatherCode
        ..hourlyTemperatures = weather.hourlyTemperatures
        ..hourlyHumidity = weather.hourlyHumidity
        ..hourlyPrecipitationProb = weather.hourlyPrecipitationProb
        ..hourlyUvIndex = weather.hourlyUvIndex
        ..dailyMax = weather.dailyMax
        ..dailyMin = weather.dailyMin
        ..dailySunrise = weather.dailySunrise
        ..dailySunset = weather.dailySunset
        ..lastUpdated = DateTime.now();

      await isar.weatherCacheModels.put(model);
    });
  }

  Future<void> deleteWeatherCache(String locationId) async {
    await isar.writeTxn(() async {
      final existing = await isar.weatherCacheModels
          .where()
          .locationIdEqualTo(locationId)
          .findFirst();
      if (existing != null) {
        await isar.weatherCacheModels.delete(existing.isarId);
      }
    });
  }

  Future<Weather?> getWeatherCache(String locationId) async {
    final model = await isar.weatherCacheModels
        .where()
        .locationIdEqualTo(locationId)
        .findFirst();

    if (model == null) return null;

    final age = DateTime.now().difference(model.lastUpdated);
    if (age.inMinutes > AppConstants.weatherCacheTtlMinutes) return null;

    return Weather(
      temperature: model.temperature,
      windSpeed: model.windSpeed,
      windDirection: model.windDirection,
      apparentTemperature: model.apparentTemperature,
      weatherCode: model.weatherCode,
      hourlyTemperatures: model.hourlyTemperatures,
      hourlyHumidity: model.hourlyHumidity,
      hourlyPrecipitationProb: model.hourlyPrecipitationProb,
      hourlyUvIndex: model.hourlyUvIndex,
      dailyMax: model.dailyMax,
      dailyMin: model.dailyMin,
      dailySunrise: model.dailySunrise,
      dailySunset: model.dailySunset,
    );
  }

  // ── Widget Layout ──

  Future<void> putWidgetLayouts(
    String locationId,
    List<WidgetLayoutModel> layouts,
  ) async {
    await isar.writeTxn(() async {
      // Clear existing
      final existing = await isar.widgetLayoutModels
          .where()
          .locationIdEqualTo(locationId)
          .findAll();
      for (final m in existing) {
        await isar.widgetLayoutModels.delete(m.isarId);
      }

      // Insert new
      await isar.widgetLayoutModels.putAll(layouts);
    });
  }

  Future<List<WidgetLayoutModel>> getWidgetLayouts(String locationId) async {
    return await isar.widgetLayoutModels
        .where()
        .locationIdEqualTo(locationId)
        .sortByOrder()
        .findAll();
  }
}
