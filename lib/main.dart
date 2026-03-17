import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:weatherlite/app.dart';
import 'package:weatherlite/core/network/dio_client.dart';
import 'package:weatherlite/data/sources/remote/weather_api_service.dart';
import 'package:weatherlite/data/repositories/weather_repository_impl.dart';

void main() async {
  // Preserva el splash nativo hasta que llamemos a .remove()
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  // ── Inicialización de dependencias ───────────────────────────────────────
  final dio = DioClient().dio;
  final weatherApi = WeatherApiService(dio);
  final weatherRepository = WeatherRepositoryImpl(weatherApi);

  // ── Eliminar splash una vez inicializado todo ────────────────────────────
  FlutterNativeSplash.remove();

  runApp(App(weatherRepository: weatherRepository));
}
