import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/domain/repositories/weather_repository.dart';

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  double _lastLat = 0;
  double _lastLon = 0;

  WeatherBloc(this.repository) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<RefreshWeather>(_onRefreshWeather);
    on<ForceRefreshWeather>(_onForceRefreshWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    _lastLat = event.lat;
    _lastLon = event.lon;

    try {
      final weather = await repository.getWeather(event.lat, event.lon);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> _onRefreshWeather(
    RefreshWeather event,
    Emitter<WeatherState> emit,
  ) async {
    if (_lastLat == 0 && _lastLon == 0) return;

    emit(WeatherLoading());

    try {
      final weather = await repository.getWeather(_lastLat, _lastLon);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> _onForceRefreshWeather(
    ForceRefreshWeather event,
    Emitter<WeatherState> emit,
  ) async {
    if (_lastLat == 0 && _lastLon == 0) return;

    emit(WeatherLoading());

    try {
      await repository.clearCache(_lastLat, _lastLon);
      final weather = await repository.getWeather(_lastLat, _lastLon);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
