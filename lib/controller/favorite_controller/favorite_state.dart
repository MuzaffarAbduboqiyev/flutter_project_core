import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_model.dart';

class FavoriteState {
  final List<FavoriteData> favoriteData;
  final RestaurantModel restaurantModel;

  FavoriteState({
    required this.favoriteData,
    required this.restaurantModel,
  });

  factory FavoriteState.initial() => FavoriteState(
        favoriteData: [],
        restaurantModel: RestaurantModel.example(),
      );

  FavoriteState copyWith({
    List<FavoriteData>? favoriteData,
    RestaurantModel? restaurantModel,
  }) =>
      FavoriteState(
        favoriteData: favoriteData ?? this.favoriteData,
        restaurantModel: restaurantModel ?? this.restaurantModel,
      );
}
