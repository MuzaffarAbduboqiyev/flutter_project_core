import 'package:delivery_service/controller/category_controller/category_repository.dart';
import 'package:delivery_service/controller/product_controller/product_repository.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_network_service.dart';
import 'package:delivery_service/util/extensions/restaurant_extension.dart';

abstract class RestaurantRepository {
  Future<DataResponseModel<List<RestaurantModel>>> getAllRestaurants();

  Future<DataResponseModel<List<RestaurantModel>>> getCategoryRestaurants({
    required int categoryId,
  });

  Future<DataResponseModel<List<CategoryModel>>> getRestaurantCategories({
    required int restaurantId,
  });

  Future<DataResponseModel<RestaurantModel>> getRestaurantDetails({
    required int restaurantId,
  });

  Future<bool> changeRestaurantFavoriteState({
    required RestaurantModel restaurantModel,
  });

  Future<bool> getFavoriteState({
    required int restaurantId,
  });

  Future<DataResponseModel<List<ProductModel>>> getRestaurantProducts({
    required int restaurantId,
    required int categoryId,
    required String searchName,
  });


  // listenCartProducts = Savat mahsulotlarini tinglang
  Stream<List<ProductCartData>> listenCartProducts();


  // getCartProducts = Savat mahsulotlarini oling
  Future<List<ProductCartData>> getCartProducts();


}

class RestaurantRepositoryImpl extends RestaurantRepository {
  final RestaurantNetworkService networkService;
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;
  final MoorDatabase moorDatabase;

  RestaurantRepositoryImpl({
    required this.networkService,
    required this.categoryRepository,
    required this.productRepository,
    required this.moorDatabase,
  });

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

  @override
  Future<DataResponseModel<List<CategoryModel>>> getRestaurantCategories({
    required int restaurantId,
  }) async {
    final response = await categoryRepository.getRestaurantCategories(
      restaurantId: restaurantId,
    );
    return response;
  }

  @override
  Future<DataResponseModel<List<ProductModel>>> getRestaurantProducts({
  required int restaurantId,
    required int categoryId,
    required String searchName,
  }) async {
    final response = await productRepository.getRestaurantProducts(
      restaurantId: restaurantId,
      categoryId: categoryId,
      searchName: searchName,
    );

    return response;
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

  @override
  Future<bool> changeRestaurantFavoriteState({
    required RestaurantModel restaurantModel,
  }) async {
    final response = await moorDatabase.getSingleFavorite(restaurantModel.id);

    (response == null)
        ? await moorDatabase
            .insertFavorite(restaurantModel.parseToFavoriteModel())
        : await moorDatabase.deleteFavorite(restaurantModel.id);
    return true;
  }

  @override
  Future<bool> getFavoriteState({required int restaurantId}) async {
    final response = await moorDatabase.getSingleFavorite(restaurantId);
    return response != null;
  }

  @override
  Stream<List<ProductCartData>> listenCartProducts() =>
      productRepository.listenCartProducts();

  @override
  Future<List<ProductCartData>> getCartProducts() => productRepository.getCartProducts();
}
