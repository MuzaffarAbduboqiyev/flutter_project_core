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
  List<LocationData> locations;
  final String error;

  LocationState({
    required this.locationStatus,
    required this.locationData,
    required this.locations,
    required this.error,
  });

  factory LocationState.initial() => LocationState(
        locationStatus: LocationStatus.init,
        locationData: LocationData(
          id: 0,
          lat: "",
          lng: "",
          address: "",
          comment: "",
          updated: "",
          created: "",
          defaults: false,
          selectedStatus: false,
        ),
        locations: [],
        error: "",
      );

  LocationState copyWith({
    LocationStatus? locationStatus,
    LocationData? locationData,
    List<LocationData>? locations,
    String? error,
  }) =>
      LocationState(
        locationStatus: locationStatus ?? this.locationStatus,
        locationData: locationData ?? this.locationData,
        locations: locations ?? this.locations,
        error: error ?? this.error,
      );
}
