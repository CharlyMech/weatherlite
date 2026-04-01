import 'package:geolocator/geolocator.dart';
import 'package:weatherlite/core/errors/exceptions.dart';
import 'package:weatherlite/data/mappers/location_mapper.dart';
import 'package:weatherlite/data/sources/local/location_local_source.dart';
import 'package:weatherlite/data/sources/remote/geocoding_api_service.dart';
import 'package:weatherlite/domain/entities/location_entity.dart';
import 'package:weatherlite/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final GeocodingApiService geocodingApi;
  final LocationLocalSource localSource;

  LocationRepositoryImpl(this.geocodingApi, {required this.localSource});

  @override
  Future<List<LocationEntity>> searchCities(String query) async {
    try {
      final dtos = await geocodingApi.searchCities(query);
      return dtos.map((dto) => LocationMapper.fromDto(dto)).toList();
    } catch (e) {
      throw NetworkException("Search failed: $e");
    }
  }

  @override
  Future<LocationEntity> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw const LocationException("Location services disabled");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw const LocationException("Location permission denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw const LocationException("Location permission permanently denied");
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );

      // Try to get real city name via reverse geocoding
      final place = await geocodingApi
          .reverseGeocode(position.latitude, position.longitude)
          .timeout(const Duration(seconds: 4))
          .catchError((_) => null);

      return LocationEntity(
        id: "current_location",
        name: place?.city ?? "My Location",
        country: place?.country ?? "",
        lat: position.latitude,
        lon: position.longitude,
        isCurrentLocation: true,
        order: -1,
      );
    } catch (e) {
      if (e is LocationException) rethrow;
      throw LocationException("Failed to get location: $e");
    }
  }

  @override
  Future<List<LocationEntity>> getSavedLocations() async {
    return localSource.getLocations();
  }

  @override
  Future<void> saveLocation(LocationEntity location) async {
    final existing = await localSource.getLocations();
    final exists = existing.any((l) => l.id == location.id);
    if (exists) {
      // Always update current_location so coords and name stay fresh
      if (location.isCurrentLocation) {
        await localSource.saveLocation(location);
      }
    } else {
      await localSource.saveLocation(
        location.copyWith(order: existing.length),
      );
    }
  }

  @override
  Future<void> removeLocation(String id) async {
    await localSource.deleteLocation(id);
    // Reindex remaining locations
    final locations = await localSource.getLocations();
    for (int i = 0; i < locations.length; i++) {
      await localSource.saveLocation(locations[i].copyWith(order: i));
    }
  }

  @override
  Future<void> reorderLocations(List<LocationEntity> locations) async {
    for (int i = 0; i < locations.length; i++) {
      await localSource.saveLocation(locations[i].copyWith(order: i));
    }
  }
}
