import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/location_model/location_network_service.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';
import 'package:flutter/foundation.dart';

abstract class LocationRepository {
  Future<List<LocationData>> getLocations();

  Stream<List<LocationData>> listenLocations();

  Future<int> insertOrUpdateLocation({
    required LocationData locationData,
  });

  Future<int> deleteLocation({
    required LocationData locationData,
  });

  Future<int> clearLocations();

  Future<DataResponseModel<LocationData>> getLocationInfo({
    required double lat,
    required double lng,
    required String name,
  });
}

class LocationRepositoryImpl extends LocationRepository {
  final LocationNetworkService networkService;
  final MoorDatabase moorDatabase;

  LocationRepositoryImpl({
    required this.networkService,
    required this.moorDatabase,
  });

  @override
  Future<int> insertOrUpdateLocation({
    required LocationData locationData,
  })async{
    final response = await moorDatabase.insertOrUpdateLocation(locationData: locationData);
    final locations = await getLocations();
    if (kDebugMode) {
      print("Inserted $response");
      print("Lists: ${locations.length}");
    }
    return response;
  }

  @override
  Stream<List<LocationData>> listenLocations() =>
      moorDatabase.listenLocations();

  @override
  Future<List<LocationData>> getLocations() => moorDatabase.getLocations();

  @override
  Future<int> deleteLocation({required LocationData locationData}) =>
      moorDatabase.deleteLocation(locationData: locationData);

  @override
  Future<int> clearLocations() => moorDatabase.clearLocation();

  @override
  Future<DataResponseModel<LocationData>> getLocationInfo(
      {required double lat, required double lng, required String name}) async {
    try {
      final response = await networkService.locationInfo(
        lat: lat,
        lng: lng,
        name: name,
      );
      if (response.status == true && response.response != null) {
        if (response.response?.data.containsKey("status") == true &&
            response.response?.data["status"] == true &&
            response.response?.data.containsKey("data")) {
          final address = LocationData(
            lat: lat,
            lng: lng,
            name: parseToString(
              response: response.response?.data?["data"],
              key: "address",
            ),
            selectedStatus: true,
          );
          return DataResponseModel.success(model: address);
        } else {
          return DataResponseModel.success(
            model: LocationData(
              lat: lat,
              lng: lng,
              name: name,
              selectedStatus: true,
            ),
          );
        }
      } else {
        return DataResponseModel.success(
          model: LocationData(
            lat: lat,
            lng: lng,
            name: name,
            selectedStatus: true,
          ),
        );
      }
    } catch (error) {
      return DataResponseModel.success(
        model: LocationData(
          lat: lat,
          lng: lng,
          name: name,
          selectedStatus: true,
        ),
      );
    }
  }
}
