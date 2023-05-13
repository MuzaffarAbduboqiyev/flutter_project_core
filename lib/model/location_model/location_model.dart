import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';
import 'package:moor_flutter/moor_flutter.dart';

class Location extends Table {
  IntColumn get id => integer()();

  TextColumn get lat => text()();

  TextColumn get lng => text()();

  BoolColumn get defaults => boolean()();

  TextColumn get address => text()();

  TextColumn get comment => text()();

  TextColumn get created => text()();

  TextColumn get updated => text()();

  BoolColumn get selectedStatus => boolean()();

  @override
  Set<Column>? get primaryKey => {id, lat, lng};
}

final exampleLocationData = LocationData(
  id: 0,
  lat: "",
  lng: "",
  address: "",
  comment: "",
  updated: "",
  created: "",
  defaults: false,
  selectedStatus: false,
);

List<LocationData> parseToLocationModelList({
  required List<dynamic> response,
}) {
  return response.map((e) => parseToLocationModel(response: e)).toList();
}

LocationData parseToLocationModel({
  required dynamic response,
}) =>
    LocationData(
      id: parseToInt(response: response, key: "id"),
      lat: parseToString(response: response, key: "latitude"),
      lng: parseToString(response: response, key: "longitude"),
      defaults: parseToBool(response: response, key: "default"),
      address: parseToString(response: response, key: "address"),
      comment: parseToString(response: response, key: "comment"),
      created: parseToString(response: response, key: "created_at"),
      updated: parseToString(response: response, key: "updated_at"),
      selectedStatus: parseToBool(response: response, key: "default"),
    );
