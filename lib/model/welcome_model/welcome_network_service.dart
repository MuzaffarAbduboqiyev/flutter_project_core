import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class WelcomeNetworkService {
  Future<NetworkResponseModel> getPhoneNumber({required Map body});
}

class WelcomeNetworkServiceImpl extends WelcomeNetworkService {
  final NetworkService networkService;

  WelcomeNetworkServiceImpl({required this.networkService});

  @override
  Future<NetworkResponseModel> getPhoneNumber({required Map body}) async {
    final response =
        await networkService.postMethod(url: requestCodeUrl, body: body);
    return response;
  }
}
