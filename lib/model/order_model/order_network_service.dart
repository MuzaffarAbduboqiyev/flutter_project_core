import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class OrderNetworkService {
  /// order shipping
  Future<NetworkResponseModel> getShippingUrl({required int addressId});

  /// refresh product GetMethod
  Future<NetworkResponseModel> refreshGetMethodUrl();

  /// Upload cart products to server
  Future<NetworkResponseModel> uploadCartProducts({
    required Map<dynamic, dynamic> body,
  });

  /// refresh product PostMethod
  Future<NetworkResponseModel> refreshPostMethodUrl(
      {required Map<dynamic, dynamic> body});

  Future<NetworkResponseModel> fetchPaymentModels();

  Future<NetworkResponseModel> order({
    required Map body,
  });
}

class OrderNetworkServiceImpl extends OrderNetworkService {
  final NetworkService networkService;

  OrderNetworkServiceImpl({
    required this.networkService,
  });

  @override
  Future<NetworkResponseModel> getShippingUrl({required int addressId}) async {
    final response =
        await networkService.getMethod(url: "addresses/$addressId/shipping");
    print("NetworkService addressId: $addressId");
    return response;
  }

  @override
  Future<NetworkResponseModel> refreshGetMethodUrl() async {
    final response = await networkService.getMethod(url: cartUrl);
    return response;
  }

  @override
  Future<NetworkResponseModel> refreshPostMethodUrl(
      {required Map<dynamic, dynamic> body}) async {
    final response = networkService.postMethod(url: cartUrl, body: body);
    return response;
  }

  @override
  Future<NetworkResponseModel> uploadCartProducts({
    required Map<dynamic, dynamic> body,
  }) async {
    final response = await networkService.postMethod(url: cartUrl, body: body);
    return response;
  }

  @override
  Future<NetworkResponseModel> fetchPaymentModels() async {
    final response = await networkService.getMethod(url: paymentUrl);
    return response;
  }

  @override
  Future<NetworkResponseModel> order({
    required Map<dynamic, dynamic> body,
  }) async {
    final response = networkService.postMethod(url: ordersUrl, body: body);
    return response;
  }
}
