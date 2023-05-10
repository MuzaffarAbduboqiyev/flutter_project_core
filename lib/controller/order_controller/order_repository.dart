import 'package:delivery_service/controller/product_controller/product_repository.dart';
import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/order_model/order_network_service.dart';
import 'package:delivery_service/model/payment_model/order_model.dart';
import 'package:delivery_service/model/product_model/product_cart.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
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
      final hasToken = await getTokenInfo();

      if (hasToken) {
        final localProducts = await moorDatabase.getCartProducts();
        final List<Map<String, int>> uploadProducts = [];

        if (localProducts.isNotEmpty) {
          for (var element in localProducts) {
            uploadProducts.add({
              "id": element.variationId,
              "quantity": element.selectedCount,
            });
          }
        }

        final responseGet = (uploadProducts.isEmpty)
            ? await orderNetworkService.refreshGetMethodUrl()
            : await orderNetworkService.uploadCartProducts(
                body: {
                  "products": uploadProducts,
                },
              );

        if (responseGet.status == true &&
            responseGet.response != null &&
            responseGet.response?.data.containsKey("data") == true &&
            responseGet.response?.data["data"] != null &&
            responseGet.response?.data["data"] is List) {
          await moorDatabase.insertAllProductCartData(
            productCartDataList:
                parseProductCartDataList(responseGet.response?.data["data"]),
          );

          return SimpleResponseModel.success();
        } else {
          return getSimpleResponseErrorHandler(responseGet);
        }
      } else {
        return SimpleResponseModel.success();
      }
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }
}

