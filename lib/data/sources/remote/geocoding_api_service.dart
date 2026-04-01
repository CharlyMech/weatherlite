import 'package:dio/dio.dart';
import 'package:weatherlite/data/dto/location_dto.dart';

class GeocodingApiService {
  final Dio dio;
  final Dio _nominatim;

  GeocodingApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: "https://geocoding-api.open-meteo.com",
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      ),
      _nominatim = Dio(
        BaseOptions(
          baseUrl: "https://nominatim.openstreetmap.org",
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {"User-Agent": "WeatherLite/1.0"},
        ),
      );

  Future<List<LocationDto>> searchCities(String query) async {
    if (query.trim().isEmpty) return [];

    final response = await dio.get(
      "/v1/search",
      queryParameters: {
        "name": query,
        "count": 10,
        "language": "en",
        "format": "json",
      },
    );

    final results = response.data["results"] as List<dynamic>? ?? [];
    return results.map((e) => LocationDto.fromJson(e)).toList();
  }

  /// Reverse geocode coordinates to get a human-readable city name.
  /// Returns null if the lookup fails.
  Future<({String city, String country})?> reverseGeocode(
    double lat,
    double lon,
  ) async {
    try {
      final response = await _nominatim.get(
        "/reverse",
        queryParameters: {
          "lat": lat,
          "lon": lon,
          "format": "json",
          "zoom": 10,
          "addressdetails": 1,
        },
      );
      final address = response.data["address"] as Map<String, dynamic>?;
      if (address == null) return null;

      final city = address["city"] as String? ??
          address["town"] as String? ??
          address["village"] as String? ??
          address["county"] as String? ??
          address["state"] as String?;
      final country = address["country"] as String? ?? "";

      if (city == null) return null;
      return (city: city, country: country);
    } catch (_) {
      return null;
    }
  }
}
