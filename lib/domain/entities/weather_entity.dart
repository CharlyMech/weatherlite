class Weather {
  final double temperature;
  final double windSpeed;
  final double windDirection;
  final double apparentTemperature;
  final int weatherCode;
  final List<double> hourlyTemperatures;
  final List<double> hourlyHumidity;
  final List<double> hourlyPrecipitationProb;
  final List<double> hourlyUvIndex;
  final List<double> dailyMax;
  final List<double> dailyMin;
  final List<String> dailySunrise;
  final List<String> dailySunset;

  const Weather({
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.apparentTemperature,
    required this.weatherCode,
    required this.hourlyTemperatures,
    required this.hourlyHumidity,
    required this.hourlyPrecipitationProb,
    required this.hourlyUvIndex,
    required this.dailyMax,
    required this.dailyMin,
    required this.dailySunrise,
    required this.dailySunset,
  });

  double get humidity => hourlyHumidity.isNotEmpty ? hourlyHumidity.first : 0;

  double get precipitationProb =>
      hourlyPrecipitationProb.isNotEmpty ? hourlyPrecipitationProb.first : 0;

  double get uvIndex => hourlyUvIndex.isNotEmpty ? hourlyUvIndex.first : 0;

  String get sunrise => dailySunrise.isNotEmpty ? dailySunrise.first : "--:--";

  String get sunset => dailySunset.isNotEmpty ? dailySunset.first : "--:--";

  double get todayMax => dailyMax.isNotEmpty ? dailyMax.first : temperature;

  double get todayMin => dailyMin.isNotEmpty ? dailyMin.first : temperature;
}
