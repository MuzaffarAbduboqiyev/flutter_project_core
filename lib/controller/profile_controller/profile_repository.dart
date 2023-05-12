import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/profile_model/profile_network_service.dart';
import 'package:hive/hive.dart';

abstract class ProfileRepository {
  /// set userName
  Future<String> setUserName({required String userName});

  /// listen userName
  Stream<BoxEvent> listenUserName();

  /// get userName
  Future<String> getUserName();

  /// set userSurname
  Future<String> setUserSurname({required String userSurname});

  /// listen userSurname
  Stream<BoxEvent> listenUserSurname();

  /// get userSurname
  Future<String> getUserSurname();

  /// listen phoneNumber
  Stream<BoxEvent> listenPhoneNumber();

  /// get phoneNumber
  Future<String> getPhoneNumber();
}

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileNetworkService profileNetworkService;
  final HiveDatabase hiveDatabase;

  ProfileRepositoryImpl({
    required this.profileNetworkService,
    required this.hiveDatabase,
  });

  @override
  Future<String> setUserName({required String userName}) async {
    final response = await hiveDatabase.setName(userName);
    return response.toString();
  }

  @override
  Future<String> setUserSurname({required String userSurname}) async {
    final response = await hiveDatabase.setSurname(userSurname);
    return response.toString();
  }

  @override
  Stream<BoxEvent> listenUserName() => hiveDatabase.listenName();

  @override
  Stream<BoxEvent> listenUserSurname() => hiveDatabase.listenSurname();

  @override
  Future<String> getUserName() async {
    final response = await hiveDatabase.getName();
    return response;
  }

  @override
  Future<String> getUserSurname() async {
    final response = await hiveDatabase.getSurname();
    return response;
  }

  @override
  Future<String> getPhoneNumber() async {
    final response = await hiveDatabase.getPhone();
    return response;
  }

  @override
  Stream<BoxEvent> listenPhoneNumber() => hiveDatabase.listenPhone();
}
