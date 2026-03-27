import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String id;
  final String name;
  final String country;
  final String? region;
  final double lat;
  final double lon;
  final bool isCurrentLocation;
  final int order;

  const LocationEntity({
    required this.id,
    required this.name,
    required this.country,
    this.region,
    required this.lat,
    required this.lon,
    this.isCurrentLocation = false,
    this.order = 0,
  });

  LocationEntity copyWith({
    String? id,
    String? name,
    String? country,
    String? region,
    double? lat,
    double? lon,
    bool? isCurrentLocation,
    int? order,
  }) {
    return LocationEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      region: region ?? this.region,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      isCurrentLocation: isCurrentLocation ?? this.isCurrentLocation,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    country,
    lat,
    lon,
    isCurrentLocation,
    order,
  ];
}
