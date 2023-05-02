import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class PaymentNetworkService {
  Future<NetworkResponseModel> getPaymentCheckUrl();

  Future<NetworkResponseModel> getPaymentRequestUrl({required Map body});
}

class PaymentNetworkServiceImpl extends PaymentNetworkService {
  final NetworkService networkService;

  PaymentNetworkServiceImpl({required this.networkService});

  @override
  Future<NetworkResponseModel> getPaymentCheckUrl() async {
    final response = await networkService.getMethod(url: paymentUrl);
    print("PaymentNetworkServiceImpl PaymentCheckUrl: $response");
    return response;
  }

  @override
  Future<NetworkResponseModel> getPaymentRequestUrl(
      {required Map<dynamic, dynamic> body}) async {
    final response =
         networkService.postMethod(url: ordersUrl, body: body);
    print("PaymentNetworkServiceImpl PaymentRequest: $response");
    return response;
  }
}
