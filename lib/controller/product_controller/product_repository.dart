import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/product_model/product_detail_model.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/product_model/product_network_service.dart';
import 'package:delivery_service/model/product_model/product_variation_model.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:flutter/material.dart';

abstract class ProductRepository {
  Future<DataResponseModel<List<ProductModel>>> getRestaurantProducts({
    required int restaurantId,
    required int categoryId,
    required String searchName,
  });

  Future<DataResponseModel<ProductDetailModel>> getProductDetail({
    required int productId,
    required int restaurantId,
    required String productImage,
  });

  Future<SimpleResponseModel> changeProductSelectedDatabase({
    required BuildContext context,
    required int productId,
    required int restaurantId,
    required String productImage,
    required List<ProductVariationModel> selectedVariations,
  });

  Stream<List<ProductCartData>> listenCartProducts();

  Future<List<ProductCartData>> getCartProducts();

  Future<SimpleResponseModel> clearCartProducts();
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
  Future<DataResponseModel<ProductDetailModel>> getProductDetail({
    required int productId,
    required int restaurantId,
    required String productImage,
  }) async {
    try {
      final response = await networkService.getProductDetail(
          productId: productId, productImage: productImage);
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
    required BuildContext context,
    required int productId,
    required int restaurantId,
    required String productImage,
    required List<ProductVariationModel> selectedVariations,
  }) async {
    try {
      final databaseProducts = await moorDatabase.getCartProducts();
      if (databaseProducts.isNotEmpty &&
          databaseProducts.first.restaurantId != restaurantId) {
        final response = await showConfirmDialog(
          context: context,
          title: translate("clear_history"),
          content: translate("history"),
          confirm: clearCartProducts,
        );

        if (response != null && response == true) {
          await moorDatabase.deleteProduct(productId: productId);
          for (var element in selectedVariations) {
            await moorDatabase.insertProductCart(
                productCartData: element.parseToCartModel(
                    restaurantId, productId, productImage));
          }
        }
      } else {
        await moorDatabase.deleteProduct(productId: productId);
        for (var element in selectedVariations) {
          await moorDatabase.insertProductCart(
              productCartData: element.parseToCartModel(
                  restaurantId, productId, productImage));
        }
      }

      return SimpleResponseModel.success();
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Stream<List<ProductCartData>> listenCartProducts() =>
      moorDatabase.listenCartProducts();

  @override
  Future<List<ProductCartData>> getCartProducts() =>
      moorDatabase.getCartProducts();

  @override
  Future<SimpleResponseModel> clearCartProducts() async {
    await moorDatabase.clearProductCart();
    return SimpleResponseModel.success();
  }
}
