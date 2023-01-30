import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_event.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_repository.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';

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

    /// delete location
    on<DialogClearLocationEvent>(
      _clearLocation,
      transformer: concurrent(),
    );

    streamSubscription = dialogRepository.listenLocation().listen((location) {
      final selectedLocation = location.firstWhere(
        (element) => element.selectedStatus,
        orElse: () => LocationData(
          lat: 0.0,
          lng: 0.0,
          selectedStatus: false,
        ),
      );
      final l = location;
      l.sort((a, b) => a.lat.compareTo(b.lat));
      add(DialogListenLocationEvent(locations: l));
    });
  }

  FutureOr<void> _listenLocation(
      DialogListenLocationEvent event, Emitter<DialogState> emit) async {
    emit(
      state.copyWith(
        location: event.locations,
      ),
    );
  }

  FutureOr<void> _changeLocationSelectedStatus(
      DialogLocationSelectedEvent event, Emitter<DialogState> emit) async {
    await dialogRepository.changeSelectedLocation(
        locationData: event.locationData);
  }

  FutureOr<void> _deleteLocation(
      DialogLocationDeleteEvent event, Emitter<DialogState> emit) async {
    await dialogRepository.deleteLocation(
      deleteLocationData: event.locationData,
    );
  }

  FutureOr<void> _clearLocation(
      DialogClearLocationEvent event, Emitter<DialogState> emit) async {
    await dialogRepository.clearLocation();
  }
}
