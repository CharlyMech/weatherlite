import 'package:weatherlite/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<List<LocationEntity>> searchCities(String query);
  Future<LocationEntity> getCurrentLocation();
  Future<List<LocationEntity>> getSavedLocations();
  Future<void> saveLocation(LocationEntity location);
  Future<void> removeLocation(String id);
  Future<void> reorderLocations(List<LocationEntity> locations);
}
