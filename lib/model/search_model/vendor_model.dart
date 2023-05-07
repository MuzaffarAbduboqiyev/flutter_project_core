import 'package:delivery_service/util/service/network/parser_service.dart';

class VendorModel {
  final int id;
  final String name;
  final String image;

  VendorModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory VendorModel.fromMap(Map<String, dynamic> response) => VendorModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        image: parseToString(response: response, key: "image"),
      );

  factory VendorModel.example() => VendorModel(
        id: 0,
        name: "",
        image: "",
      );
}

List<VendorModel> parseVendorModel(dynamic response) {
  final List<VendorModel> vendors = [];

  if (response is List) {
    for (var element in response) {
      final VendorModel vendorModel = VendorModel.fromMap(element);
      vendors.add(vendorModel);
    }
  }

  return vendors;
}
