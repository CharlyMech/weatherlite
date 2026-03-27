// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_layout_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWidgetLayoutModelCollection on Isar {
  IsarCollection<WidgetLayoutModel> get widgetLayoutModels => this.collection();
}

const WidgetLayoutModelSchema = CollectionSchema(
  name: r'WidgetLayoutModel',
  id: -2681035006260531212,
  properties: {
    r'col': PropertySchema(
      id: 0,
      name: r'col',
      type: IsarType.long,
    ),
    r'locationId': PropertySchema(
      id: 1,
      name: r'locationId',
      type: IsarType.string,
    ),
    r'order': PropertySchema(
      id: 2,
      name: r'order',
      type: IsarType.long,
    ),
    r'row': PropertySchema(
      id: 3,
      name: r'row',
      type: IsarType.long,
    ),
    r'spanX': PropertySchema(
      id: 4,
      name: r'spanX',
      type: IsarType.long,
    ),
    r'spanY': PropertySchema(
      id: 5,
      name: r'spanY',
      type: IsarType.long,
    ),
    r'widgetType': PropertySchema(
      id: 6,
      name: r'widgetType',
      type: IsarType.string,
    )
  },
  estimateSize: _widgetLayoutModelEstimateSize,
  serialize: _widgetLayoutModelSerialize,
  deserialize: _widgetLayoutModelDeserialize,
  deserializeProp: _widgetLayoutModelDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'locationId': IndexSchema(
      id: 8924247506386354970,
      name: r'locationId',
      unique: false,
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
  getId: _widgetLayoutModelGetId,
  getLinks: _widgetLayoutModelGetLinks,
  attach: _widgetLayoutModelAttach,
  version: '3.1.0+1',
);

int _widgetLayoutModelEstimateSize(
  WidgetLayoutModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.locationId.length * 3;
  bytesCount += 3 + object.widgetType.length * 3;
  return bytesCount;
}

void _widgetLayoutModelSerialize(
  WidgetLayoutModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.col);
  writer.writeString(offsets[1], object.locationId);
  writer.writeLong(offsets[2], object.order);
  writer.writeLong(offsets[3], object.row);
  writer.writeLong(offsets[4], object.spanX);
  writer.writeLong(offsets[5], object.spanY);
  writer.writeString(offsets[6], object.widgetType);
}

WidgetLayoutModel _widgetLayoutModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WidgetLayoutModel();
  object.col = reader.readLong(offsets[0]);
  object.isarId = id;
  object.locationId = reader.readString(offsets[1]);
  object.order = reader.readLong(offsets[2]);
  object.row = reader.readLong(offsets[3]);
  object.spanX = reader.readLong(offsets[4]);
  object.spanY = reader.readLong(offsets[5]);
  object.widgetType = reader.readString(offsets[6]);
  return object;
}

P _widgetLayoutModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _widgetLayoutModelGetId(WidgetLayoutModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _widgetLayoutModelGetLinks(
    WidgetLayoutModel object) {
  return [];
}

void _widgetLayoutModelAttach(
    IsarCollection<dynamic> col, Id id, WidgetLayoutModel object) {
  object.isarId = id;
}

extension WidgetLayoutModelQueryWhereSort
    on QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QWhere> {
  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WidgetLayoutModelQueryWhere
    on QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QWhereClause> {
  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterWhereClause>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterWhereClause>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterWhereClause>
      locationIdEqualTo(String locationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'locationId',
        value: [locationId],
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterWhereClause>
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

extension WidgetLayoutModelQueryFilter
    on QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QFilterCondition> {
  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      colEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'col',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      colGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'col',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      colLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'col',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      colBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'col',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
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

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      locationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      locationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      locationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationId',
        value: '',
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      locationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationId',
        value: '',
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      orderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      orderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      orderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      orderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      rowEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'row',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      rowGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'row',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      rowLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'row',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      rowBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'row',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      spanXEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spanX',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      spanXGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spanX',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      spanXLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spanX',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      spanXBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spanX',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      spanYEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spanY',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      spanYGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spanY',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      spanYLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spanY',
        value: value,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      spanYBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spanY',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      widgetTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      widgetTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      widgetTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      widgetTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'widgetType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      widgetTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      widgetTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      widgetTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'widgetType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      widgetTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'widgetType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      widgetTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widgetType',
        value: '',
      ));
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterFilterCondition>
      widgetTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'widgetType',
        value: '',
      ));
    });
  }
}

extension WidgetLayoutModelQueryObject
    on QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QFilterCondition> {}

extension WidgetLayoutModelQueryLinks
    on QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QFilterCondition> {}

extension WidgetLayoutModelQuerySortBy
    on QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QSortBy> {
  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy> sortByCol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'col', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortByColDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'col', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortByLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortByLocationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy> sortByRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'row', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortByRowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'row', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortBySpanX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spanX', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortBySpanXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spanX', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortBySpanY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spanY', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortBySpanYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spanY', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortByWidgetType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetType', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      sortByWidgetTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetType', Sort.desc);
    });
  }
}

extension WidgetLayoutModelQuerySortThenBy
    on QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QSortThenBy> {
  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy> thenByCol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'col', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenByColDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'col', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenByLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenByLocationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy> thenByRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'row', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenByRowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'row', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenBySpanX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spanX', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenBySpanXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spanX', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenBySpanY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spanY', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenBySpanYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spanY', Sort.desc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenByWidgetType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetType', Sort.asc);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QAfterSortBy>
      thenByWidgetTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetType', Sort.desc);
    });
  }
}

extension WidgetLayoutModelQueryWhereDistinct
    on QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QDistinct> {
  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QDistinct>
      distinctByCol() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'col');
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QDistinct>
      distinctByLocationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locationId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QDistinct>
      distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QDistinct>
      distinctByRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'row');
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QDistinct>
      distinctBySpanX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spanX');
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QDistinct>
      distinctBySpanY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spanY');
    });
  }

  QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QDistinct>
      distinctByWidgetType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'widgetType', caseSensitive: caseSensitive);
    });
  }
}

extension WidgetLayoutModelQueryProperty
    on QueryBuilder<WidgetLayoutModel, WidgetLayoutModel, QQueryProperty> {
  QueryBuilder<WidgetLayoutModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<WidgetLayoutModel, int, QQueryOperations> colProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'col');
    });
  }

  QueryBuilder<WidgetLayoutModel, String, QQueryOperations>
      locationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationId');
    });
  }

  QueryBuilder<WidgetLayoutModel, int, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<WidgetLayoutModel, int, QQueryOperations> rowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'row');
    });
  }

  QueryBuilder<WidgetLayoutModel, int, QQueryOperations> spanXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spanX');
    });
  }

  QueryBuilder<WidgetLayoutModel, int, QQueryOperations> spanYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spanY');
    });
  }

  QueryBuilder<WidgetLayoutModel, String, QQueryOperations>
      widgetTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'widgetType');
    });
  }
}
