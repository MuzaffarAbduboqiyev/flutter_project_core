import 'package:delivery_service/model/response_model/network_response_model.dart';

Future<SimpleResponseModel> getLocationPermissionStatus() async {
  // var status = await Permission.location.status;
  //
  //   if (status != PermissionStatus.granted) {
  //     await Permission.location.request();
  //   status = await Permission.location.status;
  // }
  //
  // if (status == PermissionStatus.granted) {
  //   return SimpleResponseModel.success();
  // } else {
  //   await openAppSettings();
  //   return SimpleResponseModel.error();
  // }

  return SimpleResponseModel.success();
}
