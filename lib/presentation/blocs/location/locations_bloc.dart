import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/domain/repositories/location_repository.dart';

import 'locations_event.dart';
import 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final LocationRepository repository;

  LocationsBloc(this.repository) : super(LocationsInitial()) {
    on<LoadLocations>(_onLoad);
    on<SearchCities>(_onSearch);
    on<ClearSearch>(_onClearSearch);
    on<AddLocation>(_onAdd);
    on<RemoveLocation>(_onRemove);
    on<ReorderLocations>(_onReorder);
    on<DetectCurrentLocation>(_onDetectCurrent);
  }

  Future<void> _onLoad(
    LoadLocations event,
    Emitter<LocationsState> emit,
  ) async {
    emit(LocationsLoading());
    try {
      final locations = await repository.getSavedLocations();
      emit(LocationsLoaded(locations: locations));
    } catch (e) {
      emit(LocationsError(e.toString()));
    }
  }

  Future<void> _onSearch(
    SearchCities event,
    Emitter<LocationsState> emit,
  ) async {
    final current = state;
    final locations = current is LocationsLoaded
        ? current.locations
        : <dynamic>[];

    emit(LocationsLoaded(locations: List.from(locations), isSearching: true));

    try {
      final results = await repository.searchCities(event.query);
      emit(
        LocationsLoaded(
          locations: List.from(locations),
          searchResults: results,
          isSearching: false,
        ),
      );
    } catch (e) {
      emit(
        LocationsLoaded(locations: List.from(locations), isSearching: false),
      );
    }
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<LocationsState> emit,
  ) async {
    final current = state;
    if (current is LocationsLoaded) {
      emit(current.copyWith(searchResults: [], isSearching: false));
    }
  }

  Future<void> _onAdd(AddLocation event, Emitter<LocationsState> emit) async {
    await repository.saveLocation(event.location);
    final locations = await repository.getSavedLocations();
    final current = state;
    emit(
      LocationsLoaded(
        locations: locations,
        searchResults: current is LocationsLoaded ? current.searchResults : [],
      ),
    );
  }

  Future<void> _onRemove(
    RemoveLocation event,
    Emitter<LocationsState> emit,
  ) async {
    await repository.removeLocation(event.id);
    final locations = await repository.getSavedLocations();
    emit(LocationsLoaded(locations: locations));
  }

  Future<void> _onReorder(
    ReorderLocations event,
    Emitter<LocationsState> emit,
  ) async {
    await repository.reorderLocations(event.locations);
    final locations = await repository.getSavedLocations();
    emit(LocationsLoaded(locations: locations));
  }

  Future<void> _onDetectCurrent(
    DetectCurrentLocation event,
    Emitter<LocationsState> emit,
  ) async {
    try {
      final current = await repository.getCurrentLocation();
      await repository.saveLocation(current);
      final locations = await repository.getSavedLocations();
      emit(LocationsLoaded(locations: locations));
    } catch (e) {
      final currentState = state;
      if (currentState is LocationsLoaded) {
        emit(currentState); // Keep current state on error
      } else {
        emit(LocationsError(e.toString()));
      }
    }
  }
}
