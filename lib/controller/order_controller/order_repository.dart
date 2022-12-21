import 'package:delivery_service/model/local_database/moor_database.dart';

import '../../model/response_model/network_response_model.dart';

abstract class OrderRepository {
  Stream<List<ProductCartData>> listenCartProducts();

  Stream<List<LocationData>> listenLocations();

  Future<List<ProductCartData>> getCartProducts();

  Future<SimpleResponseModel> updateCart({
    required ProductCartData cartData,
  });

  Future<SimpleResponseModel> deleteCart({
    required ProductCartData deleteCartData,
  });

  Future<bool> clearOrderHistory();
}

class OrderRepositoryImpl extends OrderRepository {
  final MoorDatabase moorDatabase;

  OrderRepositoryImpl({
    required this.moorDatabase,
  });

  /// porduct listen
  @override
  Stream<List<ProductCartData>> listenCartProducts() =>
      moorDatabase.listenCartProducts();

  /// location listen
  @override
  Stream<List<LocationData>> listenLocations() =>
      moorDatabase.listenLocations();

  @override
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
  Future<SimpleResponseModel> deleteCart(
      {required ProductCartData deleteCartData}) async {
    await moorDatabase.deleteProductVariation(
      productId: deleteCartData.productId,
      variationId: deleteCartData.variationId,
    );
    return SimpleResponseModel.success();
  }

  @override
  Future<bool> clearOrderHistory() async {
    await moorDatabase.clearOrderHistory();
    return true;
  }
}
