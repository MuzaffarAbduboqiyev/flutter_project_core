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

  /// factory = zavod
  /// success = muvaffaqiyat
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

/// SimpleResponseModel = OddiyJavobModel
/// [SimpleResponseModel] responseda faqat true/false qiymat qaytarish uchun
/// Agar response [SimpleResponseModel.status] false bo'lsa [SimpleResponseModel.message] ga qanday error bo'lgani beriladi
class SimpleResponseModel {
  final bool status;
  final String? message;

  SimpleResponseModel({
    required this.status,
    required this.message,
  });
  factory SimpleResponseModel.success({String? responseMessage}) =>
      SimpleResponseModel(
        status: true,
        message: responseMessage,
      );

  factory SimpleResponseModel.error({String? responseMessage}) =>
      SimpleResponseModel(
        status: false,
        message: responseMessage,
      );
}

/// Generic T => type (toifa) bo'lib, qaysi model, class yoki type(int, String, double, bool, List) berilsa
/// [DataResponseModel.data] T toifada bo'ladi
class DataResponseModel<T> {
  bool status;
  T? data;
  String? message;

  DataResponseModel({required this.status, this.data, this.message});

  factory DataResponseModel.success(
          {required T? model, String? responseMessage}) =>
      DataResponseModel(status: true, data: model, message: responseMessage);

  factory DataResponseModel.error({required String? responseMessage}) =>
      DataResponseModel(status: false, data: null, message: responseMessage);
}
