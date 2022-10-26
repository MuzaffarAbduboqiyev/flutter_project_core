import 'package:delivery_service/model/local_database/hive_database.dart';

abstract class AppRepository {
  Future<bool> getDarkThemeState();

  Future<bool> changeThemeMode();
}

class AppRepositoryImpl extends AppRepository {
  final HiveDatabase hiveDatabase;

  AppRepositoryImpl({required this.hiveDatabase});

  @override
  Future<bool> getDarkThemeState() async {
    final bool isDarkMode = await hiveDatabase.getThemeMode();
    return isDarkMode;
  }

  @override
  Future<bool> changeThemeMode() async {
    final bool isDarkMode = await hiveDatabase.changeThemeMode();
    return isDarkMode;
  }
}
