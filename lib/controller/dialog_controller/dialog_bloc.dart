import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_event.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_repository.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  final DialogRepository dialogRepository;
  late StreamSubscription streamSubscription;

  DialogBloc(
    super.initialState, {
    required this.dialogRepository,
  }) {
    /// listen location
    on<DialogListenLocationEvent>(
      _listenLocation,
      transformer: concurrent(),
    );

    /// selected location
    on<DialogLocationSelectedEvent>(
      _changeLocationSelectedStatus,
      transformer: concurrent(),
    );

    /// delete location
    on<DialogLocationDeleteEvent>(
      _deleteLocation,
      transformer: concurrent(),
    );

    /// listen token
    on<DialogListenTokenEvent>(
      _listenToken,
      transformer: concurrent(),
    );

    /// listen token
    on<DialogGetTokenEvent>(
      _getToken,
      transformer: concurrent(),
    );

    streamSubscription = dialogRepository.listenLocation().listen((location) {
      final l = location;
      l.sort((a, b) => a.lat.compareTo(b.lat));
      add(DialogListenLocationEvent(locationData: l));
    });
    streamSubscription = dialogRepository.listenToken().listen((event) {
      add(
        DialogListenTokenEvent(token: event.value),
      );
    });
  }

  /// listen location
  FutureOr<void> _listenLocation(
      DialogListenLocationEvent event, Emitter<DialogState> emit) async {
    emit(
      state.copyWith(
        location: event.locationData,
      ),
    );
  }

  /// listen token
  FutureOr<void> _listenToken(
      DialogListenTokenEvent event, Emitter<DialogState> emit) async {
    emit(
      state.copyWith(
        token: event.token,
      ),
    );
  }

  /// get token
  FutureOr<void> _getToken(
      DialogGetTokenEvent event, Emitter<DialogState> emit) async {
    final response = await dialogRepository.getTokenInfo();
    emit(
      state.copyWith(
        token: response,
      ),
    );
  }

  FutureOr<void> _changeLocationSelectedStatus(
      DialogLocationSelectedEvent event, Emitter<DialogState> emit) async {
    emit(
      state.copyWith(
        dialogStatus: DialogStatus.loading,
      ),
    );
    final response = await dialogRepository.changeSelectedLocation(
        locationData: event.locationData);

    emit(
      state.copyWith(
        dialogStatus:
            (response.status) ? DialogStatus.loaded : DialogStatus.error,
        error: response.message,
      ),
    );
  }

  /// delete location
  FutureOr<void> _deleteLocation(
      DialogLocationDeleteEvent event, Emitter<DialogState> emit) async {
    await dialogRepository.deleteLocation(
      locationData: event.locationData,
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
