import 'package:chuck_interceptor/chuck.dart';
import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// [NetworkService] internet(server) bilan ishlash uchun service
/// bunda ma'lumotlarni olish va yuklash uchun [Dio] dan foydalaniladi

abstract class NetworkService {
  Future<NetworkResponseModel> postMethod({
    required String url,
    required Map body,
    bool hasHeader = true,
  });

  Future<NetworkResponseModel> getMethod({
    required String url,
    bool hasHeader = true,
  });

  Future<NetworkResponseModel> deleteMethod({
    required String url,
    bool hasHeader = true,
  });
}

class NetworkServiceImpl extends NetworkService {
  final HiveDatabase hiveDatabase;
  final Dio dio;
  final Chuck chuck;

  NetworkServiceImpl({
    required this.hiveDatabase,
    required this.dio,
    required this.chuck,
  });

  /// [NetworkServiceImpl.getMethod] method [Dio] kutubxonasining [Dio.get] methodidan foydalanish uchun ishlatiladi
  /// bunda [baseUrl] dan keyingi boradigan manzil ko'rsatiladi

  @override
  Future<NetworkResponseModel> getMethod({
    required String url,
    bool hasHeader = true,
  }) async {
    final header = await _getHeader(hasHeader);
    dio.options.headers = header;
    try {
      if (kDebugMode) {
        print("Request Url: $url");
      }
      final response = await dio.get(url);
      if (kDebugMode) {
        print("Response Url: $url\nResponse: $response");
      }
      return NetworkResponseModel.success(response: response);
    } on DioError catch (error) {
      /// Get request [dioBaseOptions] da ko'rsatilgan vaqtda response kelmasa [DioErrorType.connectTimeout] error beradi

      if (error.type == DioErrorType.connectionTimeout) {
        return NetworkResponseModel.error(
            errorMessage: "Исключение времени ожидания соединения");
      } else {
        return NetworkResponseModel.error(errorMessage: error.message);
      }
    }
  }

  /// [NetworkServiceImpl.postMethod] method [Dio] kutubxonasining [Dio.post] methodidan foydalanish uchun ishlatiladi
  /// bunda [baseUrl] dan keyingi boradigan manzil ko'rsatiladi va body (Map<key, value) beriladi.
  ///
  /// Get bn Post methodlarini farqi, post methodda body qo'shib jo'natiladi

  @override
  Future<NetworkResponseModel> postMethod({
    required String url,
    required Map body,
    bool hasHeader = true,
  }) async {
    final header = await _getHeader(hasHeader);
    dio.options.headers = header;

    try {
      if (kDebugMode) {
        print("Request => Url: $url, body: $body");
        print("Request header => Url: $url, body: $header");
      }
      final response = await dio.post(url, data: body);
      if (kDebugMode) {
        print("Response => Url: $url, response: $response");
      }
      return NetworkResponseModel.success(response: response);
    } on DioError catch (error) {
      if (kDebugMode) {
        print("Response => Url: $url, error: $error");
      }
      if (error.type == DioErrorType.connectionTimeout) {
        return NetworkResponseModel.error(
            errorMessage: "Исключение времени ожидания соединения");
      } else {
        return NetworkResponseModel.error(errorMessage: error.message);
      }
    }
  }

  /// Serverga ma'lumotlarni qanday ko'rinishda jo'natish va qanday ko'rinishda qabul qilishni,
  /// va agar user foydalanuvchi token (auth token) olgan bo'lsa uni ham qo'shib jo'natuvchi mehtod
  Future<Map<String, String>> _getHeader(bool hasHeader) async {
    final Map<String, String> headers = {};
    if (hasHeader) {
      headers["Accept"] = "application/json";
      headers["Content-Type"] = "application/json";

      final String token = await hiveDatabase.getToken();
      if (token.isNotEmpty) headers["Authorization"] = "Bearer $token";
    }
    return headers;
  }

  @override
  Future<NetworkResponseModel> deleteMethod(
      {required String url, bool hasHeader = true}) async {
    final header = await _getHeader(hasHeader);
    dio.options.headers = header;
    try {
      if (kDebugMode) {
        print("Url: $url");
      }
      final response = await dio.delete(url);
      return NetworkResponseModel.success(response: response);
    } on DioError catch (error) {
      /// Get request [dioBaseOptions] da ko'rsatilgan vaqtda response kelmasa [DioErrorType.connectTimeout] error beradi

      if (error.type == DioErrorType.connectionTimeout) {
        return NetworkResponseModel.error(
            errorMessage: "Исключение времени ожидания соединения");
      } else {
        return NetworkResponseModel.error(errorMessage: error.message);
      }
    }
  }
}

final dioBaseOptions = BaseOptions(
  baseUrl: baseUrl,
  sendTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
);

final quramizDioBaseOptions = BaseOptions(
  baseUrl: quramizBaseUrl,
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
);
