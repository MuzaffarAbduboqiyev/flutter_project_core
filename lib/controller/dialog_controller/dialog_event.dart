import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class DialogEvent {}

/// location listen
class DialogListenLocationEvent extends DialogEvent {
  final List<LocationData> locationData;

  DialogListenLocationEvent({required this.locationData});
}

/// location selected
class DialogLocationSelectedEvent extends DialogEvent {
  final LocationData locationData;

  DialogLocationSelectedEvent({required this.locationData});
}

/// location delete
class DialogLocationDeleteEvent extends DialogEvent {
  final LocationData locationData;

  DialogLocationDeleteEvent({required this.locationData});
}

/// listen token
class DialogListenTokenEvent extends DialogEvent {
  final bool token;

  DialogListenTokenEvent({required this.token});
}

/// get token
class DialogGetTokenEvent extends DialogEvent {}
