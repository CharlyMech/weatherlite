import 'package:weatherlite/domain/entities/splash_weather_data.dart';

class SplashState {
  final bool isReady;
  final bool isFirstLaunch;
  final SplashWeatherData? weatherData;

  const SplashState({
    this.isReady = false,
    this.isFirstLaunch = false,
    this.weatherData,
  });

  SplashState copyWith({
    bool? isReady,
    bool? isFirstLaunch,
    SplashWeatherData? weatherData,
  }) {
    return SplashState(
      isReady: isReady ?? this.isReady,
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      weatherData: weatherData ?? this.weatherData,
    );
  }
}
