import 'package:delivery_service/model/local_database/hive_database.dart';

import 'package:hive/hive.dart';

abstract class AccountRepository {
  /// get token info
  Future<bool> getTokenInfo();

  /// listen token
  Stream<BoxEvent> listenToken();

  /// delete token
  Future<bool> deleteToken({required String token});

  /// get userName
  Future<String> getUserName();

  /// listen Name
  Stream<BoxEvent> listenName();

  /// delete name
  Future<String> deleteName({required String userName});

  /// get userSurname
  Future<String> getUserSurname();

  /// listen Surname
  Stream<BoxEvent> listenSurname();

  /// delete surname
  Future<String> deleteSurname({required String userSurname});
}

class AccountRepositoryImpl extends AccountRepository {
  final HiveDatabase hiveDatabase;

  AccountRepositoryImpl({
    required this.hiveDatabase,
  });

  @override
  Future<bool> getTokenInfo() async {
    final response = await hiveDatabase.getToken();

    return response.isNotEmpty;
  }

  @override
  Stream<BoxEvent> listenToken() => hiveDatabase.listenToken();

  @override
  Future<bool> deleteToken({required String token}) async {
    await hiveDatabase.setToken("");
    return false;
  }

  @override
  Future<String> getUserName() async {
    final response = await hiveDatabase.getName();
    return response;
  }

  /// listen userName
  @override
  Stream<BoxEvent> listenName() => hiveDatabase.listenName();

  /// delete userName
  @override
  Future<String> deleteName({required String userName}) async {
    final response = await hiveDatabase.setName("");
    return response.toString();
  }

  /// get userSurname
  @override
  Future<String> getUserSurname() async {
    final response = await hiveDatabase.getSurname();
    return response;
  }

  /// listen userSurname
  @override
  Stream<BoxEvent> listenSurname() => hiveDatabase.listenSurname();

  /// delete userSurname
  @override
  Future<String> deleteSurname({required String userSurname}) async {
    final response = await hiveDatabase.setSurname("");
    return response.toString();
  }
}
