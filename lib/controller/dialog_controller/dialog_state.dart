import 'package:delivery_service/model/local_database/moor_database.dart';

class DialogState {
  final List<LocationData> location;

  DialogState({
    required this.location,
  });

  factory DialogState.initial() => DialogState(
        location: [],
      );

  DialogState copyWith({
    List<LocationData>? location,
  }) =>
      DialogState(
        location: location ?? this.location,
      );
}
