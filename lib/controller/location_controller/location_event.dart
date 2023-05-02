import 'package:delivery_service/controller/location_controller/location_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class LocationEvent {}

/// init location
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

/// get location
class LocationGetInfoEvent extends LocationEvent {
  final String lat;
  final String lng;

  LocationGetInfoEvent({
    required this.lat,
    required this.lng,
  });
}

/// save location
class LocationSaveEvent extends LocationEvent {}

/// listen location
class LocationListenEvent extends LocationEvent {
  final LocationData locationData;

  LocationListenEvent({required this.locationData});
}



/// delete location
class LocationDeleteEvent extends LocationEvent {
  final LocationData locationData;

  LocationDeleteEvent({required this.locationData});
}
