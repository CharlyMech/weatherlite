import 'package:isar/isar.dart';

part 'location_schema.g.dart';

@collection
class LocationModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  late String name;
  late String country;
  String? region;
  late double lat;
  late double lon;
  late bool isCurrentLocation;

  @Index()
  late int order;
}
