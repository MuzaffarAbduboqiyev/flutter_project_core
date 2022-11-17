import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/product_model/product_network_service.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';

abstract class ProductRepository {
  Future<DataResponseModel<List<ProductModel>>> getRestaurantProducts({
    required int restaurantId,
    required int categoryId,
    required String searchName,
  });
}

class ProductRepositoryImpl extends ProductRepository {
  final ProductNetworkService networkService;

  ProductRepositoryImpl({required this.networkService});

  @override
  Future<DataResponseModel<List<ProductModel>>> getRestaurantProducts({
    required int restaurantId,
    required int categoryId,
    required String searchName,
  }) async {
    try {
      final response = await networkService.getRestaurantProducts(
        restaurantId: restaurantId,
        categoryId: categoryId,
        searchName: searchName,
      );

      if (response.status &&
          response.response != null &&
          response.response?.data.containsKey("data")) {
        final List<ProductModel> products =
            parseProductModel(response.response?.data["data"]);
        return DataResponseModel.success(model: products);
      } else {
        return getDataResponseErrorHandler<List<ProductModel>>(response);
      }
    } catch (error) {
      return DataResponseModel.error(responseMessage: error.toString());
    }
  }
}
