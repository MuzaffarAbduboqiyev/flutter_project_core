import 'package:dio/dio.dart';

class NetworkResponseModel {
  bool status;
  Response? response;
  String? errorMessage;

  NetworkResponseModel({
    required this.status,
    required this.response,
    required this.errorMessage,
  });

  factory NetworkResponseModel.success({Response? response}) =>
      NetworkResponseModel(
        status: true,
        response: response,
        errorMessage: null,
      );

  factory NetworkResponseModel.error({String? errorMessage}) =>
      NetworkResponseModel(
        status: false,
        response: null,
        errorMessage: errorMessage,
      );
}
