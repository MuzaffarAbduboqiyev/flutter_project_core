import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/product_model/product_detail_model.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/product_model/product_network_service.dart';
import 'package:delivery_service/model/product_model/product_variation_model.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';

abstract class ProductRepository {
  Future<DataResponseModel<List<ProductModel>>> getRestaurantProducts({
    required int restaurantId,
    required int categoryId,
    required String searchName,
  });

  Future<DataResponseModel<ProductDetailModel>> getProductDetail({
    required int productId,
  });

  Future<SimpleResponseModel> changeProductSelectedDatabase({
    required int productId,
    required List<ProductVariationModel> selectedVariations,
  });
}

class ProductRepositoryImpl extends ProductRepository {
  final ProductNetworkService networkService;
  final MoorDatabase moorDatabase;

  ProductRepositoryImpl({
    required this.networkService,
    required this.moorDatabase,
  });

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

  @override
  Future<DataResponseModel<ProductDetailModel>> getProductDetail(
      {required int productId}) async {
    try {
      final response = await networkService.getProductDetail(
        productId: productId,
      );
      if (response.status &&
          response.response != null &&
          response.response?.data.containsKey("data")) {
        final ProductDetailModel productDetailModel =
            ProductDetailModel.fromMap(response.response?.data["data"]);

        final List<ProductCartData> databaseVariations =
            await moorDatabase.getProductVariations(productId: productId);

        if (databaseVariations.isNotEmpty) {
          for (ProductCartData databaseVariation in databaseVariations) {
            productDetailModel.variations
                .asMap()
                .forEach((index, productVariation) {
              if (databaseVariation.variationId == productVariation.id) {
                productDetailModel.variations[index] =
                    productVariation.copyWith(
                  selectedCount: databaseVariation.selectedCount,
                );
              }
            });
          }
        }
        return DataResponseModel.success(model: productDetailModel);
      } else {
        return getDataResponseErrorHandler<ProductDetailModel>(response);
      }
    } catch (error) {
      return DataResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Future<SimpleResponseModel> changeProductSelectedDatabase({
    required int productId,
    required List<ProductVariationModel> selectedVariations,
  }) async {
    try {
      await moorDatabase.deleteProduct(productId: productId);
      for (var element in selectedVariations) {
        await moorDatabase.insertProductCart(
            productCartData: element.parseToCartModel(productId));
      }

      return SimpleResponseModel.success();
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }
}
