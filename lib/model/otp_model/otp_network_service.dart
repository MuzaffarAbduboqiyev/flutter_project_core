import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class OtpNetworkService {
  Future<NetworkResponseModel> getPhoneCode({required Map body});

  Future<NetworkResponseModel> getLocations();

  Future<NetworkResponseModel> getProductsUrl();

  Future<NetworkResponseModel> clearProductsUrl({required Map body});
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

  @override
  Future<NetworkResponseModel> getLocations() async {
    final response = await networkService.getMethod(url: addressesUrl);
    return response;
  }

  @override
  Future<NetworkResponseModel> getProductsUrl() async {
    final response = await networkService.getMethod(url: cartUrl);
    return response;
  }

  @override
  Future<NetworkResponseModel> clearProductsUrl({required Map body}) async {
    final response = await networkService.postMethod(url: clearUrl, body: body);
    return response;
  }
}
