import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class SearchNetworkService {
  Future<NetworkResponseModel> search({required String searchName});
}

class SearchNetworkServiceImpl extends SearchNetworkService {
  final NetworkService networkService;

  SearchNetworkServiceImpl({required this.networkService});

  @override
  Future<NetworkResponseModel> search({required String searchName}) async {
    final response =
        await networkService.getMethod(url: "$searchUrl?query=$searchName");
    return response;
  }
}
