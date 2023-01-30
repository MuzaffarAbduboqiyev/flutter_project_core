import 'package:delivery_service/util/service/network/parser_service.dart';

class ProfileModel {
  final int id;
  final String name;
  final String phone_number;
  final String created_at;
  final String updated_at;

  ProfileModel({
    required this.id,
    required this.name,
    required this.phone_number,
    required this.created_at,
    required this.updated_at,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> response) => ProfileModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        phone_number: parseToString(response: response, key: "phone_number"),
        created_at: parseToString(response: response, key: "created_at"),
        updated_at: parseToString(response: response, key: "updated_at"),
      );

  factory ProfileModel.example() => ProfileModel(
        id: 0,
        name: "",
        phone_number: "",
        created_at: "",
        updated_at: "",
      );

}

