import 'package:delivery_service/util/service/network/parser_service.dart';

class RestaurantModel {
  final int id;
  final String name;
  final String image;
  final double rating;
  final String affordability;
  final int deliveryTime;
  final bool available;
  final bool isFavorite;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.affordability,
    required this.deliveryTime,
    required this.available,
    required this.isFavorite,
  });

  factory RestaurantModel.example() => RestaurantModel(
        id: 0,
        name: "",
        image: "",
        rating: 0,
        affordability: "",
        deliveryTime: 0,
        available: false,
        isFavorite: false,
      );

  factory RestaurantModel.fromMap(Map<String, dynamic> response) =>
      RestaurantModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        image: parseToString(response: response, key: "image"),
        rating: parseToDouble(response: response, key: "rating"),
        affordability: parseToString(response: response, key: "affordability"),
        deliveryTime: parseToInt(
            response: response, key: "average_delivery_time_in_minutes"),
        available: parseToBool(response: response, key: "is_available"),
        isFavorite: parseToBool(response: response, key: "is_favorite"),
      );

  RestaurantModel copyWith({
    int? id,
    String? name,
    String? image,
    double? rating,
    String? affordability,
    int? deliveryTime,
    bool? available,
    bool? isFavorite,
  }) =>
      RestaurantModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        rating: rating ?? this.rating,
        affordability: affordability ?? this.affordability,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        available: available ?? this.available,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}

List<RestaurantModel> parseRestaurantModel(dynamic response) {
  final List<RestaurantModel> restaurants = [];

  if (response is List) {
    for (Map<String, dynamic> element in response) {
      final RestaurantModel restaurantModel = RestaurantModel.fromMap(element);
      restaurants.add(restaurantModel);
    }
  } else if (response is Map<String, dynamic>) {
    final RestaurantModel restaurantModel = RestaurantModel.fromMap(response);
    restaurants.add(restaurantModel);
  }

  return restaurants;
}
