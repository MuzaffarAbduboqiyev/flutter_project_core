import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';
import 'package:dio/dio.dart';

class LocationNetworkService {
  final Dio dio;

  LocationNetworkService({required this.dio});

  factory LocationNetworkService.initial() => LocationNetworkService(
        dio: Dio(quramizDioBaseOptions),
      );

  Future<NetworkResponseModel> locationInfo({
    required String lat,
    required String lng,
  }) async {
    try {
      final response = await dio.post(
        locationUrl,
        data: {
          "lat": lat,
          "lng": lng,
        },
      );
      return NetworkResponseModel.success(response: response);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectionTimeout) {
        return NetworkResponseModel.error(
            errorMessage: "Исключение времени ожидания соединения");
      } else {
        return NetworkResponseModel.error(errorMessage: error.message);
      }
    }
  }
}
