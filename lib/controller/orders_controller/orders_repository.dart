import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';

abstract class OrdersRepository {
  Future<SimpleResponseModel> get();

  Future<SimpleResponseModel> delete();
}

class OrdersRepositoryImpl extends OrdersRepository {
  final MoorDatabase moorDatabase;

  OrdersRepositoryImpl({
    required this.moorDatabase,
  });

  @override
  Future<SimpleResponseModel> get() async {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<SimpleResponseModel> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
