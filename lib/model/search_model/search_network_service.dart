import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class SearchNetworkService {
  Future<NetworkResponseModel> searchCategoryUrl({required String searchName});

  /// search category requests
  Future<NetworkResponseModel> searchCategoryRequestsUrl({
    required String searchName,
    required int categoryId,
  });
}

class SearchNetworkServiceImpl extends SearchNetworkService {
  final NetworkService networkService;

  SearchNetworkServiceImpl({required this.networkService});

  @override
  Future<NetworkResponseModel> searchCategoryUrl(
      {required String searchName}) async {
    final response =
        await networkService.getMethod(url: "$searchUrl?query=$searchName");
    return response;
  }

  @override
  Future<NetworkResponseModel> searchCategoryRequestsUrl({
    required String searchName,
    required int categoryId,
  }) async {
    final response =
        await networkService.getMethod(url: "$searchUrl?query=$categoryId");
    print("SearchNetworkService CategoryId: $categoryId");
    print("SearchNetworkService SearchName: $searchName");
    return response;
  }
}
