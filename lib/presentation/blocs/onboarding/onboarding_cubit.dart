import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherlite/data/repositories/location_repository_impl.dart';
import 'package:weatherlite/data/repositories/weather_repository_impl.dart';
import 'package:weatherlite/domain/entities/location_entity.dart';
import 'package:weatherlite/storage/preferences/app_preferences.dart';
import 'package:weatherlite/presentation/blocs/onboarding/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final AppPreferences _appPrefs;
  final LocationRepositoryImpl _locationRepo;
  final WeatherRepositoryImpl _weatherRepo;

  OnboardingCubit({
    required AppPreferences appPrefs,
    required LocationRepositoryImpl locationRepo,
    required WeatherRepositoryImpl weatherRepo,
  })  : _appPrefs = appPrefs,
        _locationRepo = locationRepo,
        _weatherRepo = weatherRepo,
        super(const OnboardingState());

  void goToPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void nextPage() {
    if (state.currentPage < state.totalPages - 1) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void skip() {
    emit(state.copyWith(currentPage: state.totalPages - 1));
  }

  Future<void> requestLocationPermission() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      // Permission granted — get position and save location
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );

      final location = LocationEntity(
        id: 'current_location',
        name: 'My Location',
        country: '',
        lat: position.latitude,
        lon: position.longitude,
        isCurrentLocation: true,
        order: -1,
      );

      await _locationRepo.saveLocation(location);

      // Pre-fetch weather so HomePage has it cached
      try {
        await _weatherRepo
            .getWeather(position.latitude, position.longitude)
            .timeout(const Duration(seconds: 5));
      } catch (_) {}

      emit(state.copyWith(locationGranted: true));
    } catch (_) {
      // Permission or location fetch failed — user can add cities manually
    }
  }

  Future<void> completeOnboarding() async {
    await _appPrefs.setHasLaunched();
    emit(state.copyWith(isComplete: true));
  }
}
