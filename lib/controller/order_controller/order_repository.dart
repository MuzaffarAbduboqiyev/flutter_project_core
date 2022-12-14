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

  Future<SimpleResponseModel> changeSelectedLocation({
    required LocationData locationData,
  });

  Future<bool> clearOrderHistory();

  Future<bool> deleteLocationHistory();
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



  @override
  Future<bool> deleteLocationHistory() async {
    // await moorDatabase.deleteLocation(locationData: locationData);
    return true;
  }

  @override
  Future<SimpleResponseModel> changeSelectedLocation(
      {required LocationData locationData}) async {
    if (locationData.selectedStatus) {
      await moorDatabase.insertOrUpdateLocation(
        locationData: locationData.copyWith(
          selectedStatus: false,
        ),
      );
    } else {
      final selectedLocation = await moorDatabase.getSelectedLocation();
      if (selectedLocation != null) {
        await moorDatabase.insertOrUpdateLocation(
          locationData: selectedLocation.copyWith(
            selectedStatus: false,
          ),
        );
      }
      await moorDatabase.insertOrUpdateLocation(
        locationData: locationData.copyWith(
          selectedStatus: true,
        ),
      );
    }
    return SimpleResponseModel.success();
  }
}
