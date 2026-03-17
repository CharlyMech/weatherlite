class WeatherDto {
  final double temperature;
  final double windspeed;
  final int weatherCode;
  final double windDirection;
  final double apparentTemperature;
  final List<double> hourlyTemperatures;
  final List<double> hourlyHumidity;
  final List<double> hourlyPrecipitationProb;
  final List<double> hourlyUvIndex;
  final List<double> dailyMax;
  final List<double> dailyMin;
  final List<String> dailySunrise;
  final List<String> dailySunset;

  WeatherDto({
    required this.temperature,
    required this.windspeed,
    required this.weatherCode,
    required this.windDirection,
    required this.apparentTemperature,
    required this.hourlyTemperatures,
    required this.hourlyHumidity,
    required this.hourlyPrecipitationProb,
    required this.hourlyUvIndex,
    required this.dailyMax,
    required this.dailyMin,
    required this.dailySunrise,
    required this.dailySunset,
  });

  factory WeatherDto.fromJson(Map<String, dynamic> json) {
    final current = json["current_weather"];
    final hourly = json["hourly"] ?? {};
    final daily = json["daily"] ?? {};

    List<double> parseDoubleList(dynamic list) {
      return (list as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [];
    }

    List<String> parseStringList(dynamic list) {
      return (list as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    }

    return WeatherDto(
      temperature: (current["temperature"] as num).toDouble(),
      windspeed: (current["windspeed"] as num).toDouble(),
      weatherCode: current["weathercode"] ?? 0,
      windDirection: (current["winddirection"] as num?)?.toDouble() ?? 0,
      apparentTemperature:
          (hourly["apparent_temperature"] as List?)?.firstOrNull != null
          ? ((hourly["apparent_temperature"] as List).first as num).toDouble()
          : (current["temperature"] as num).toDouble(),
      hourlyTemperatures: parseDoubleList(hourly["temperature_2m"]),
      hourlyHumidity: parseDoubleList(hourly["relative_humidity_2m"]),
      hourlyPrecipitationProb: parseDoubleList(
        hourly["precipitation_probability"],
      ),
      hourlyUvIndex: parseDoubleList(hourly["uv_index"]),
      dailyMax: parseDoubleList(daily["temperature_2m_max"]),
      dailyMin: parseDoubleList(daily["temperature_2m_min"]),
      dailySunrise: parseStringList(daily["sunrise"]),
      dailySunset: parseStringList(daily["sunset"]),
    );
  }
}
