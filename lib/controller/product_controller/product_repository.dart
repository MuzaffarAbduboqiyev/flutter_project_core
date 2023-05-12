import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/product_model/product_detail_model.dart';
import 'package:delivery_service/model/product_model/product_model.dart';
import 'package:delivery_service/model/product_model/product_network_service.dart';
import 'package:delivery_service/model/product_model/product_variation_model.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';
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
  });

  /// shu joyda Funksiya ishlaydi
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

  /// delete Products
  Future<SimpleResponseModel> deleteProducts({
    required int productId,
    required int variationId,
  });
}

class ProductRepositoryImpl extends ProductRepository {
  final ProductNetworkService productNetworkService;
  final MoorDatabase moorDatabase;
  final HiveDatabase hiveDatabase;

  ProductRepositoryImpl({
    required this.productNetworkService,
    required this.moorDatabase,
    required this.hiveDatabase,
  });

  @override
  Future<DataResponseModel<List<ProductModel>>> getRestaurantProducts({
    required int restaurantId,
    required int categoryId,
    required String searchName,
  }) async {
    try {
      final response = await productNetworkService.getRestaurantProducts(
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
  }) async {
    try {
      final response =
          await productNetworkService.getProductDetail(productId: productId);
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

  /// shu joyda Funksiya ishlaydi
  @override
  Future<SimpleResponseModel> changeProductSelectedDatabase({
    required BuildContext context,
    required int productId,
    required int restaurantId,
    required String productImage,
    required List<ProductVariationModel> selectedVariations,
  }) async {
    try {
      final getToken = await hiveDatabase.getToken();
      final databaseProducts = await moorDatabase.getCartProducts();
      final List<Map<String, int>> products = [];

      for (var variationElement in selectedVariations) {
        final cartProduct = {
          "id": variationElement.id,
          "quantity": variationElement.selectedCount,
        };
        products.add(cartProduct);
      }

      /// if qismiz
      if (getToken.isNotEmpty) {
        final body = {"products": products};
        final response = await productNetworkService.checkInfo(body: body);
        if (response.status == true && response.response != null) {
          if (response.response?.data.containsKey("data")) {
            List<ProductCartData> productData = [];
            response.response?.data["data"].forEach((element) {
              final productCartData = ProductCartData(
                variationId: parseToInt(response: element, key: "id"),
                price: parseToInt(response: element, key: "price"),
                count: parseToInt(response: element, key: "quantity"),
                restaurantId: restaurantId,
                productId: parseToInt(response: element["product"], key: "id"),
                name: parseToString(response: element["product"], key: "name"),
                image:
                    parseToString(response: element["product"], key: "image"),
                hasStock:
                    parseToBool(response: element["product"], key: "in_stock"),
                selectedCount: parseToInt(response: element, key: "quantity"),
              );

              productData.add(productCartData);
            });

            await moorDatabase.clearProductCart();
            for (var element in productData) {
              await moorDatabase.insertProductCart(productCartData: element);
            }
            return SimpleResponseModel.success();
          } else {
            return getSimpleResponseErrorHandler(response);
          }
        } else {
          return getSimpleResponseErrorHandler(response);
        }
      }

      /// else qismi
      else {
        if (databaseProducts.isNotEmpty &&
            databaseProducts.first.restaurantId != restaurantId) {
          // ignore: use_build_context_synchronously
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

  /// delete products

  @override
  Future<SimpleResponseModel> deleteProducts({
    required int productId,
    required int variationId,
  }) async {
    try {
      final getToken = await hiveDatabase.getToken();
      print("getToken: ${getToken.isNotEmpty}");
      if (getToken.isNotEmpty) {
        final response =
            await productNetworkService.deleteCart(variationId: variationId);

        if (response.status == true && response.response != null) {
          if (response.response?.data.containsKey("data")) {
            await moorDatabase.deleteProductVariation(
                productId: productId, variationId: variationId);
            return SimpleResponseModel.success();
          } else {
            return getSimpleResponseErrorHandler(response);
          }
        } else {
          return getSimpleResponseErrorHandler(response);
        }
      }

      /// else qismi
      else {
        final response =
            await productNetworkService.deleteCart(variationId: variationId);

        if (response.status == true && response.response != null) {
          if (response.response?.data.containsKey("data")) {
            await moorDatabase.deleteProductVariation(
                productId: productId, variationId: variationId);
            return SimpleResponseModel.success();
          } else {
            return getSimpleResponseErrorHandler(response);
          }
        } else {
          return getSimpleResponseErrorHandler(response);
        }
      }
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }
}