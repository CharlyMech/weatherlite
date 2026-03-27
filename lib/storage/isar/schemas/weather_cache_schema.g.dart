// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_cache_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeatherCacheModelCollection on Isar {
  IsarCollection<WeatherCacheModel> get weatherCacheModels => this.collection();
}

const WeatherCacheModelSchema = CollectionSchema(
  name: r'WeatherCacheModel',
  id: 76074573956068053,
  properties: {
    r'apparentTemperature': PropertySchema(
      id: 0,
      name: r'apparentTemperature',
      type: IsarType.double,
    ),
    r'dailyMax': PropertySchema(
      id: 1,
      name: r'dailyMax',
      type: IsarType.doubleList,
    ),
    r'dailyMin': PropertySchema(
      id: 2,
      name: r'dailyMin',
      type: IsarType.doubleList,
    ),
    r'dailySunrise': PropertySchema(
      id: 3,
      name: r'dailySunrise',
      type: IsarType.stringList,
    ),
    r'dailySunset': PropertySchema(
      id: 4,
      name: r'dailySunset',
      type: IsarType.stringList,
    ),
    r'hourlyHumidity': PropertySchema(
      id: 5,
      name: r'hourlyHumidity',
      type: IsarType.doubleList,
    ),
    r'hourlyPrecipitationProb': PropertySchema(
      id: 6,
      name: r'hourlyPrecipitationProb',
      type: IsarType.doubleList,
    ),
    r'hourlyTemperatures': PropertySchema(
      id: 7,
      name: r'hourlyTemperatures',
      type: IsarType.doubleList,
    ),
    r'hourlyUvIndex': PropertySchema(
      id: 8,
      name: r'hourlyUvIndex',
      type: IsarType.doubleList,
    ),
    r'lastUpdated': PropertySchema(
      id: 9,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'locationId': PropertySchema(
      id: 10,
      name: r'locationId',
      type: IsarType.string,
    ),
    r'temperature': PropertySchema(
      id: 11,
      name: r'temperature',
      type: IsarType.double,
    ),
    r'weatherCode': PropertySchema(
      id: 12,
      name: r'weatherCode',
      type: IsarType.long,
    ),
    r'windDirection': PropertySchema(
      id: 13,
      name: r'windDirection',
      type: IsarType.double,
    ),
    r'windSpeed': PropertySchema(
      id: 14,
      name: r'windSpeed',
      type: IsarType.double,
    )
  },
  estimateSize: _weatherCacheModelEstimateSize,
  serialize: _weatherCacheModelSerialize,
  deserialize: _weatherCacheModelDeserialize,
  deserializeProp: _weatherCacheModelDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'locationId': IndexSchema(
      id: 8924247506386354970,
      name: r'locationId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'locationId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _weatherCacheModelGetId,
  getLinks: _weatherCacheModelGetLinks,
  attach: _weatherCacheModelAttach,
  version: '3.1.0+1',
);

int _weatherCacheModelEstimateSize(
  WeatherCacheModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dailyMax.length * 8;
  bytesCount += 3 + object.dailyMin.length * 8;
  bytesCount += 3 + object.dailySunrise.length * 3;
  {
    for (var i = 0; i < object.dailySunrise.length; i++) {
      final value = object.dailySunrise[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.dailySunset.length * 3;
  {
    for (var i = 0; i < object.dailySunset.length; i++) {
      final value = object.dailySunset[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.hourlyHumidity.length * 8;
  bytesCount += 3 + object.hourlyPrecipitationProb.length * 8;
  bytesCount += 3 + object.hourlyTemperatures.length * 8;
  bytesCount += 3 + object.hourlyUvIndex.length * 8;
  bytesCount += 3 + object.locationId.length * 3;
  return bytesCount;
}

void _weatherCacheModelSerialize(
  WeatherCacheModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.apparentTemperature);
  writer.writeDoubleList(offsets[1], object.dailyMax);
  writer.writeDoubleList(offsets[2], object.dailyMin);
  writer.writeStringList(offsets[3], object.dailySunrise);
  writer.writeStringList(offsets[4], object.dailySunset);
  writer.writeDoubleList(offsets[5], object.hourlyHumidity);
  writer.writeDoubleList(offsets[6], object.hourlyPrecipitationProb);
  writer.writeDoubleList(offsets[7], object.hourlyTemperatures);
  writer.writeDoubleList(offsets[8], object.hourlyUvIndex);
  writer.writeDateTime(offsets[9], object.lastUpdated);
  writer.writeString(offsets[10], object.locationId);
  writer.writeDouble(offsets[11], object.temperature);
  writer.writeLong(offsets[12], object.weatherCode);
  writer.writeDouble(offsets[13], object.windDirection);
  writer.writeDouble(offsets[14], object.windSpeed);
}

WeatherCacheModel _weatherCacheModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeatherCacheModel();
  object.apparentTemperature = reader.readDouble(offsets[0]);
  object.dailyMax = reader.readDoubleList(offsets[1]) ?? [];
  object.dailyMin = reader.readDoubleList(offsets[2]) ?? [];
  object.dailySunrise = reader.readStringList(offsets[3]) ?? [];
  object.dailySunset = reader.readStringList(offsets[4]) ?? [];
  object.hourlyHumidity = reader.readDoubleList(offsets[5]) ?? [];
  object.hourlyPrecipitationProb = reader.readDoubleList(offsets[6]) ?? [];
  object.hourlyTemperatures = reader.readDoubleList(offsets[7]) ?? [];
  object.hourlyUvIndex = reader.readDoubleList(offsets[8]) ?? [];
  object.isarId = id;
  object.lastUpdated = reader.readDateTime(offsets[9]);
  object.locationId = reader.readString(offsets[10]);
  object.temperature = reader.readDouble(offsets[11]);
  object.weatherCode = reader.readLong(offsets[12]);
  object.windDirection = reader.readDouble(offsets[13]);
  object.windSpeed = reader.readDouble(offsets[14]);
  return object;
}

P _weatherCacheModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 2:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 6:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 7:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 8:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weatherCacheModelGetId(WeatherCacheModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _weatherCacheModelGetLinks(
    WeatherCacheModel object) {
  return [];
}

void _weatherCacheModelAttach(
    IsarCollection<dynamic> col, Id id, WeatherCacheModel object) {
  object.isarId = id;
}

extension WeatherCacheModelByIndex on IsarCollection<WeatherCacheModel> {
  Future<WeatherCacheModel?> getByLocationId(String locationId) {
    return getByIndex(r'locationId', [locationId]);
  }

  WeatherCacheModel? getByLocationIdSync(String locationId) {
    return getByIndexSync(r'locationId', [locationId]);
  }

  Future<bool> deleteByLocationId(String locationId) {
    return deleteByIndex(r'locationId', [locationId]);
  }

  bool deleteByLocationIdSync(String locationId) {
    return deleteByIndexSync(r'locationId', [locationId]);
  }

  Future<List<WeatherCacheModel?>> getAllByLocationId(
      List<String> locationIdValues) {
    final values = locationIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'locationId', values);
  }

  List<WeatherCacheModel?> getAllByLocationIdSync(
      List<String> locationIdValues) {
    final values = locationIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'locationId', values);
  }

  Future<int> deleteAllByLocationId(List<String> locationIdValues) {
    final values = locationIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'locationId', values);
  }

  int deleteAllByLocationIdSync(List<String> locationIdValues) {
    final values = locationIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'locationId', values);
  }

  Future<Id> putByLocationId(WeatherCacheModel object) {
    return putByIndex(r'locationId', object);
  }

  Id putByLocationIdSync(WeatherCacheModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'locationId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLocationId(List<WeatherCacheModel> objects) {
    return putAllByIndex(r'locationId', objects);
  }

  List<Id> putAllByLocationIdSync(List<WeatherCacheModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'locationId', objects, saveLinks: saveLinks);
  }
}

extension WeatherCacheModelQueryWhereSort
    on QueryBuilder<WeatherCacheModel, WeatherCacheModel, QWhere> {
  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WeatherCacheModelQueryWhere
    on QueryBuilder<WeatherCacheModel, WeatherCacheModel, QWhereClause> {
  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterWhereClause>
      locationIdEqualTo(String locationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'locationId',
        value: [locationId],
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterWhereClause>
      locationIdNotEqualTo(String locationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'locationId',
              lower: [],
              upper: [locationId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'locationId',
              lower: [locationId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'locationId',
              lower: [locationId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'locationId',
              lower: [],
              upper: [locationId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension WeatherCacheModelQueryFilter
    on QueryBuilder<WeatherCacheModel, WeatherCacheModel, QFilterCondition> {
  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      apparentTemperatureEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apparentTemperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      apparentTemperatureGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'apparentTemperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      apparentTemperatureLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'apparentTemperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      apparentTemperatureBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'apparentTemperature',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMaxElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyMax',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMaxElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailyMax',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMaxElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailyMax',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMaxElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailyMax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMaxLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMax',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMaxIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMax',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMaxIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMax',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMaxLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMax',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMaxLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMax',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMaxLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMax',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMinElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyMin',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMinElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailyMin',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMinElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailyMin',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMinElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailyMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMinLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMin',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMinIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMin',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMinIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMin',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMinLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMin',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMinLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMin',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailyMinLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailyMin',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailySunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailySunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailySunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailySunrise',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dailySunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dailySunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dailySunrise',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dailySunrise',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailySunrise',
        value: '',
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dailySunrise',
        value: '',
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunrise',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunrise',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunrise',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunrise',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunrise',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunriseLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunrise',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailySunset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailySunset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailySunset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailySunset',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dailySunset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dailySunset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dailySunset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dailySunset',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailySunset',
        value: '',
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dailySunset',
        value: '',
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunset',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunset',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunset',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunset',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunset',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      dailySunsetLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dailySunset',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyHumidityElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hourlyHumidity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyHumidityElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hourlyHumidity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyHumidityElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hourlyHumidity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyHumidityElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hourlyHumidity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyHumidityLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyHumidity',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyHumidityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyHumidity',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyHumidityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyHumidity',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyHumidityLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyHumidity',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyHumidityLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyHumidity',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyHumidityLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyHumidity',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyPrecipitationProbElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hourlyPrecipitationProb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyPrecipitationProbElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hourlyPrecipitationProb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyPrecipitationProbElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hourlyPrecipitationProb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyPrecipitationProbElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hourlyPrecipitationProb',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyPrecipitationProbLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyPrecipitationProb',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyPrecipitationProbIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyPrecipitationProb',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyPrecipitationProbIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyPrecipitationProb',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyPrecipitationProbLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyPrecipitationProb',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyPrecipitationProbLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyPrecipitationProb',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyPrecipitationProbLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyPrecipitationProb',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyTemperaturesElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hourlyTemperatures',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyTemperaturesElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hourlyTemperatures',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyTemperaturesElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hourlyTemperatures',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyTemperaturesElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hourlyTemperatures',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyTemperaturesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyTemperatures',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyTemperaturesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyTemperatures',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyTemperaturesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyTemperatures',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyTemperaturesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyTemperatures',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyTemperaturesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyTemperatures',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyTemperaturesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyTemperatures',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyUvIndexElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hourlyUvIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyUvIndexElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hourlyUvIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyUvIndexElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hourlyUvIndex',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyUvIndexElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hourlyUvIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyUvIndexLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyUvIndex',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyUvIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyUvIndex',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyUvIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyUvIndex',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyUvIndexLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyUvIndex',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyUvIndexLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyUvIndex',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      hourlyUvIndexLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlyUvIndex',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      lastUpdatedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      lastUpdatedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      lastUpdatedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      lastUpdatedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      locationIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      locationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      locationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      locationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      locationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      locationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      locationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      locationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      locationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationId',
        value: '',
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      locationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationId',
        value: '',
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      temperatureEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      temperatureGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'temperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      temperatureLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'temperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      temperatureBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'temperature',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      weatherCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weatherCode',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      weatherCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weatherCode',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      weatherCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weatherCode',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      weatherCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weatherCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      windDirectionEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'windDirection',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      windDirectionGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'windDirection',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      windDirectionLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'windDirection',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      windDirectionBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'windDirection',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      windSpeedEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'windSpeed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      windSpeedGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'windSpeed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      windSpeedLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'windSpeed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterFilterCondition>
      windSpeedBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'windSpeed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension WeatherCacheModelQueryObject
    on QueryBuilder<WeatherCacheModel, WeatherCacheModel, QFilterCondition> {}

extension WeatherCacheModelQueryLinks
    on QueryBuilder<WeatherCacheModel, WeatherCacheModel, QFilterCondition> {}

extension WeatherCacheModelQuerySortBy
    on QueryBuilder<WeatherCacheModel, WeatherCacheModel, QSortBy> {
  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByApparentTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apparentTemperature', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByApparentTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apparentTemperature', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByLocationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByWeatherCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherCode', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByWeatherCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherCode', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByWindDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windDirection', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByWindDirectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windDirection', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByWindSpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windSpeed', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      sortByWindSpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windSpeed', Sort.desc);
    });
  }
}

extension WeatherCacheModelQuerySortThenBy
    on QueryBuilder<WeatherCacheModel, WeatherCacheModel, QSortThenBy> {
  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByApparentTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apparentTemperature', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByApparentTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apparentTemperature', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByLocationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByWeatherCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherCode', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByWeatherCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherCode', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByWindDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windDirection', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByWindDirectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windDirection', Sort.desc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByWindSpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windSpeed', Sort.asc);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QAfterSortBy>
      thenByWindSpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'windSpeed', Sort.desc);
    });
  }
}

extension WeatherCacheModelQueryWhereDistinct
    on QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct> {
  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByApparentTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apparentTemperature');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByDailyMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyMax');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByDailyMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyMin');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByDailySunrise() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailySunrise');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByDailySunset() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailySunset');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByHourlyHumidity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hourlyHumidity');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByHourlyPrecipitationProb() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hourlyPrecipitationProb');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByHourlyTemperatures() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hourlyTemperatures');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByHourlyUvIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hourlyUvIndex');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByLocationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locationId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temperature');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByWeatherCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weatherCode');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByWindDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'windDirection');
    });
  }

  QueryBuilder<WeatherCacheModel, WeatherCacheModel, QDistinct>
      distinctByWindSpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'windSpeed');
    });
  }
}

extension WeatherCacheModelQueryProperty
    on QueryBuilder<WeatherCacheModel, WeatherCacheModel, QQueryProperty> {
  QueryBuilder<WeatherCacheModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<WeatherCacheModel, double, QQueryOperations>
      apparentTemperatureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apparentTemperature');
    });
  }

  QueryBuilder<WeatherCacheModel, List<double>, QQueryOperations>
      dailyMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyMax');
    });
  }

  QueryBuilder<WeatherCacheModel, List<double>, QQueryOperations>
      dailyMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyMin');
    });
  }

  QueryBuilder<WeatherCacheModel, List<String>, QQueryOperations>
      dailySunriseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailySunrise');
    });
  }

  QueryBuilder<WeatherCacheModel, List<String>, QQueryOperations>
      dailySunsetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailySunset');
    });
  }

  QueryBuilder<WeatherCacheModel, List<double>, QQueryOperations>
      hourlyHumidityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hourlyHumidity');
    });
  }

  QueryBuilder<WeatherCacheModel, List<double>, QQueryOperations>
      hourlyPrecipitationProbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hourlyPrecipitationProb');
    });
  }

  QueryBuilder<WeatherCacheModel, List<double>, QQueryOperations>
      hourlyTemperaturesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hourlyTemperatures');
    });
  }

  QueryBuilder<WeatherCacheModel, List<double>, QQueryOperations>
      hourlyUvIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hourlyUvIndex');
    });
  }

  QueryBuilder<WeatherCacheModel, DateTime, QQueryOperations>
      lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<WeatherCacheModel, String, QQueryOperations>
      locationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationId');
    });
  }

  QueryBuilder<WeatherCacheModel, double, QQueryOperations>
      temperatureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temperature');
    });
  }

  QueryBuilder<WeatherCacheModel, int, QQueryOperations> weatherCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weatherCode');
    });
  }

  QueryBuilder<WeatherCacheModel, double, QQueryOperations>
      windDirectionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'windDirection');
    });
  }

  QueryBuilder<WeatherCacheModel, double, QQueryOperations>
      windSpeedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'windSpeed');
    });
  }
}
