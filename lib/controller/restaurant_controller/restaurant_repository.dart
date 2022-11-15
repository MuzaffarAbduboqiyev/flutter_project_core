import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_network_service.dart';

abstract class RestaurantRepository {
  Future<DataResponseModel<List<RestaurantModel>>> getAllRestaurants();

  Future<DataResponseModel<List<RestaurantModel>>> getCategoryRestaurants({
    required int categoryId,
  });

  Future<DataResponseModel<RestaurantModel>> getRestaurantDetails({
    required int restaurantId,
  });
}

class RestaurantRepositoryImpl extends RestaurantRepository {
  final RestaurantNetworkService networkService;

  RestaurantRepositoryImpl({required this.networkService});

  @override
  Future<DataResponseModel<List<RestaurantModel>>> getAllRestaurants() async {
    final response = await networkService.getAllRestaurants();
    return _parseRestaurants(response);
  }

  @override
  Future<DataResponseModel<List<RestaurantModel>>> getCategoryRestaurants({
    required int categoryId,
  }) async {
    final response =
        await networkService.getCategoryRestaurants(categoryId: categoryId);
    return _parseRestaurants(response);
  }

  @override
  Future<DataResponseModel<RestaurantModel>> getRestaurantDetails({
    required int restaurantId,
  }) async {
    final response =
        await networkService.getRestaurantDetails(restaurantId: restaurantId);
    final parsedModel = _parseRestaurants(response);
    if (parsedModel.status &&
        parsedModel.data != null &&
        (parsedModel.data?.isNotEmpty ?? false)) {
      return DataResponseModel.success(model: parsedModel.data?[0]);
    } else {
      return DataResponseModel.error(responseMessage: parsedModel.message);
    }
  }

  DataResponseModel<List<RestaurantModel>> _parseRestaurants(
      NetworkResponseModel response) {
    try {
      if (response.status &&
          response.response != null &&
          response.response?.data.containsKey("data")) {
        final List<RestaurantModel> restaurants =
            parseRestaurantModel(response.response?.data["data"]);

        return DataResponseModel.success(model: restaurants);
      } else {
        return getDataResponseErrorHandler<List<RestaurantModel>>(response);
      }
    } catch (error) {
      return DataResponseModel.error(
        responseMessage: error.toString(),
      );
    }
  }
}
