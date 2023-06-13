import 'package:delivery_service/controller/product_controller/product_repository.dart';
import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/order_model/order_network_service.dart';
import 'package:delivery_service/model/order_model/payment_model.dart';
import 'package:delivery_service/model/payment_model/order_model.dart';
import 'package:delivery_service/model/product_model/product_cart.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class OrderRepository {
  /// listen product
  Stream<List<ProductCartData>> listenCartProducts();

  Future<SimpleResponseModel> updateCart({
    required ProductCartData cartData,
  });

  /// delete product
  Future<SimpleResponseModel> deleteCart({
    required ProductCartData deleteCartData,
    required int productId,
    required int variationId,
  });

  /// get order shipping
  Future<DataResponseModel<List<OrderShippingModel>>> getOrderShipping(
      {required int addressId});

  /// listen token
  Stream<BoxEvent> listenToken();

  /// get Token
  Future<bool> getTokenInfo();

  /// order refresh product
  Future<SimpleResponseModel> refreshProducts();

  /// fetch payment
  Future<DataResponseModel<List<PaymentModel>>> fetchPaymentModels({
    required int shippingId,
    required int locationId,
  });

  /// order payment
  Future<SimpleResponseModel> orderPayment({
    required int locationId,
    required int shippingId,
    required int paymentId,
  });
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
  Future<DataResponseModel<List<OrderShippingModel>>> getOrderShipping({
    required int addressId,
  }) async {
    try {
      final response =
          await orderNetworkService.getShippingUrl(addressId: addressId);
      if (response.status && response.response != null) {
        if (response.response?.data.containsKey("data") == true) {
          final List<OrderShippingModel> orderModel =
              parseShippingModel(response.response?.data["data"], addressId);
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
        final response = await orderNetworkService.refreshGetMethodUrl();

        if (response.status == true &&
            response.response != null &&
            response.response?.data.containsKey("data") == true &&
            response.response?.data["data"] != null &&
            response.response?.data["data"] is List) {
          await moorDatabase.insertAllProductCartData(
            productCartDataList:
                parseProductCartDataList(response.response?.data["data"]),
          );

          return SimpleResponseModel.success();
        } else {
          return getSimpleResponseErrorHandler(response);
        }
      } else {
        return SimpleResponseModel.success();
      }
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Future<DataResponseModel<List<PaymentModel>>> fetchPaymentModels({
    required int shippingId,
    required int locationId,
  }) async {
    try {
      final response = await orderNetworkService.fetchPaymentModels();
      if (response.status && response.response != null) {
        if (response.response?.data.containsKey("data") == true) {
          final List<PaymentModel> paymentModel = parsePaymentModel(
            response.response?.data["data"],
            locationId,
            shippingId,
          );
          return DataResponseModel.success(model: paymentModel);
        } else {
          return getDataResponseErrorHandler<List<PaymentModel>>(response);
        }
      } else {
        return getDataResponseErrorHandler<List<PaymentModel>>(response);
      }
    } catch (error) {
      return DataResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Future<SimpleResponseModel> orderPayment({
    required int locationId,
    required int shippingId,
    required int paymentId,
  }) async {
    try {
      final body = {
        "address_id": locationId,
        "shipping_method_id": shippingId,
        "payment_method_id": paymentId,
      };
      final response = await orderNetworkService.order(body: body);
      if (response.status && response.response != null) {
        if (response.response?.data.containsKey("invoice") == true) {
          final Uri uris = Uri.parse("${response.response?.data["invoice"]}");
          await _launchUrl("$uris");
          await moorDatabase.clearProductCart();
          return SimpleResponseModel.success();
        } else {
          return getSimpleResponseErrorHandler(response);
        }
      } else {
        return getSimpleResponseErrorHandler(response);
      }
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri urls = Uri.parse(url);

    if (!await launchUrl(
      urls,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }
}
