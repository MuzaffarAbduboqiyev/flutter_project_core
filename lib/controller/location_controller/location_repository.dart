import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/location_model/location_network_service.dart';
import 'package:delivery_service/model/location_model/map_location_network_service.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/network/parser_service.dart';

abstract class LocationRepository {
  /// location listen
  Stream<List<LocationData>> listenLocation();

  /// moorDatabase location olish
  Future<List<LocationData>> getLocations();

  Future<SimpleResponseModel> insertOrUpdateLocation({
    required LocationData locationData,
  });

  /// location delete
  Future<SimpleResponseModel> deleteLocations({
    required LocationData locationData,
  });

  Future<DataResponseModel<LocationData>> getLocationInfo({
    required String lat,
    required String lng,
  });
}

class LocationRepositoryImpl extends LocationRepository {
  final MapLocationNetworkService mapLocationNetworkService;
  final LocationNetworkService locationNetworkService;
  final MoorDatabase moorDatabase;
  final HiveDatabase hiveDatabase;

  LocationRepositoryImpl({
    required this.mapLocationNetworkService,
    required this.locationNetworkService,
    required this.moorDatabase,
    required this.hiveDatabase,
  });

  /// shu joyda ishlaydi
  @override
  Future<SimpleResponseModel> insertOrUpdateLocation({
    required LocationData locationData,
  }) async {
    try {
      final getToken = await hiveDatabase.getToken();
      if (getToken.isNotEmpty) {
        final body = {
          "address": locationData.address,
          "latitude": locationData.lat,
          "longitude": locationData.lng,
          "district": "Chortoq",
          "region_id": 2,
          "default": locationData.selectedStatus,
          "comment": "sss",
        };

        final response =
            await mapLocationNetworkService.requestLocationUrl(body: body);

        if (response.status == true && response.response != null) {
          if (response.response?.data.containsKey("data") == true) {
            final locationCartData = LocationData(
              id: parseToInt(
                  response: response.response?.data["data"], key: "id"),
              defaults: parseToBool(
                  response: response.response?.data["data"], key: "default"),
              address: parseToString(
                  response: response.response?.data["data"], key: "address"),
              lat: parseToString(
                  response: response.response?.data["data"], key: "latitude"),
              lng: parseToString(
                  response: response.response?.data["data"], key: "longitude"),
              comment: parseToString(
                  response: response.response?.data["data"], key: "comment"),
              created: parseToString(
                  response: response.response?.data["data"], key: "created_at"),
              updated: parseToString(
                  response: response.response?.data["data"], key: "updated_at"),
              selectedStatus: parseToBool(
                  response: response.response?.data["data"], key: "default"),
            );

            final selectedLocation = await moorDatabase.getSelectedLocation();

            if (selectedLocation != null) {
              await moorDatabase.insertOrUpdateLocation(
                  locationData:
                      selectedLocation.copyWith(selectedStatus: false));
            }

            await moorDatabase.insertOrUpdateLocation(
                locationData: locationCartData);

            return SimpleResponseModel.success();
          } else {
            return getSimpleResponseErrorHandler(response);
          }
        } else {
          return getSimpleResponseErrorHandler(response);
        }
      }

      ///
      else {
        final selectedLocation = await moorDatabase.getSelectedLocation();
        if (selectedLocation != null) {
          await moorDatabase.deleteLocation(locationData: selectedLocation);
          await moorDatabase.insertOrUpdateLocation(
            locationData: selectedLocation.copyWith(
              selectedStatus: false,
            ),
          );
        }

        await moorDatabase.insertOrUpdateLocation(locationData: locationData);

        return SimpleResponseModel.success();
      }
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Stream<List<LocationData>> listenLocation() => moorDatabase.listenLocation();

  @override
  Future<List<LocationData>> getLocations() => moorDatabase.getLocations();

  @override
  Future<SimpleResponseModel> deleteLocations(
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

  @override
  Future<DataResponseModel<LocationData>> getLocationInfo({
    required String lat,
    required String lng,
  }) async {
    try {
      final response = await locationNetworkService.locationInfo(
        lat: lat,
        lng: lng,
      );
      if (response.status == true && response.response != null) {
        if (response.response?.data.containsKey("status") == true &&
            response.response?.data["status"] == true &&
            response.response?.data.containsKey("data")) {
          final address = LocationData(
            id: 0,
            lat: lat,
            lng: lng,
            comment: "",
            created: "",
            updated: "",
            defaults: false,
            address: parseToString(
              response: response.response?.data["data"],
              key: "address",
            ),
            selectedStatus: true,
          );
          return DataResponseModel.success(model: address);
        } else {
          return DataResponseModel.success(
            model: LocationData(
              id: 0,
              lat: lat,
              lng: lng,
              address: "",
              comment: "",
              created: "",
              updated: "",
              defaults: false,
              selectedStatus: true,
            ),
          );
        }
      } else {
        return DataResponseModel.success(
          model: LocationData(
            id: 0,
            lat: lat,
            lng: lng,
            address: "",
            comment: "",
            created: "",
            updated: "",
            defaults: false,
            selectedStatus: true,
          ),
        );
      }
    } catch (error) {
      return DataResponseModel.success(
        model: LocationData(
          id: 0,
          lat: lat,
          lng: lng,
          address: "",
          comment: "",
          created: "",
          updated: "",
          defaults: false,
          selectedStatus: true,
        ),
      );
    }
  }
}
