import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:hive/hive.dart';

abstract class HomeRepository {
  /// listen token
  Stream<BoxEvent> listenToken();

  /// get token
  Future<bool> getTokenInfo();

  /// listen userName
  Stream<BoxEvent> listenUserName();

  /// get userName
  Future<String> getUserName();

  /// listen userSurname
  Stream<BoxEvent> listenUserSurname();

  /// get userSurname
  Future<String> getUserSurname();
}

class HomeRepositoryImpl extends HomeRepository {
  final HiveDatabase hiveDatabase;

  HomeRepositoryImpl({required this.hiveDatabase});

  /// listen token
  @override
  Stream<BoxEvent> listenToken() => hiveDatabase.listenToken();

  /// get token
  @override
  Future<bool> getTokenInfo() async {
    final response = await hiveDatabase.getToken();
    return response.isNotEmpty;
  }

  /// listen userName
  @override
  Stream<BoxEvent> listenUserName() => hiveDatabase.listenName();

  /// get userName
  @override
  Future<String> getUserName() async {
    final response = await hiveDatabase.getName();
    return response;
  }

  /// listen userSurname
  @override
  Stream<BoxEvent> listenUserSurname() => hiveDatabase.listenSurname();

  /// get userSurname
  @override
  Future<String> getUserSurname() async {
    final response = await hiveDatabase.getSurname();
    return response;
  }
}
