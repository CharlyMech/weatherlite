class AppConstants {
  AppConstants._();

  static const String appName = "WeatherLite";
  static const String openMeteoBaseUrl = "https://api.open-meteo.com";
  static const String geocodingBaseUrl = "https://geocoding-api.open-meteo.com";

  // Default coordinates (Madrid)
  // TODO -> default coordinates current location
  static const double defaultLat = 40.4168;
  static const double defaultLon = -3.7038;

  // Cache
  static const int weatherCacheTtlMinutes = 30;
}
