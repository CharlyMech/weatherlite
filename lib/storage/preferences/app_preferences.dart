import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _keyTempUnit = "temperature_unit";
  static const _keySelectedLocation = "selected_location_id";
  static const _keyThemeMode = "theme_mode";
  static const _keyLocale = "locale";
  static const _keyHasLaunched = "has_launched";

  final SharedPreferences _prefs;

  AppPreferences(this._prefs);

  // Temperature unit: "C" or "F"
  String get temperatureUnit => _prefs.getString(_keyTempUnit) ?? "C";
  Future<void> setTemperatureUnit(String unit) =>
      _prefs.setString(_keyTempUnit, unit);

  // Last selected location
  String? get selectedLocationId => _prefs.getString(_keySelectedLocation);
  Future<void> setSelectedLocationId(String id) =>
      _prefs.setString(_keySelectedLocation, id);

  // Theme
  String get themeMode => _prefs.getString(_keyThemeMode) ?? "dark";
  Future<void> setThemeMode(String mode) =>
      _prefs.setString(_keyThemeMode, mode);

  // Locale
  String get locale => _prefs.getString(_keyLocale) ?? "en";
  Future<void> setLocale(String locale) => _prefs.setString(_keyLocale, locale);

  // First launch detection
  bool get hasLaunched => _prefs.getBool(_keyHasLaunched) ?? false;
  Future<void> setHasLaunched() => _prefs.setBool(_keyHasLaunched, true);
}
