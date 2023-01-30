import 'dart:async';

import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';

abstract class DialogRepository {
  /// location listen
  Stream<List<LocationData>> listenLocation();

  /// location selected
  Future<SimpleResponseModel> changeSelectedLocation({
    required LocationData locationData,
  });

  /// location delete
  Future<bool> deleteLocation({
    required LocationData deleteLocationData,
  });

  /// location clear
  Future<bool> clearLocation();
}

class DialogRepositoryImpl extends DialogRepository {
  final MoorDatabase moorDatabase;

  DialogRepositoryImpl({required this.moorDatabase});

  @override
  Stream<List<LocationData>> listenLocation() => moorDatabase.listenLocation();

  /// delete location
  @override
  Future<bool> deleteLocation(
      {required LocationData deleteLocationData}) async {
    await moorDatabase.deleteLocation(locationData: deleteLocationData);
    return true;
  }

  @override
  Future<SimpleResponseModel> changeSelectedLocation(
      {required LocationData locationData}) async {
    if (locationData.selectedStatus) {
      await moorDatabase.insertOrUpdateLocation(
        locationData: locationData.copyWith(
          selectedStatus: false,
        ),
      );
    } else {
      final selectedLocation = await moorDatabase.getSelectedLocation();
      if (selectedLocation != null) {
        await moorDatabase.insertOrUpdateLocation(
          locationData: selectedLocation.copyWith(
            selectedStatus: false,
          ),
        );
      }
      await moorDatabase.insertOrUpdateLocation(
        locationData: locationData.copyWith(
          selectedStatus: true,
        ),
      );
    }
    return SimpleResponseModel.success();
  }

  @override
  Future<bool> clearLocation() async {
    await moorDatabase.clearLocation();
    return true;
  }
}
