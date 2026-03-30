import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherlite/core/debug/debug_destroyer.dart';
import 'package:weatherlite/data/sources/local/weather_local_source.dart';
import 'package:weatherlite/storage/isar/services/isar_service.dart';
import 'package:weatherlite/storage/preferences/app_preferences.dart';

import 'core/network/dio_client.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'data/sources/remote/geocoding_api_service.dart';
import 'data/sources/remote/weather_api_service.dart';
import 'data/repositories/location_repository_impl.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'presentation/blocs/location/locations_bloc.dart';
import 'presentation/blocs/location/locations_event.dart';
import 'presentation/blocs/splash/splash_cubit.dart';
import 'presentation/blocs/theme/theme_cubit.dart';
import 'presentation/blocs/weather/weather_bloc.dart';
import 'presentation/pages/splash/splash_page.dart';

void main() async {
  // Preserve native splash
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  // ── Init local storage (parallel) ───────────────────────────────────────
  final isarService = IsarService();
  final results = await Future.wait([
    isarService.init(),
    SharedPreferences.getInstance(),
  ]);

  final prefs = results[1] as SharedPreferences;
  final appPrefs = AppPreferences(prefs);

  // ── Debug data reset ────────────────────────────────────────────────────
  if (DebugDestroyer.isDebugReset) {
    await DebugDestroyer(isarService: isarService, prefs: prefs).destroyAll();
  }

  // ── Debug delay so dev can see native splash ────────────────────────────
  if (kDebugMode) {
    await Future.delayed(const Duration(seconds: 1));
  }

  // ── Network deps ────────────────────────────────────────────────────────
  final dio = DioClient().dio;
  final weatherApi = WeatherApiService(dio);
  final geocodingApi = GeocodingApiService();

  // ── Local data sources ──────────────────────────────────────────────────
  final weatherLocal = WeatherLocalSource(isarService);

  // ── Repositories ────────────────────────────────────────────────────────
  final weatherRepo = WeatherRepositoryImpl(
    weatherApi,
    localSource: weatherLocal,
  );

  final locationRepo = LocationRepositoryImpl(geocodingApi);

  // Remove native splash
  FlutterNativeSplash.remove();

  runApp(WeatherLiteApp(
    weatherRepo: weatherRepo,
    locationRepo: locationRepo,
    appPrefs: appPrefs,
    isarService: isarService,
  ));
}

class WeatherLiteApp extends StatelessWidget {
  final WeatherRepositoryImpl weatherRepo;
  final LocationRepositoryImpl locationRepo;
  final AppPreferences appPrefs;
  final IsarService isarService;

  const WeatherLiteApp({
    super.key,
    required this.weatherRepo,
    required this.locationRepo,
    required this.appPrefs,
    required this.isarService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: appPrefs),
        RepositoryProvider.value(value: isarService),
        RepositoryProvider.value(value: locationRepo),
        RepositoryProvider.value(value: weatherRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => WeatherBloc(weatherRepo)),
          BlocProvider(
            create: (_) => LocationsBloc(locationRepo)..add(LoadLocations()),
          ),
          BlocProvider(
            create: (_) => SplashCubit(
              appPrefs: appPrefs,
              weatherRepo: weatherRepo,
              locationRepo: locationRepo,
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeType>(
          builder: (context, themeType) => MaterialApp(
            title: 'WeatherLite',
            debugShowCheckedModeBanner: false,
            theme: appColorSchemes[themeType]!.toThemeData(),
            home: const SplashPage(),
          ),
        ),
      ),
    );
  }
}
