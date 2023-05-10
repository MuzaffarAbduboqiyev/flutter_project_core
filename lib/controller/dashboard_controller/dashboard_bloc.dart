import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/dashboard_controller/dashboard_event.dart';
import 'package:delivery_service/controller/dashboard_controller/dashboard_repository.dart';
import 'package:delivery_service/controller/dashboard_controller/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository;
  late StreamSubscription streamSubscription;

  DashboardBloc(super.initialState, {required this.dashboardRepository}) {
    on<DashboardListenProductEvent>(
      _listenProducts,
      transformer: concurrent(),
    );

    streamSubscription =
        dashboardRepository.listenCartProducts().listen((event) {
      add(DashboardListenProductEvent(productCartData: event));
    });
  }

  /// listen productCart
  FutureOr<void> _listenProducts(
      DashboardListenProductEvent event, Emitter<DashboardState> emit) async {
    emit(
      state.copyWith(
        productCartData: event.productCartData,
      ),
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
