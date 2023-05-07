import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class RestaurantNetworkService {
  Future<NetworkResponseModel> getAllRestaurants();

  Future<NetworkResponseModel> getCategoryRestaurants({
    required int categoryId,
  });

  Future<NetworkResponseModel> getRestaurantDetails({
    required int restaurantId,
  });
}

class RestaurantNetworkServiceImpl extends RestaurantNetworkService {
  final NetworkService networkService;

  RestaurantNetworkServiceImpl({required this.networkService});

  /// getAllRestaurants
  @override
  Future<NetworkResponseModel> getAllRestaurants() async {
    final response = await networkService.getMethod(url: allRestaurantsUrl);
    return response;
  }

  /// getCategoryRestaurants
  @override
  Future<NetworkResponseModel> getCategoryRestaurants({
    required int categoryId,
  }) async {
    final response = await networkService.getMethod(
        url: "$allRestaurantsUrl?category=$categoryId");
    return response;
  }

  /// getRestaurantDetails
  @override
  Future<NetworkResponseModel> getRestaurantDetails({
    required int restaurantId,
  }) async {
    final response =
        await networkService.getMethod(url: "$allRestaurantsUrl/$restaurantId");
    return response;
  }
}
