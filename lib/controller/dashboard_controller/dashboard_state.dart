import 'package:delivery_service/model/local_database/moor_database.dart';

enum DashboardStatus {
  init,
  loading,
  loaded,
  error,
}

class DashboardState {
  final DashboardStatus dashboardStatus;
  final List<ProductCartData> productCartData;
  final String error;

  DashboardState({
    required this.dashboardStatus,
    required this.productCartData,
    required this.error,
  });

  factory DashboardState.initial() => DashboardState(
        dashboardStatus: DashboardStatus.init,
        productCartData: [],
        error: "",
      );

  DashboardState copyWith({
    DashboardStatus? dashboardStatus,
    List<ProductCartData>? productCartData,
    String? error,
  }) =>
      DashboardState(
        dashboardStatus: dashboardStatus ?? this.dashboardStatus,
        productCartData: productCartData ?? this.productCartData,
        error: error ?? this.error,
      );
}
