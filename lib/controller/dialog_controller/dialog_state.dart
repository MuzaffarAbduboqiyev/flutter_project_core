import 'package:delivery_service/model/local_database/moor_database.dart';

enum DialogStatus {
  init,
  loading,
  loaded,
  success,
  error,
}

class DialogState {
  final DialogStatus dialogStatus;
  final List<LocationData> location;
  final bool token;
  final String error;

  DialogState({
    required this.dialogStatus,
    required this.location,
    required this.token,
    required this.error,
  });

  factory DialogState.initial() => DialogState(
        dialogStatus: DialogStatus.init,
        location: [],
        token: false,
        error: "",
      );

  DialogState copyWith({
    DialogStatus? dialogStatus,
    List<LocationData>? location,
    bool? token,
    String? error,
  }) =>
      DialogState(
        dialogStatus: dialogStatus ?? this.dialogStatus,
        location: location ?? this.location,
        token: token ?? this.token,
        error: error ?? this.error,
      );
}
