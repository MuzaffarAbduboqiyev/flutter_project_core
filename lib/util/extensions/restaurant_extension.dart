import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';

extension RestaurantExtension on RestaurantModel {
  FavoriteData parseToFavoriteModel() => FavoriteData(
        id: id,
        name: name,
        image: image,
        rating: rating,
        affordability: affordability,
        deliveryTime: deliveryTime,
        available: available,
      );
}
