# Plan: Theme Normalization + Splash Screen Flow

## Context

The app's `AppColors` class defines weather-specific and supporting colors that are not accessible through Flutter's theme system. Additionally, the app needs a two-phase splash flow: native splash (during init + minimal weather fetch) followed by a custom themed splash (during remaining service loading).

---

## TASK 1: Theme Normalization

### Step 1 — Create `AppColorsExtension` (ThemeExtension)

**New file:** `lib/core/theme/app_colors_extension.dart`

Single `ThemeExtension<AppColorsExtension>` with all extra colors not covered by `ColorScheme`:
- Weather: `skyGradientTop`, `skyGradientBottom`, `rainTint`, `snowTint`, `sunTint`, `nightTint`, `cardOverlay`
- Supporting: `inactive`, `onInactive`, `outline`, `shadow`
- Status: `green`, `onGreen`, `orange`, `onOrange`

Implements `copyWith()` and `lerp()` (using `Color.lerp`).

### Step 2 — Create convenience extension on BuildContext

**New file:** `lib/core/theme/theme_extensions.dart`

```dart
extension ThemeX on BuildContext {
  AppColorsExtension get appColors => Theme.of(this).extension<AppColorsExtension>()!;
}
```

### Step 3 — Register in `app_theme.dart`

**Modify:** `lib/core/theme/app_theme.dart`

Add `extensions: [AppColorsExtension(...)]` to the `ThemeData` constructor in `toThemeData()`, mapping from the existing `AppColors` getters.

---

## TASK 2: Splash Screen Flow

### Step 4 — Add dependencies + assets to pubspec

**Modify:** `pubspec.yaml`

- Add `package_info_plus: ^8.2.1` dependency
- Add `assets:` section under `flutter:` pointing to `assets/splash/`
- User will provide `light_splash.png` and `dark_splash.png` in `assets/splash/`

### Step 5 — Add first-run detection to AppPreferences

**Modify:** `lib/storage/preferences/app_preferences.dart`

Add `hasLaunched` bool getter/setter (key: `has_launched`, default: `false`).

### Step 6 — Create weather code description utility

**New file:** `lib/core/utils/weather_code_utils.dart`

Static method mapping WMO weather codes (0-99) to human-readable descriptions (e.g., 0 = "Clear sky", 61 = "Slight rain").

### Step 7 — Create `SplashWeatherData` model

**New file:** `lib/domain/entities/splash_weather_data.dart`

Minimal data class: `temperature` (double), `weatherCode` (int), `locationName` (String).

### Step 8 — Create `SplashCubit` + state

**New files:** `lib/presentation/blocs/splash/splash_cubit.dart`, `splash_state.dart`

- State holds: `isReady` (bool), `weatherData` (SplashWeatherData?)
- Cubit receives repos/services, runs remaining initialization:
  - API health check (lightweight weather fetch with short timeout)
  - Confirm local storage operational
  - Call `appPrefs.setHasLaunched()`
  - Emit `isReady: true` when done

### Step 9 — Create `AnimatedDotsLoader` widget

**New file:** `lib/presentation/widgets/common/animated_dots_loader.dart`

3 dots with staggered animation: opacity (0.3-1.0) + subtle scale (0.8-1.0). Uses `AnimationController` with `repeat()` and `Interval` for stagger.

### Step 10 — Create `SplashPage`

**New file:** `lib/presentation/pages/splash/splash_page.dart`

- Detects **system theme** via `MediaQuery.platformBrightnessOf(context)` (NOT ThemeCubit) to pick light/dark splash image
- Layout (Stack with image background + SafeArea Column):
  1. **Top**: Current location weather (temperature + description) — only if `weatherData != null`; labeled as "Current Location"
  2. **Center-ish**: "Weatherlite" title + "A Weather App simplified, fully customizable." subtitle
  3. **Near bottom**: "Syncing data" + `AnimatedDotsLoader`
  4. **Bottom**: App version via `PackageInfo.fromPlatform()`
- `BlocListener<SplashCubit>`: when `isReady`, navigate to `HomePage` via `Navigator.pushReplacement`
- Minimum display time (~1.5s) so the splash doesn't flash

### Step 11 — Restructure `main.dart`

**Modify:** `lib/main.dart`

New flow during native splash:
1. Init bindings + preserve native splash
2. Init Isar + SharedPreferences (parallel with `Future.wait`)
3. Create all services/repos
4. Check `appPrefs.hasLaunched`:
   - **Not first time**: try `getCurrentLocation()` + `getWeather(lat, lon)` → create `SplashWeatherData` (try/catch, null on failure, 5s timeout)
   - **First time**: `splashWeatherData = null`
5. Remove native splash
6. `runApp(WeatherLiteApp(..., splashWeatherData))` — initial page is `SplashPage` instead of `HomePage`

Pass `appPrefs`, `isarService`, repos to `WeatherLiteApp` so `SplashCubit` can be provided.

---

## Files Summary

| Action | File |
|--------|------|
| NEW | `lib/core/theme/app_colors_extension.dart` |
| NEW | `lib/core/theme/theme_extensions.dart` |
| EDIT | `lib/core/theme/app_theme.dart` |
| EDIT | `pubspec.yaml` |
| EDIT | `lib/storage/preferences/app_preferences.dart` |
| NEW | `lib/core/utils/weather_code_utils.dart` |
| NEW | `lib/domain/entities/splash_weather_data.dart` |
| NEW | `lib/presentation/blocs/splash/splash_state.dart` |
| NEW | `lib/presentation/blocs/splash/splash_cubit.dart` |
| NEW | `lib/presentation/widgets/common/animated_dots_loader.dart` |
| NEW | `lib/presentation/pages/splash/splash_page.dart` |
| EDIT | `lib/main.dart` |

## Verification

1. `flutter pub get` succeeds
2. `flutter analyze` — no errors
3. Run on simulator/device:
   - Native splash shows during init
   - Custom splash appears with correct theme image (matching system brightness)
   - "Syncing data" dots animate
   - App version shows at bottom
   - Transitions to HomePage when ready
4. Test first-time flow: clear app data → no weather shown on custom splash, permissions requested
5. Test returning flow: weather brief shown on custom splash top area
6. Verify `Theme.of(context).extension<AppColorsExtension>()` works from any widget
