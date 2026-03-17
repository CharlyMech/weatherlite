import 'package:dio/dio.dart';
import 'package:weatherlite/data/dto/weather_dto.dart';

class WeatherApiService {
  final Dio dio;

  WeatherApiService(this.dio);

  Future<WeatherDto> fetchWeather(double lat, double lon) async {
    final response = await dio.get(
      "/v1/forecast",
      queryParameters: {
        "latitude": lat,
        "longitude": lon,
        "current_weather": true,
        "hourly":
            "temperature_2m,relative_humidity_2m,precipitation_probability,uv_index,apparent_temperature",
        "daily": "temperature_2m_max,temperature_2m_min,sunrise,sunset",
        "timezone": "auto",
      },
    );

    return WeatherDto.fromJson(response.data);
  }
}
