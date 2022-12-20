import 'package:delivery_service/model/local_database/moor_database.dart';

enum LocationStatus {
  init, // boshlang'ich,
  loading, // yuklash
  loaded, // yuklangan
  closed, // yopiq
  error,
}

class LocationState {
  final LocationStatus locationStatus;
  final LocationData locationData;
  final String error;

  LocationState({
    required this.locationStatus,
    required this.locationData,
    required this.error,
  });

  factory LocationState.initial() => LocationState(
        locationStatus: LocationStatus.init,
        locationData: LocationData(
          lat: 0,
          lng: 0,
          selectedStatus: false,
          name: "",
        ),
        error: "",
      );

  LocationState copyWith({
    LocationStatus? locationStatus,
    LocationData? locationData,
    String? error,
  }) =>
      LocationState(
        locationStatus: locationStatus ?? this.locationStatus,
        locationData: locationData ?? this.locationData,
        error: error ?? this.error,
      );
}
