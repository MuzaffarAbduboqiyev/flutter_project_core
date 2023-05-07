import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class RestaurantSearchNetworkService {
  Future<NetworkResponseModel> restaurantSearchUrl({
    required int restaurantId,
    required String searchName,
  });
}

class RestaurantSearchNetworkServiceImpl
    extends RestaurantSearchNetworkService {
  final NetworkService networkService;

  RestaurantSearchNetworkServiceImpl({required this.networkService});

  /// restaurant search product
  @override
  Future<NetworkResponseModel> restaurantSearchUrl({
    required int restaurantId,
    required String searchName,
  }) async {
    final response = await networkService.getMethod(
        url:
            "$restaurantsSearchUrl?restaurant=$restaurantId&search=$searchName");
    return response;
  }
}
