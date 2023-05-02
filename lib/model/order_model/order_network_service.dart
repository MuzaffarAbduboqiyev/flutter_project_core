import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class OrderNetworkService {
  Future<NetworkResponseModel> getShippingUrl({required int addressId});

  Future<NetworkResponseModel> getPaymentCheckUrl();

  Future<NetworkResponseModel> getPaymentRequestUrl({required Map body});
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
  Future<NetworkResponseModel> getPaymentCheckUrl() async {
    final response = await networkService.getMethod(url: paymentUrl);

    return response;
  }

  @override
  Future<NetworkResponseModel> getPaymentRequestUrl(
      {required Map<dynamic, dynamic> body}) async {
    final response = networkService.postMethod(url: ordersUrl, body: body);

    return response;
  }
}
