import 'package:weatherlite/data/mappers/weather_mapper.dart';
import 'package:weatherlite/data/sources/remote/weather_api_service.dart';
import 'package:weatherlite/domain/entities/weather_entity.dart';
import 'package:weatherlite/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService api;

  WeatherRepositoryImpl(this.api);

  @override
  Future<Weather> getWeather(double lat, double lon) async {
    final dto = await api.fetchWeather(lat, lon);
    return WeatherMapper.fromDto(dto);
  }
}
