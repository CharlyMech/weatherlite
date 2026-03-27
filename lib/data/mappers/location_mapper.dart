import 'package:weatherlite/data/dto/location_dto.dart';
import 'package:weatherlite/domain/entities/location_entity.dart';

class LocationMapper {
  static LocationEntity fromDto(LocationDto dto, {int order = 0}) {
    final id = "${dto.latitude}_${dto.longitude}";
    return LocationEntity(
      id: id,
      name: dto.name,
      country: dto.country,
      region: dto.admin1,
      lat: dto.latitude,
      lon: dto.longitude,
      order: order,
    );
  }
}
