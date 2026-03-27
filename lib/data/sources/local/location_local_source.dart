import '../../../domain/entities/location_entity.dart';
import '../../../storage/isar/services/isar_service.dart';

class LocationLocalSource {
  final IsarService isarService;

  LocationLocalSource(this.isarService);

  Future<List<LocationEntity>> getLocations() {
    return isarService.getLocations();
  }

  Future<void> saveLocation(LocationEntity location) {
    return isarService.putLocation(location);
  }

  Future<void> deleteLocation(String id) {
    return isarService.deleteLocation(id);
  }
}
