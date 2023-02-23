import 'package:delivery_service/controller/product_controller/product_repository.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';

import '../../model/response_model/network_response_model.dart';

abstract class OrderRepository {
  Stream<List<ProductCartData>> listenCartProducts();

  Future<List<ProductCartData>> getCartProducts();

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
}

class OrderRepositoryImpl extends OrderRepository {
  final ProductRepository productRepository;
  final MoorDatabase moorDatabase;

  OrderRepositoryImpl({
    required this.productRepository,
    required this.moorDatabase,
  });

  /// product listen
  @override
  Stream<List<ProductCartData>> listenCartProducts() =>
      moorDatabase.listenCartProducts();

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
}
