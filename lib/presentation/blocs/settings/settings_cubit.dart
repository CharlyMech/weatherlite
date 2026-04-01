import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/storage/preferences/app_preferences.dart';

class SettingsState {
  final String temperatureUnit;
  final String themeMode;

  const SettingsState({
    this.temperatureUnit = 'C',
    this.themeMode = 'dark',
  });

  SettingsState copyWith({String? temperatureUnit, String? themeMode}) {
    return SettingsState(
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  final AppPreferences _appPrefs;

  SettingsCubit({required AppPreferences appPrefs})
      : _appPrefs = appPrefs,
        super(SettingsState(
          temperatureUnit: appPrefs.temperatureUnit,
          themeMode: appPrefs.themeMode,
        ));

  Future<void> setTemperatureUnit(String unit) async {
    await _appPrefs.setTemperatureUnit(unit);
    emit(state.copyWith(temperatureUnit: unit));
  }

  Future<void> setThemeMode(String mode) async {
    await _appPrefs.setThemeMode(mode);
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> logout() async {
    await _appPrefs.resetForLogout();
  }
}
