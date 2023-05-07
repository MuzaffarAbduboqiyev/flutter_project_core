import 'package:delivery_service/controller/location_controller/location_repository.dart';
import 'package:delivery_service/controller/product_controller/product_repository.dart';
import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/payment_model/order_model.dart';
import 'package:delivery_service/model/order_model/order_network_service.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';
import 'package:hive/hive.dart';

abstract class OrderRepository {
  Stream<List<ProductCartData>> listenCartProducts();

  Future<SimpleResponseModel> updateCart({
    required ProductCartData cartData,
  });

  Future<SimpleResponseModel> deleteCart({
    required ProductCartData deleteCartData,
    required int productId,
    required int variationId,
  });

  Future<bool> clearOrderHistory({
    required int productId,
    required int variationId,
  });

  /// order shipping
  Future<DataResponseModel<List<OrderShippingModel>>> getOrderShipping(
      {required int addressId});

  /// listen token
  Stream<BoxEvent> listenToken();

  /// get Token
  Future<bool> getTokenInfo();

  /// restaurant search
  Future<SimpleResponseModel> refreshProducts();
}

class OrderRepositoryImpl extends OrderRepository {
  final ProductRepository productRepository;
  final OrderNetworkService orderNetworkService;
  final MoorDatabase moorDatabase;
  final HiveDatabase hiveDatabase;

  OrderRepositoryImpl({
    required this.productRepository,
    required this.orderNetworkService,
    required this.moorDatabase,
    required this.hiveDatabase,
  });

  /// product listen
  @override
  Stream<List<ProductCartData>> listenCartProducts() =>
      moorDatabase.listenCartProducts();

  Future<List<ProductCartData>> getCartProducts() => getCartProducts();

  @override
  Future<SimpleResponseModel> updateCart(
      {required ProductCartData cartData}) async {
    try {
      await moorDatabase.insertProductCart(productCartData: cartData);
      return SimpleResponseModel.success();
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Future<SimpleResponseModel> deleteCart({
    required ProductCartData deleteCartData,
    required int productId,
    required int variationId,
  }) async {
    try {
      await moorDatabase.deleteProductVariation(
        productId: deleteCartData.productId,
        variationId: deleteCartData.variationId,
      );

      await productRepository.deleteProducts(
        productId: productId,
        variationId: variationId,
      );
      return SimpleResponseModel.success();
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Future<bool> clearOrderHistory({
    required int productId,
    required int variationId,
  }) async {
    await moorDatabase.clearOrderHistory();
    return true;
  }

  @override
  Future<DataResponseModel<List<OrderShippingModel>>> getOrderShipping({
    required int addressId,
  }) async {
    try {
      final response =
          await orderNetworkService.getShippingUrl(addressId: addressId);
      if (response.status && response.response != null) {
        if (response.response?.data.containsKey("data") == true) {
          final List<OrderShippingModel> orderModel =
              parseShippingModel(response.response?.data["data"]);
          return DataResponseModel.success(model: orderModel);
        } else {
          return getDataResponseErrorHandler<List<OrderShippingModel>>(
              response);
        }
      } else {
        return getDataResponseErrorHandler<List<OrderShippingModel>>(response);
      }
    } catch (error) {
      return DataResponseModel.error(responseMessage: error.toString());
    }
  }

  /// listen token
  @override
  Stream<BoxEvent> listenToken() => hiveDatabase.listenToken();

  /// get Token
  @override
  Future<bool> getTokenInfo() async {
    final response = await hiveDatabase.getToken();
    return response.isNotEmpty;
  }

  /// refresh product
  @override
  Future<SimpleResponseModel> refreshProducts() async {
    try {
      final responseGet = await orderNetworkService.refreshGetMethodUrl();

      if (responseGet.status == true && responseGet.response != null) {
        if (responseGet.response?.data.containsKey("data")) {
          List<ProductCartData> productData = [];
          responseGet.response?.data["data"].forEach((element) {
            final productCartData = ProductCartData(
              restaurantId: parseToInt(
                  response: element["product"], key: "restaurant_id"),
              price: parseToInt(response: element, key: "price"),
              count: parseToInt(response: element, key: "quantity"),
              productId: parseToInt(response: element["product"], key: "id"),
              name: parseToString(response: element["product"], key: "name"),
              image: parseToString(response: element["product"], key: "image"),
              hasStock:
                  parseToBool(response: element["product"], key: "in_stock"),
              variationId: parseToInt(response: element, key: "id"),
              selectedCount: parseToInt(response: element, key: "quantity"),
            );

            productData.add(productCartData);
          });

          for (var element in productData) {
            await moorDatabase.insertProductCart(productCartData: element);
          }

          return SimpleResponseModel.success();
        } else {
          return getSimpleResponseErrorHandler(responseGet);
        }
      } else {
        return getSimpleResponseErrorHandler(responseGet);
      }
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }
}

/*
  /// refresh product
  @override
  Future<SimpleResponseModel> refreshProducts() async {
    try {
      final getToken = await hiveDatabase.getToken();
      final databaseProducts = await moorDatabase.getCartProducts();
      final List<Map<String, int>> products = [];

      for (var variationElement in databaseProducts) {
        final cartProduct = {
          "id": variationElement.productId,
          "quantity": variationElement.selectedCount,
        };
        products.add(cartProduct);
      }

      if (getToken.isNotEmpty) {
        final responseGet = await orderNetworkService.refreshGetMethodUrl();

        if (responseGet.status == true && responseGet.response != null) {
          if (responseGet.response?.data.containsKey("data")) {
            List<ProductCartData> productData = [];
            responseGet.response?.data["data"].forEach((element) {
              final productCartData = ProductCartData(
                restaurantId: parseToInt(
                    response: element["product"], key: "restaurant_id"),
                price: parseToInt(response: element, key: "price"),
                count: parseToInt(response: element, key: "quantity"),
                productId: parseToInt(response: element["product"], key: "id"),
                name: parseToString(response: element["product"], key: "name"),
                image:
                    parseToString(response: element["product"], key: "image"),
                hasStock:
                    parseToBool(response: element["product"], key: "in_stock"),
                variationId: parseToInt(response: element, key: "id"),
                selectedCount: parseToInt(response: element, key: "quantity"),
              );

              productData.add(productCartData);
            });

            for (var element in productData) {
              await moorDatabase.insertProductCart(productCartData: element);
            }
            return SimpleResponseModel.success();
          } else {
            return getSimpleResponseErrorHandler(responseGet);
          }
        } else {
          return getSimpleResponseErrorHandler(responseGet);
        }
      }

      /// refresh else qismi
      else {
        final body = {"products": products};
        // final response =
        //     await orderNetworkService.refreshPostMethodUrl(body: body);

        final response = await orderNetworkService.refreshGetMethodUrl();
        if (response.status == true && response.response != null) {
          if (response.response?.data.containsKey("data")) {
            List<ProductCartData> productData = [];
            response.response?.data["data"].forEach((element) {
              final productCartData = ProductCartData(
                restaurantId: parseToInt(
                    response: element["product"], key: "restaurant_id"),
                price: parseToInt(response: element, key: "price"),
                count: parseToInt(response: element, key: "quantity"),
                productId: parseToInt(response: element["product"], key: "id"),
                name: parseToString(response: element["product"], key: "name"),
                image:
                    parseToString(response: element["product"], key: "image"),
                hasStock:
                    parseToBool(response: element["product"], key: "in_stock"),
                variationId: parseToInt(response: element, key: "id"),
                selectedCount: parseToInt(response: element, key: "quantity"),
              );

              productData.add(productCartData);
            });

            for (var element in productData) {
              await moorDatabase.insertProductCart(productCartData: element);
            }

            print(
                "lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll ${response.response?.data}");
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
 */
