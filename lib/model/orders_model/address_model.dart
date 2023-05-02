import 'package:delivery_service/util/service/network/parser_service.dart';

class AddressModel {
  final int id;
  final int userId;
  final String address;
  final String lat;
  final String log;
  final String district;
  final int defaults;
  final String comment;
  final String created_at;
  final String updated_at;

  AddressModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.lat,
    required this.log,
    required this.district,
    required this.defaults,
    required this.comment,
    required this.created_at,
    required this.updated_at,
  });

  factory AddressModel.example() => AddressModel(
        id: 0,
        userId: 0,
        address: "",
        lat: "",
        log: "",
        district: "",
        defaults: 0,
        comment: "",
        created_at: "",
        updated_at: "",
      );

  factory AddressModel.fromMap(Map<String, dynamic> response) => AddressModel(
        id: parseToInt(response: response, key: "id"),
        userId: parseToInt(response: response, key: "user_id"),
        address: parseToString(response: response, key: "address"),
        lat: parseToString(response: response, key: "latitude"),
        log: parseToString(response: response, key: "longitude"),
        district: parseToString(response: response, key: "district"),
        defaults: parseToInt(response: response, key: "default"),
        comment: parseToString(response: response, key: "comment"),
        created_at: parseToString(response: response, key: "created_at"),
        updated_at: parseToString(response: response, key: "updated_at"),
      );

  AddressModel copyWith({
    int? id,
    int? userId,
    String? address,
    String? lat,
    String? log,
    String? district,
    int? defaults,
    String? comment,
    String? created_at,
    String? updated_at,
  }) =>
      AddressModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        address: address ?? this.address,
        lat: lat ?? this.lat,
        log: log ?? this.log,
        district: district ?? this.district,
        defaults: defaults ?? this.defaults,
        comment: comment ?? this.comment,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
      );
}
