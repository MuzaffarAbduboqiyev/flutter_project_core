import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/location_model/location_network_service.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';

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
  }) =>
      moorDatabase.insertOrUpdateLocation(locationData: locationData);

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
      {required double lat, required double lng}) async {
    try {
      final response = await networkService.locationInfo(
        lat: lat,
        lng: lng,
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
              selectedStatus: true,
            ),
          );
        }
      } else {
        return DataResponseModel.success(
          model: LocationData(
            lat: lat,
            lng: lng,
            selectedStatus: true,
          ),
        );
      }
    } catch (error) {
      return DataResponseModel.success(
        model: LocationData(
          lat: lat,
          lng: lng,
          selectedStatus: true,
        ),
      );
    }
  }
}
