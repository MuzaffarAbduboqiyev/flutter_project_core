import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class OrdersNetworkService {
  Future<NetworkResponseModel> getOrdersUrl();
}

class OrdersNetworkServiceImpl extends OrdersNetworkService {
  final NetworkService networkService;

  OrdersNetworkServiceImpl({required this.networkService});

  @override
  Future<NetworkResponseModel> getOrdersUrl() async {
    final response = await networkService.getMethod(url: ordersUrl);
    print("OrdersNetworkService ordersNetworkService: $response");
    return response;
  }
}
