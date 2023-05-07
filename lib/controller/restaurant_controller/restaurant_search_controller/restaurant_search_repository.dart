import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_search_network_service.dart';

abstract class RestaurantSearchRepository {
  /// restaurant search product
  Future<DataResponseModel<List<ProductModel>>> restaurantSearchProduct({
    required int restaurantId,
    required String searchName,
  });

  /// moor listen product
  Stream<List<ProductCartData>> listenProducts();
}

class RestaurantSearchRepositoryImpl extends RestaurantSearchRepository {
  final RestaurantSearchNetworkService restaurantSearchNetworkService;
  final MoorDatabase moorDatabase;

  RestaurantSearchRepositoryImpl(
      {required this.restaurantSearchNetworkService,
      required this.moorDatabase});

  /// restaurant search product
  @override
  Future<DataResponseModel<List<ProductModel>>> restaurantSearchProduct(
      {required int restaurantId, required String searchName}) async {
    try {
      final response = await restaurantSearchNetworkService.restaurantSearchUrl(
          restaurantId: restaurantId, searchName: searchName);
      if (response.status && response.response != null) {
        if (response.response?.data.containsKey("data") == true) {
          final List<ProductModel> productModel =
              parseProductModel(response.response?.data["data"]);
          return DataResponseModel.success(model: productModel);
        } else {
          return getDataResponseErrorHandler<List<ProductModel>>(response);
        }
      } else {
        return getDataResponseErrorHandler<List<ProductModel>>(response);
      }
    } catch (error) {
      return DataResponseModel.error(responseMessage: error.toString());
    }
  }

  /// moor listen product
  @override
  Stream<List<ProductCartData>> listenProducts() =>
      moorDatabase.listenCartProducts();
}
