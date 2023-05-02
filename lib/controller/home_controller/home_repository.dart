import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:hive/hive.dart';

abstract class HomeRepository {
  /// listen token
  Stream<BoxEvent> listenToken();

  /// get token
  Future<bool> getTokenInfo();
}

class HomeRepositoryImpl extends HomeRepository {
  final HiveDatabase hiveDatabase;

  HomeRepositoryImpl({required this.hiveDatabase});

  @override
  Stream<BoxEvent> listenToken() => hiveDatabase.listenToken();

  @override
  Future<bool> getTokenInfo() async {
    final response = await hiveDatabase.getToken();
    return response.isNotEmpty;
  }
}
