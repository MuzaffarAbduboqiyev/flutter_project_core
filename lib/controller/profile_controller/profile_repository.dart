import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/profile_model/profile_model.dart';
import 'package:delivery_service/model/profile_model/profile_network_service.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';

abstract class ProfileRepository {
  Future<DataResponseModel<ProfileModel>> getAllUserData();

  Future<String> setUserName({required String userName});

  Future<String> setUserSurname({required String userSurname});

}

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileNetworkService profileNetworkService;
  final HiveDatabase hiveDatabase;

  ProfileRepositoryImpl({
    required this.profileNetworkService,
    required this.hiveDatabase,
  });

  @override
  Future<DataResponseModel<ProfileModel>> getAllUserData() async {
    try {
      final response = await profileNetworkService.getUserData();
      if (response.status &&
          response.response != null &&
          response.response?.data.containsKey("data")) {
        final profileUser =
            ProfileModel.fromMap(response.response?.data["data"]);
        return DataResponseModel.success(model: profileUser);
      } else {
        return getDataResponseErrorHandler<ProfileModel>(response);
      }
    } catch (error) {
      return DataResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Future<String> setUserName({required String userName}) async {
    final response = await hiveDatabase.setName(userName);
    print("ProfileRepository profileRepository userName: $userName");
    return response.toString();
  }

  @override
  Future<String> setUserSurname({required String userSurname}) async {
    final response = await hiveDatabase.setSurname(userSurname);
    print("ProfileRepository profileRepository userName: $userSurname");
    return response.toString();
  }
}
