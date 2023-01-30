import 'package:delivery_service/util/service/network/parser_service.dart';

class OtpModel {
  final int id;
  final String token;
  final String name;
  final String phone_number;
  final String created_at;
  final String updated_at;

  OtpModel({
    required this.id,
    required this.token,
    required this.name,
    required this.phone_number,
    required this.created_at,
    required this.updated_at,
  });

  factory OtpModel.formMap(Map<String, dynamic> response) => OtpModel(
        id: parseToInt(response: response, key: "id"),
        token: parseToString(response: response, key: "token"),
        name: parseToString(response: response, key: "name"),
        phone_number: parseToString(response: response, key: "phone_number"),
        created_at: parseToString(response: response, key: "created_at"),
        updated_at: parseToString(response: response, key: "updated_at"),
      );

  factory OtpModel.example() => OtpModel(
        id: 0,
        token: "",
        name: "",
        phone_number: "",
        created_at: "",
        updated_at: "",
      );
}
