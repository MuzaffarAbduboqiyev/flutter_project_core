import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class DashboardRepository {
  /// listen productCart
  Stream<List<ProductCartData>> listenCartProducts();
}

class DashboardRepositoryImpl extends DashboardRepository {
  final MoorDatabase moorDatabase;
  final HiveDatabase hiveDatabase;

  DashboardRepositoryImpl({
    required this.moorDatabase,
    required this.hiveDatabase,
  });

  @override
  Stream<List<ProductCartData>> listenCartProducts() =>
      moorDatabase.listenCartProducts();
}
