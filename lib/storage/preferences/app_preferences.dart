import 'package:shared_preferences/shared_preferences.dart';

/// How the floating navbar collapses.
enum NavbarCollapseBehavior {
  /// Never collapses — close icon is hidden.
  never,

  /// Collapses when the user interacts outside the navbar (scroll, tap, etc.).
  onExternalTouch,

  /// Manual click to open/close (default).
  manual,
}

class AppPreferences {
  static const _keyTempUnit = "temperature_unit";
  static const _keySelectedLocation = "selected_location_id";
  static const _keyThemeMode = "theme_mode";
  static const _keyLocale = "locale";
  static const _keyHasLaunched = "has_launched";
  static const _keyLocationPermissionGranted = "location_permission_granted";
  static const _keyNavbarCollapseBehavior = "navbar_collapse_behavior";

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

  // Location permission granted
  bool get locationPermissionGranted =>
      _prefs.getBool(_keyLocationPermissionGranted) ?? false;
  Future<void> setLocationPermissionGranted(bool granted) =>
      _prefs.setBool(_keyLocationPermissionGranted, granted);

  // Navbar collapse behavior
  NavbarCollapseBehavior get navbarCollapseBehavior {
    final value = _prefs.getString(_keyNavbarCollapseBehavior);
    return NavbarCollapseBehavior.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NavbarCollapseBehavior.manual,
    );
  }

  Future<void> setNavbarCollapseBehavior(NavbarCollapseBehavior behavior) =>
      _prefs.setString(_keyNavbarCollapseBehavior, behavior.name);

  // Whether the user granted only "while in use" (needs re-request each launch)
  static const _keyLocationWhileInUse = "location_while_in_use";
  bool get locationIsWhileInUse =>
      _prefs.getBool(_keyLocationWhileInUse) ?? false;
  Future<void> setLocationWhileInUse(bool whileInUse) =>
      _prefs.setBool(_keyLocationWhileInUse, whileInUse);

  // Logout — resets onboarding flag and clears permission state
  Future<void> resetForLogout() async {
    await _prefs.setBool(_keyHasLaunched, false);
    await _prefs.setBool(_keyLocationPermissionGranted, false);
    await _prefs.setBool(_keyLocationWhileInUse, false);
  }
}
