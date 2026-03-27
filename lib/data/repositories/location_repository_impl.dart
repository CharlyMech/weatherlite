import 'package:geolocator/geolocator.dart';
import 'package:weatherlite/core/errors/exceptions.dart';
import 'package:weatherlite/data/mappers/location_mapper.dart';
import 'package:weatherlite/data/sources/remote/geocoding_api_service.dart';
import 'package:weatherlite/domain/entities/location_entity.dart';
import 'package:weatherlite/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final GeocodingApiService geocodingApi;

  // In-memory until Isar is integrated in Phase 17
  final List<LocationEntity> _savedLocations = [];

  LocationRepositoryImpl(this.geocodingApi);

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
        desiredAccuracy: LocationAccuracy.low,
      );

      return LocationEntity(
        id: "current_location",
        name: "My Location",
        country: "",
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
    return List.from(_savedLocations);
  }

  @override
  Future<void> saveLocation(LocationEntity location) async {
    final exists = _savedLocations.any((l) => l.id == location.id);
    if (!exists) {
      _savedLocations.add(location.copyWith(order: _savedLocations.length));
    }
  }

  @override
  Future<void> removeLocation(String id) async {
    _savedLocations.removeWhere((l) => l.id == id);
    // Reindex
    for (int i = 0; i < _savedLocations.length; i++) {
      _savedLocations[i] = _savedLocations[i].copyWith(order: i);
    }
  }

  @override
  Future<void> reorderLocations(List<LocationEntity> locations) async {
    _savedLocations.clear();
    for (int i = 0; i < locations.length; i++) {
      _savedLocations.add(locations[i].copyWith(order: i));
    }
  }
}
