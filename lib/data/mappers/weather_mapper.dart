import 'package:weatherlite/data/dto/weather_dto.dart';
import 'package:weatherlite/domain/entities/weather_entity.dart';

class WeatherMapper {
  static Weather fromDto(WeatherDto dto) {
    return Weather(
      temperature: dto.temperature,
      windSpeed: dto.windspeed,
      windDirection: dto.windDirection,
      apparentTemperature: dto.apparentTemperature,
      weatherCode: dto.weatherCode,
      hourlyTemperatures: dto.hourlyTemperatures,
      hourlyHumidity: dto.hourlyHumidity,
      hourlyPrecipitationProb: dto.hourlyPrecipitationProb,
      hourlyUvIndex: dto.hourlyUvIndex,
      dailyMax: dto.dailyMax,
      dailyMin: dto.dailyMin,
      dailySunrise: dto.dailySunrise,
      dailySunset: dto.dailySunset,
    );
  }
}
