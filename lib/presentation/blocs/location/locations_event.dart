import 'package:weatherlite/domain/entities/location_entity.dart';

abstract class LocationsEvent {}

class LoadLocations extends LocationsEvent {}

class SearchCities extends LocationsEvent {
  final String query;
  SearchCities(this.query);
}

class ClearSearch extends LocationsEvent {}

class AddLocation extends LocationsEvent {
  final LocationEntity location;
  AddLocation(this.location);
}

class RemoveLocation extends LocationsEvent {
  final String id;
  RemoveLocation(this.id);
}

class ReorderLocations extends LocationsEvent {
  final List<LocationEntity> locations;
  ReorderLocations(this.locations);
}

class DetectCurrentLocation extends LocationsEvent {}
