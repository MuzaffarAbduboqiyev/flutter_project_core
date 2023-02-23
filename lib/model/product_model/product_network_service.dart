import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';
import 'package:flutter/material.dart';

abstract class ProductNetworkService {
  Future<NetworkResponseModel> getRestaurantProducts({
    required int restaurantId,
    required int categoryId,
    required String searchName,
  });

  Future<NetworkResponseModel> getProductDetail({
    required int productId,
    required String productImage,
  });

  Future<NetworkResponseModel> checkInfo({
    required Map<dynamic, dynamic> body,
  });

  Future<NetworkResponseModel> deleteCart({
    required int variationId,
  });
}

class ProductNetworkServiceImpl extends ProductNetworkService {
  final NetworkService networkService;

  ProductNetworkServiceImpl({required this.networkService});

  @override
  Future<NetworkResponseModel> getRestaurantProducts({
    required int restaurantId,
    required int categoryId,
    required String searchName,
  }) async {
    String url = "$productUrl?restaurant=$restaurantId";
    if (categoryId != -1) {
      url += "&category=$categoryId";
    }

    if (searchName.isNotEmpty) {
      url += "name=$searchName";
    }
    final response = await networkService.getMethod(url: url);
    return response;
  }

  @override
  Future<NetworkResponseModel> getProductDetail(
      {required int productId, required String productImage}) async {
    final response =
        await networkService.getMethod(url: "$productUrl/$productId");
    return response;
  }

  @override
  Future<NetworkResponseModel> checkInfo(
      {required Map<dynamic, dynamic> body}) async {
    final response = await networkService.postMethod(url: cartUrl, body: body);
    return response;
  }

  /// delete product
  @override
  Future<NetworkResponseModel> deleteCart({required int variationId}) async {
    final response =
        await networkService.deleteMethod(url: "$deleteCartUrl/$variationId");

    return response;
  }
}
