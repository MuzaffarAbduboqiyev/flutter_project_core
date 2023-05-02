import 'package:delivery_service/model/local_database/hive_database.dart';

import 'package:hive/hive.dart';

abstract class AccountRepository {
  Future<bool> getTokenInfo();

  Stream<BoxEvent> listenToken();

  Future<bool> deleteToken({required String token});
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
}
