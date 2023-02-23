import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/model/welcome_model/welcome_network_service.dart';

abstract class WelcomeRepository {
  Future<SimpleResponseModel> getPhoneNumber({
    required String phoneNumber,
  });
}

class WelcomeRepositoryImpl extends WelcomeRepository {
  final WelcomeNetworkService welcomeNetworkService;

  WelcomeRepositoryImpl({required this.welcomeNetworkService});

  @override
  Future<SimpleResponseModel> getPhoneNumber(
      {required String phoneNumber}) async {
    try {
      final body = {
        "phone_number": "998$phoneNumber",
      };
      final response = await welcomeNetworkService.getPhoneNumber(body: body);

      if (response.status == true && response.response != null) {
        if (response.response?.data.containsKey("data")) {
          return SimpleResponseModel.success();
        } else {
          return getSimpleResponseErrorHandler(response);
        }
      } else {
        return getSimpleResponseErrorHandler(response);
      }
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }
}
