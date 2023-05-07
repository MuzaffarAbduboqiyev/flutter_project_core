import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class DashboardRepository {
  /// listen productCart
  Stream<List<ProductCartData>> listenCartProducts();
}

class DashboardRepositoryImpl extends DashboardRepository {
  final MoorDatabase moorDatabase;

  DashboardRepositoryImpl({required this.moorDatabase});

  @override
  Stream<List<ProductCartData>> listenCartProducts() =>
      moorDatabase.listenCartProducts();
}
