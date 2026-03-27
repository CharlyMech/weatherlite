import 'package:dio/dio.dart';
import 'package:weatherlite/data/dto/location_dto.dart';

class GeocodingApiService {
  final Dio dio;

  GeocodingApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: "https://geocoding-api.open-meteo.com",
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
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
}
