import 'dart:async';
import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/location_model/map_location_network_service.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:hive/hive.dart';

abstract class DialogRepository {
  /// location listen
  Stream<List<LocationData>> listenLocation();

  /// location selected
  Future<SimpleResponseModel> changeSelectedLocation({
    required LocationData locationData,
  });

  /// location delete
  Future<SimpleResponseModel> deleteLocation({
    required LocationData locationData,
  });

  /// listen token
  Stream<BoxEvent> listenToken();

  /// get token
  Future<bool> getTokenInfo();
}

class DialogRepositoryImpl extends DialogRepository {
  final MapLocationNetworkService mapLocationNetworkService;
  final HiveDatabase hiveDatabase;
  final MoorDatabase moorDatabase;

  DialogRepositoryImpl({
    required this.mapLocationNetworkService,
    required this.hiveDatabase,
    required this.moorDatabase,
  });

  /// listen location
  @override
  Stream<List<LocationData>> listenLocation() => moorDatabase.listenLocation();

  /// listen token
  @override
  Stream<BoxEvent> listenToken() => hiveDatabase.listenToken();

  /// get token
  @override
  Future<bool> getTokenInfo() async {
    final response = await hiveDatabase.getToken();
    return response.isNotEmpty;
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
  Future<SimpleResponseModel> deleteLocation(
      {required LocationData locationData}) async {
    try {
      final getToken = await hiveDatabase.getToken();
      if (getToken.isNotEmpty) {
        final response = await mapLocationNetworkService.deleteLocationUrl(
            locationId: locationData.id);
        if (response.status == true && response.response != null) {
          await moorDatabase.deleteLocation(locationData: locationData);
          return getSimpleResponseErrorHandler(response);
        } else {
          return getSimpleResponseErrorHandler(response);
        }
      } else {
        await moorDatabase.deleteLocation(locationData: locationData);
        return SimpleResponseModel.success();
      }
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }
}
