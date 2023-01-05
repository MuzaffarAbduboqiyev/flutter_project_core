import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/location_controller/location_event.dart';
import 'package:delivery_service/controller/location_controller/location_repository.dart';
import 'package:delivery_service/controller/location_controller/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repository;
  late StreamSubscription locationRepository;

  LocationBloc(
    super.initialState, {
    required this.repository,
  }) {
    // init = boshlang'ich
    on<LocationInitialEvent>(
      _init,
      transformer: concurrent(),
    );
    // getInfo = Ma'lumot olish

    on<LocationGetInfoEvent>(
      _getInfo,
      transformer: restartable(),
    );
    // save = Saqlash
    on<LocationSaveEvent>(
      _save,
      transformer: sequential(),
    );

    on<LocationListenEvent>(
      _listen,
      transformer: sequential(),
    );

    on<LocationDeleteEvent>(
      _deleteLocation,
      transformer: concurrent(),
    );

    on<LocationClearEvent>(
      _clearLocation,
      transformer: concurrent(),
    );
  }

  FutureOr<void> _init(
      LocationInitialEvent event, Emitter<LocationState> emit) {
    emit(
      state.copyWith(
        locationStatus: event.locationStatus,
        locationData: event.locationData,
        error: event.error,
      ),
    );
  }

  FutureOr<void> _getInfo(
      LocationGetInfoEvent event, Emitter<LocationState> emit) async {
    emit(
      state.copyWith(
        locationStatus: LocationStatus.loading,
      ),
    );

    final response = await repository.getLocationInfo(
      lat: event.lat,
      lng: event.lng,
    );

    emit(
      state.copyWith(
        locationStatus: LocationStatus.loaded,
        locationData: response.data,
      ),
    );
  }

  FutureOr<void> _save(
      LocationSaveEvent event, Emitter<LocationState> emit) async {
    emit(
      state.copyWith(
        locationStatus: LocationStatus.loading,
      ),
    );

    await repository.insertOrUpdateLocation(
      locationData: state.locationData,
    );

    emit(
      state.copyWith(
        locationStatus: LocationStatus.closed,
      ),
    );
  }

  FutureOr<void> _listen(
      LocationListenEvent event, Emitter<LocationState> emit) {}

  FutureOr<void> _deleteLocation(
      LocationDeleteEvent event, Emitter<LocationState> emit) async {
    final response =
        await repository.deleteLocation(locationData: event.locationData);
  }

  FutureOr<void> _clearLocation(
      LocationClearEvent event, Emitter<LocationState> emit) async {
    await repository.clearLocations();
  }
}
