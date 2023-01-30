import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class DialogEvent {}

/// location listen
class DialogListenLocationEvent extends DialogEvent {
  final List<LocationData> locations;

  DialogListenLocationEvent({required this.locations});
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

class DialogClearLocationEvent extends DialogEvent{}
