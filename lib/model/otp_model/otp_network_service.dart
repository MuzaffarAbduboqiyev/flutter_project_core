import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class OtpNetworkService {
  Future<NetworkResponseModel> getPhoneCode({required Map body});
}

  class OtpNetworkServiceImpl extends OtpNetworkService {
  final NetworkService networkService;

  OtpNetworkServiceImpl({required this.networkService});

  @override
  Future<NetworkResponseModel> getPhoneCode({required Map body}) async {
    final response =
        await networkService.postMethod(url: verifyNumberUrl, body: body);
    return response;
  }
}
