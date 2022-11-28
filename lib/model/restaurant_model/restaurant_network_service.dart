import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class RestaurantNetworkService {
  Future<NetworkResponseModel> getAllRestaurants();// Barcha restoranlarni oling

  Future<NetworkResponseModel> getCategoryRestaurants({ // Kategoriyali restoranlarni oling
    required int categoryId,
  });

  Future<NetworkResponseModel> getRestaurantDetails({ // Restoran tafsilotlarini oling
    required int restaurantId,
  });
}

class RestaurantNetworkServiceImpl extends RestaurantNetworkService {
  final NetworkService networkService;

  RestaurantNetworkServiceImpl({required this.networkService});

  @override
  // getAllRestaurants =  Barcha restoranlarni oling
  Future<NetworkResponseModel> getAllRestaurants() async {
    final response = await networkService.getMethod(url: allRestaurantsUrl);
    return response;
  }

  @override
  // getCategoryRestaurants = Kategoriyali restoranlarni oling
  Future<NetworkResponseModel> getCategoryRestaurants({
    required int categoryId,
  }) async {
    final response = await networkService.getMethod(
        url: "$allRestaurantsUrl?category=$categoryId");
    return response;
  }

  @override
  // getRestaurantDetails = Restoran tafsilotlarini oling
  Future<NetworkResponseModel> getRestaurantDetails({
    required int restaurantId,
  }) async {
    final response =
        await networkService.getMethod(url: "$allRestaurantsUrl/$restaurantId");
    return response;
  }
}
