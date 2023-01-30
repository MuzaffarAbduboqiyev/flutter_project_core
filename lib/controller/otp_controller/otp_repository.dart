import 'package:delivery_service/controller/welcome_controller/welcome_repository.dart';
import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/otp_model/otp_model.dart';
import 'package:delivery_service/model/otp_model/otp_network_service.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';

abstract class OtpRepository {
  Future<SimpleResponseModel> getPhoneCode({
    required String phoneNumber,
    required String phoneCode,
  });

  Future<SimpleResponseModel> getPhoneNumberResend({
    required String phoneNumber,
  });

  Future<bool> userDataStorage({
    required OtpModel otpModel,
  });
}

class OtpRepositoryImpl extends OtpRepository {
  final OtpNetworkService otpNetworkService;
  final WelcomeRepository welcomeRepository;
  final HiveDatabase hiveDatabase;

  OtpRepositoryImpl({
    required this.otpNetworkService,
    required this.welcomeRepository,
    required this.hiveDatabase,
  });

  @override
  Future<SimpleResponseModel> getPhoneCode(
      {required String phoneNumber, required String phoneCode}) async {
    try {
      final body = {
        "phone_number": "998$phoneNumber",
        "code": phoneCode,
      };
      final response = await otpNetworkService.getPhoneCode(body: body);

      if (response.response != null && response.status == true) {
        if (response.response?.data.containsKey("data") == true) {
          final sendRequest = OtpModel.formMap(response.response?.data["data"]);
          await userDataStorage(otpModel: sendRequest);
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

  @override
  Future<bool> userDataStorage({required OtpModel otpModel}) async {
    try {
      await hiveDatabase.setToken(otpModel.token);
      await hiveDatabase.setName(otpModel.name);
      await hiveDatabase.setPhone(otpModel.phone_number);
      return true;
    } catch (error) {
      return true;
    }
  }

  @override
  Future<SimpleResponseModel> getPhoneNumberResend(
      {required String phoneNumber}) async {
    final response =
        await welcomeRepository.getPhoneNumber(phoneNumber: phoneNumber);
    return response;
  }
}
