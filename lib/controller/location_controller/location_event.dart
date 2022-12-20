import 'package:delivery_service/controller/location_controller/location_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class LocationEvent {}

class LocationInitialEvent extends LocationEvent {
  final LocationStatus? locationStatus;
  final LocationData? locationData;
  final String? error;

  LocationInitialEvent({
    required this.locationStatus,
    required this.locationData,
    required this.error,
  });
}

class LocationGetInfoEvent extends LocationEvent {
  final double lat;
  final double lng;

  LocationGetInfoEvent({
    required this.lat,
    required this.lng,
  });
}

class LocationSaveEvent extends LocationEvent {}

class LocationListenEvent extends LocationEvent {
  final LocationData locationData;

  LocationListenEvent({required this.locationData});
}
