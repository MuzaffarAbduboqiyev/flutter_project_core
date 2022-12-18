import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/location_controller/location_event.dart';
import 'package:delivery_service/controller/location_controller/location_repository.dart';
import 'package:delivery_service/controller/location_controller/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repository;

  LocationBloc(
    super.initialState, {
    required this.repository,
  }) {
    on<LocationInitialEvent>(
      _init,
      transformer: concurrent(),
    );

    on<LocationGetInfoEvent>(
      _getInfo,
      transformer: restartable(),
    );

    on<LocationSaveEvent>(
      _save,
      transformer: sequential(),
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
}
