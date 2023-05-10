import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class DashboardEvent {}

/// listen product
class DashboardListenProductEvent extends DashboardEvent {
  final List<ProductCartData> productCartData;

  DashboardListenProductEvent({required this.productCartData});
}
