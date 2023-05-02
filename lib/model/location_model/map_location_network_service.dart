import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:delivery_service/util/service/network/urls.dart';

abstract class MapLocationNetworkService {
  Future<NetworkResponseModel> requestLocationUrl(
      {required Map<dynamic, dynamic> body});

  Future<NetworkResponseModel> deleteLocationUrl({
    required int locationId,
  });
}

class MapLocationNetworkServiceImpl extends MapLocationNetworkService {
  final NetworkService networkService;

  MapLocationNetworkServiceImpl({required this.networkService});

  @override
  Future<NetworkResponseModel> requestLocationUrl(
      {required Map<dynamic, dynamic> body}) async {
    final response =
        await networkService.postMethod(url: addressesUrl, body: body);
    return response;
  }

  @override
  Future<NetworkResponseModel> deleteLocationUrl(
      {required int locationId}) async {
    final response = await networkService.deleteMethod(
        url: "$deleteAddressesUrl/$locationId");
    return response;
  }
}
