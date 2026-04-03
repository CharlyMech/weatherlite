import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/data/sources/local/location_local_source.dart';
import 'package:weatherlite/storage/isar/services/isar_service.dart';
import 'package:weatherlite/storage/preferences/app_preferences.dart';

class SettingsState {
  final String temperatureUnit;
  final String themeMode;
  final NavbarCollapseBehavior navbarCollapseBehavior;

  const SettingsState({
    this.temperatureUnit = 'C',
    this.themeMode = 'dark',
    this.navbarCollapseBehavior = NavbarCollapseBehavior.manual,
  });

  SettingsState copyWith({
    String? temperatureUnit,
    String? themeMode,
    NavbarCollapseBehavior? navbarCollapseBehavior,
  }) {
    return SettingsState(
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      themeMode: themeMode ?? this.themeMode,
      navbarCollapseBehavior:
          navbarCollapseBehavior ?? this.navbarCollapseBehavior,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  final AppPreferences _appPrefs;
  final LocationLocalSource _locationLocal;

  SettingsCubit({
    required AppPreferences appPrefs,
    required IsarService isarService,
  })  : _appPrefs = appPrefs,
        _locationLocal = LocationLocalSource(isarService),
        super(SettingsState(
          temperatureUnit: appPrefs.temperatureUnit,
          themeMode: appPrefs.themeMode,
          navbarCollapseBehavior: appPrefs.navbarCollapseBehavior,
        ));

  Future<void> setTemperatureUnit(String unit) async {
    await _appPrefs.setTemperatureUnit(unit);
    emit(state.copyWith(temperatureUnit: unit));
  }

  Future<void> setThemeMode(String mode) async {
    await _appPrefs.setThemeMode(mode);
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> setNavbarCollapseBehavior(NavbarCollapseBehavior behavior) async {
    await _appPrefs.setNavbarCollapseBehavior(behavior);
    emit(state.copyWith(navbarCollapseBehavior: behavior));
  }

  Future<void> logout() async {
    // Clear all saved locations
    final locations = await _locationLocal.getLocations();
    for (final loc in locations) {
      await _locationLocal.deleteLocation(loc.id);
    }
    // Reset preferences (onboarding flag + permission state)
    await _appPrefs.resetForLogout();
  }
}
