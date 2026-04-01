import 'package:flutter/material.dart';

import '../../../domain/entities/weather_entity.dart';
import '../../../domain/entities/widget_config.dart';
import 'daily_chart_widget.dart';
import 'hourly_chart_widget.dart';
import 'humidity_widget.dart';
import 'rain_widget.dart';
import 'sunrise_widget.dart';
import 'temperature_widget.dart';
import 'uv_widget.dart';
import 'wind_widget.dart';

class WeatherWidgetFactory {
  WeatherWidgetFactory._();

  static Widget build(WeatherWidgetType type, Weather weather) {
    switch (type) {
      case WeatherWidgetType.temperature:
        return TemperatureWidget(weather: weather);
      case WeatherWidgetType.wind:
        return WindWidget(weather: weather);
      case WeatherWidgetType.rain:
        return RainWidget(weather: weather);
      case WeatherWidgetType.humidity:
        return HumidityWidget(weather: weather);
      case WeatherWidgetType.uv:
        return UvWidget(weather: weather);
      case WeatherWidgetType.sunrise:
        return SunriseWidget(weather: weather);
      case WeatherWidgetType.hourlyChart:
        return HourlyChartWidget(weather: weather);
      case WeatherWidgetType.dailyChart:
        return DailyChartWidget(weather: weather);
    }
  }

  static IconData icon(WeatherWidgetType type) {
    switch (type) {
      case WeatherWidgetType.temperature:
        return Icons.thermostat;
      case WeatherWidgetType.wind:
        return Icons.air;
      case WeatherWidgetType.rain:
        return Icons.water_drop;
      case WeatherWidgetType.humidity:
        return Icons.opacity;
      case WeatherWidgetType.uv:
        return Icons.wb_sunny;
      case WeatherWidgetType.sunrise:
        return Icons.wb_twilight;
      case WeatherWidgetType.hourlyChart:
        return Icons.show_chart;
      case WeatherWidgetType.dailyChart:
        return Icons.bar_chart;
    }
  }

  static String label(WeatherWidgetType type) {
    switch (type) {
      case WeatherWidgetType.temperature:
        return 'Temperature';
      case WeatherWidgetType.wind:
        return 'Wind';
      case WeatherWidgetType.rain:
        return 'Rain';
      case WeatherWidgetType.humidity:
        return 'Humidity';
      case WeatherWidgetType.uv:
        return 'UV Index';
      case WeatherWidgetType.sunrise:
        return 'Sunrise';
      case WeatherWidgetType.hourlyChart:
        return 'Hourly';
      case WeatherWidgetType.dailyChart:
        return 'Daily';
    }
  }
}
