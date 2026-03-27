import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
  // Preserva el splash nativo hasta que llamemos a .remove()
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  // ── Inicialización de dependencias ───────────────────────────────────────
  final dio = DioClient().dio;
  final weatherApi = WeatherApiService(dio);
  final geocodingApi = GeocodingApiService();

  final weatherRepo = WeatherRepositoryImpl(weatherApi);
  final locationRepo = LocationRepositoryImpl(geocodingApi);

  // ── Eliminar splash una vez inicializado todo ────────────────────────────
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
