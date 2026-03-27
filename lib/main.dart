import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherlite/data/sources/local/location_local_source.dart';
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
import 'presentation/blocs/theme/theme_cubit.dart';
import 'presentation/blocs/weather/weather_bloc.dart';
import 'presentation/pages/home/home_page.dart';

void main() async {
  // Preserve splash
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  // ── NEW: Init local storage ──────────────────────────────────────────────
  final isarService = IsarService();
  await isarService.init();

  final prefs = await SharedPreferences.getInstance();
  final appPrefs = AppPreferences(prefs);

  // ── Existing network deps ────────────────────────────────────────────────
  final dio = DioClient().dio;
  final weatherApi = WeatherApiService(dio);
  final geocodingApi = GeocodingApiService();

  // ── NEW: Local data sources ──────────────────────────────────────────────
  final weatherLocal = WeatherLocalSource(isarService);
  final locationLocal = LocationLocalSource(isarService);

  // ── Repositories (UPDATED only where needed) ─────────────────────────────
  final weatherRepo = WeatherRepositoryImpl(
    weatherApi,
    localSource: weatherLocal, // 👈 added
  );

  final locationRepo = LocationRepositoryImpl(
    geocodingApi,
    // 👇 only if your impl supports it (optional)
    // localSource: locationLocal,
  );

  // Remove splash
  FlutterNativeSplash.remove();

  runApp(WeatherLiteApp(weatherRepo: weatherRepo, locationRepo: locationRepo));
}

class WeatherLiteApp extends StatelessWidget {
  final WeatherRepositoryImpl weatherRepo;
  final LocationRepositoryImpl locationRepo;

  const WeatherLiteApp({
    super.key,
    required this.weatherRepo,
    required this.locationRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => WeatherBloc(weatherRepo)),
        BlocProvider(
          create: (_) => LocationsBloc(locationRepo)..add(LoadLocations()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeType>(
        builder: (context, themeType) => MaterialApp(
          title: 'WeatherLite',
          debugShowCheckedModeBanner: false,
          theme: appColorSchemes[themeType]!.toThemeData(),
          home: const HomePage(),
        ),
      ),
    );
  }
}
