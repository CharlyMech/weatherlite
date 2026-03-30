import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/data/repositories/location_repository_impl.dart';
import 'package:weatherlite/data/repositories/weather_repository_impl.dart';
import 'package:weatherlite/domain/entities/splash_weather_data.dart';
import 'package:weatherlite/storage/preferences/app_preferences.dart';
import 'package:weatherlite/presentation/blocs/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AppPreferences _appPrefs;
  final WeatherRepositoryImpl _weatherRepo;
  final LocationRepositoryImpl _locationRepo;

  SplashCubit({
    required AppPreferences appPrefs,
    required WeatherRepositoryImpl weatherRepo,
    required LocationRepositoryImpl locationRepo,
  })  : _appPrefs = appPrefs,
        _weatherRepo = weatherRepo,
        _locationRepo = locationRepo,
        super(const SplashState());

  Future<void> initialize() async {
    final isFirstLaunch = !_appPrefs.hasLaunched;
    emit(state.copyWith(isFirstLaunch: isFirstLaunch));

    // Returning user: fetch weather for splash display
    if (!isFirstLaunch) {
      try {
        final location = await _locationRepo
            .getCurrentLocation()
            .timeout(const Duration(seconds: 5));
        final weather = await _weatherRepo
            .getWeather(location.lat, location.lon)
            .timeout(const Duration(seconds: 5));
        emit(state.copyWith(
          weatherData: SplashWeatherData(
            temperature: weather.temperature,
            weatherCode: weather.weatherCode,
            locationName: location.name,
          ),
        ));
      } catch (_) {
        // Non-critical — splash will just skip weather display
      }
    }

    emit(state.copyWith(isReady: true));
  }
}
