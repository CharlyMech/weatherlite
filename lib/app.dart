import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/core/router/app_router.dart';
import 'package:weatherlite/core/theme/app_colors.dart';
import 'package:weatherlite/core/theme/app_theme.dart';
import 'package:weatherlite/data/repositories/weather_repository_impl.dart';
import 'package:weatherlite/presentation/blocs/weather/weather_bloc.dart';

class App extends StatelessWidget {
  final WeatherRepositoryImpl weatherRepository;

  const App({super.key, required this.weatherRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WeatherBloc(weatherRepository)),
        // TODO: BlocProvider(create: (_) => SettingsBloc()),
        // TODO: BlocProvider(create: (_) => LocationBloc()),
      ],
      child: MaterialApp.router(
        title: 'WeatherLite',
        debugShowCheckedModeBanner: false,
        theme: appColorSchemes[ThemeType.light]!.toThemeData(),
        darkTheme: appColorSchemes[ThemeType.dark]!.toThemeData(),
        // themeMode: ThemeMode.system, // será controlado por SettingsBloc
        themeMode: ThemeMode.dark,
        routerConfig: appRouter,
      ),
    );
  }
}
