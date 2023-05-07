import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/location_controller/location_event.dart';
import 'package:delivery_service/controller/location_controller/location_repository.dart';
import 'package:delivery_service/controller/location_controller/location_state.dart';
import 'package:delivery_service/ui/widgets/loading/loader_dialog.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;

  LocationBloc(
    super.initialState, {
    required this.locationRepository,
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
      _listenLocation,
      transformer: sequential(),
    );

    on<LocationDeleteEvent>(
      _deleteLocation,
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
    List<String> region = [
      "Chartak District",
      "Chust District",
      "Kasansay District",
      "Mingbulak District",
      "Namangan District",
      "Yangi Namangan District",
      "Naryn District",
      "Pap District",
      "Turakurgan District",
      "Uchkurgan District",
      "Uychi District",
      "Yangikurgan District",
      ///////////////////////////
      "Chartak Region",
      "Chust Region",
      "Kasansay Region",
      "Mingbulak Region",
      "Namangan Region",
      "Yangi Namangan Region",
      "Naryn Region",
      "Pap Region",
      "Turakurgan Region",
      "Uchkurgan Region",
      "Uychi Region",
      "Yangikurgan Region",
      "Namangan Region",
      "Namangan",
      ////////////////////////////
      "Chartak",
      "Chust",
      "Kasansay",
      "Mingbulak",
      "Namangan",
      "Yangi Namangan",
      "Naryn",
      "Pap",
      "Turakurgan",
      "Uchkurgan",
      "Uychi",
      "Karoskon",
      "Yangikurgan",
    ];

    final response = await locationRepository.getLocationInfo(
      lat: event.lat,
      lng: event.lng,
    );

    bool hasLocation = false;
    for (var element in region) {
      if (response.data?.address.contains(element) == true) {
        hasLocation = true;
      }
    }

    if (hasLocation) {
      emit(
        state.copyWith(
          locationStatus: LocationStatus.loaded,
          locationData: response.data,
        ),
      );
    } else {
      showErrorDialog(
        errorMessage: translate("location.error"),
      );
    }
  }

  FutureOr<void> _save(
      LocationSaveEvent event, Emitter<LocationState> emit) async {
    emit(
      state.copyWith(
        locationStatus: LocationStatus.loading,
      ),
    );

    locationRepository.insertOrUpdateLocation(
      locationData: state.locationData,
    );

    emit(
      state.copyWith(
        locationStatus: LocationStatus.closed,
      ),
    );
  }

  FutureOr<void> _listenLocation(
      LocationListenEvent event, Emitter<LocationState> emit) {
    emit(
      state.copyWith(
        locationData: event.locationData,
      ),
    );
  }

  FutureOr<void> _deleteLocation(
      LocationDeleteEvent event, Emitter<LocationState> emit) async {
    await locationRepository.deleteLocations(
      locationData: event.locationData,
    );
  }
}
