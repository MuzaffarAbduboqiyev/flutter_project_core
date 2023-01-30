import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class  ProductNetworkService {
  Future<NetworkResponseModel> getRestaurantProducts({
    required int restaurantId,
    required int categoryId,
    required String searchName,
  });

  Future<NetworkResponseModel> getProductDetail({
    required int productId,
    required String productImage,
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
}
