import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class ProfileNetworkService {
  Future<NetworkResponseModel> getUserData();
}

class ProfileNetworkServiceImpl extends ProfileNetworkService {
  final NetworkService networkService;

  ProfileNetworkServiceImpl({required this.networkService});

  @override
  Future<NetworkResponseModel> getUserData() async {
    final response = await networkService.getMethod(url: userUrl);
    return response;
  }
}
