import 'package:equatable/equatable.dart';
import 'package:weatherlite/domain/entities/location_entity.dart';

abstract class LocationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationsInitial extends LocationsState {}

class LocationsLoading extends LocationsState {}

class LocationsLoaded extends LocationsState {
  final List<LocationEntity> locations;
  final List<LocationEntity> searchResults;
  final bool isSearching;

  LocationsLoaded({
    required this.locations,
    this.searchResults = const [],
    this.isSearching = false,
  });

  LocationsLoaded copyWith({
    List<LocationEntity>? locations,
    List<LocationEntity>? searchResults,
    bool? isSearching,
  }) {
    return LocationsLoaded(
      locations: locations ?? this.locations,
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [locations, searchResults, isSearching];
}

class LocationsError extends LocationsState {
  final String message;
  LocationsError(this.message);

  @override
  List<Object?> get props => [message];
}
