class LocationDto {
  final String name;
  final String country;
  final String? admin1;
  final double latitude;
  final double longitude;

  LocationDto({
    required this.name,
    required this.country,
    this.admin1,
    required this.latitude,
    required this.longitude,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      name: json["name"] ?? "",
      country: json["country"] ?? "",
      admin1: json["admin1"],
      latitude: (json["latitude"] as num).toDouble(),
      longitude: (json["longitude"] as num).toDouble(),
    );
  }
}
