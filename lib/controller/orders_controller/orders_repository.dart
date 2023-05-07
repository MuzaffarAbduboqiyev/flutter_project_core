import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/orders_model/orders_model.dart';
import 'package:delivery_service/model/orders_model/orders_network_service.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:hive/hive.dart';

abstract class OrdersRepository {
  Future<DataResponseModel<List<OrdersModel>>> getOrders();

  Stream<BoxEvent> listenToken();

  Future<bool> getToken();
}

class OrdersRepositoryImpl extends OrdersRepository {
  final OrdersNetworkService ordersNetworkService;
  final HiveDatabase hiveDatabase;

  OrdersRepositoryImpl({
    required this.ordersNetworkService,
    required this.hiveDatabase,
  });

  @override
  Future<DataResponseModel<List<OrdersModel>>> getOrders() async {
    try {
      final response = await ordersNetworkService.getOrdersUrl();

      if (response.status && response.response != null) {
        if (response.response?.data.containsKey("data") == true) {
          final List<OrdersModel> ordersModel =
              parseOrdersModel(response.response?.data["data"]);

          return DataResponseModel.success(model: ordersModel);
        } else {
          return getDataResponseErrorHandler<List<OrdersModel>>(response);
        }
      } else {
        return getDataResponseErrorHandler<List<OrdersModel>>(response);
      }
    } catch (error) {
      return DataResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Stream<BoxEvent> listenToken() => hiveDatabase.listenToken();

  @override
  Future<bool> getToken() async {
    final response = await hiveDatabase.getToken();
    return response.isNotEmpty;
  }
}
