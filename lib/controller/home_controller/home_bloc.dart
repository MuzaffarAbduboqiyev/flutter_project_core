import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/category_controller/category_repository.dart';
import 'package:delivery_service/controller/category_controller/category_state.dart';
import 'package:delivery_service/controller/home_controller/home_event.dart';
import 'package:delivery_service/controller/home_controller/home_repository.dart';
import 'package:delivery_service/controller/home_controller/home_state.dart';
import 'package:delivery_service/controller/location_controller/location_repository.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_repository.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoryRepository categoryRepository;
  final RestaurantRepository restaurantRepository;
  final LocationRepository locationRepository;
  final HomeRepository homeRepository;
  late StreamSubscription streamSubscription;

  HomeBloc({
    required this.categoryRepository,
    required this.homeRepository,
    required this.restaurantRepository,
    required this.locationRepository,
  }) : super(HomeState.initial()) {
    /// Har qanday on<Event> eventTransformer ga murojat qilish uchun, Bloc ga Event ni add qilish kerak
    /// Ya'ni Bloc(context.read<Bloc>()).add(Event); qilinadi
    /// Misol: context.read<HomeBloc>.add(HomeGetCategoriesEvent());
    /// bu misolda on<HomeGetCategoriesEvent> eventTransformer ga murojat qilinadi

    on<HomeGetCategoriesEvent>(
      _getAllCategories,
      transformer: concurrent(),
    );

    on<HomeChangeSelectedCategoryEvent>(
      _changeSelectedCategory,
      transformer: sequential(),
    );

    on<HomeGetRestaurantsEvent>(
      _getRestaurants,
      transformer: restartable(),
    );

    on<HomeListenLocationEvent>(
      _listenLocation,
      transformer: concurrent(),
    );
    on<HomeListenFavoriteEvent>(
      _listenFavorite,
      transformer: concurrent(),
    );
    on<HomeChangeFavoriteEvent>(
      _changeFavorite,
      transformer: concurrent(),
    );

    /// listen token
    on<HomeListenTokenEvent>(
      _listenToken,
      transformer: concurrent(),
    );

    /// get token
    on<HomeGetTokenEvent>(
      _getToken,
      transformer: concurrent(),
    );

    /// listen userName
    on<HomeListenUserNameEvent>(
      _listenUserName,
      transformer: concurrent(),
    );

    /// get userName
    on<HomeUserNameEvent>(
      _getUserName,
      transformer: concurrent(),
    );

    /// listen userSurname
    on<HomeListenUserSurnameEvent>(
      _listenUserSurname,
      transformer: concurrent(),
    );

    /// get userSurname
    on<HomeUserSurnameEvent>(
      _getUserSurname,
      transformer: concurrent(),
    );

    streamSubscription = homeRepository.listenToken().listen((listenToken) {
      add(
        HomeListenTokenEvent(token: listenToken.value.toString().isNotEmpty),
      );
    });
    streamSubscription = locationRepository.listenLocation().listen((location) {
      final selectedLocation = location.firstWhere(
        (element) => element.selectedStatus,
        orElse: () => LocationData(
          id: 0,
          lat: "",
          lng: "",
          address: "",
          comment: "",
          updated: "",
          created: "",
          defaults: false,
          selectedStatus: false,
        ),
      );

      add(HomeListenLocationEvent(locationData: selectedLocation));
    });
    streamSubscription =
        restaurantRepository.listenFavorite().listen((favorite) {
      add(HomeListenFavoriteEvent(favoriteData: favorite));
    });

    streamSubscription = homeRepository.listenUserName().listen((listenName) {
      add(HomeListenUserNameEvent(userName: listenName.value));
    });

    streamSubscription =
        homeRepository.listenUserSurname().listen((listenSurname) {
      add(HomeListenUserSurnameEvent(userSurname: listenSurname.value));
    });
  }

  /// listen token
  FutureOr<void> _listenToken(
      HomeListenTokenEvent event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        token: event.token,
      ),
    );
  }

  /// get token
  FutureOr<void> _getToken(
      HomeGetTokenEvent event, Emitter<HomeState> emit) async {
    final hasToken = await homeRepository.getTokenInfo();
    emit(
      state.copyWith(
        token: hasToken,
      ),
    );
  }

  /// listen location
  FutureOr<void> _listenLocation(
      HomeListenLocationEvent event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        locationData: event.locationData,
      ),
    );
  }

  /// listen userName
  FutureOr<void> _listenUserName(
      HomeListenUserNameEvent event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        userName: event.userName,
      ),
    );
  }

  /// listen favorite
  FutureOr<void> _listenFavorite(
      HomeListenFavoriteEvent event, Emitter<HomeState> emit) async {
    state.restaurantModel.asMap().forEach((index, element) {
      state.restaurantModel[index] =
          state.restaurantModel[index].copyWith(isFavorite: false);

      for (var favoriteData in event.favoriteData) {
        if (element.id == favoriteData.id) {
          state.restaurantModel[index] =
              state.restaurantModel[index].copyWith(isFavorite: true);
        }
      }
    });

    emit(
      state.copyWith(
        restaurantModel: state.restaurantModel,
      ),
    );
  }

  FutureOr<void> _getAllCategories(
      HomeGetCategoriesEvent event, Emitter<HomeState> emit) async {
    if (state.categoryStatus != CategoryStatus.loading) {
      emit(
        state.copyWith(
          categoryStatus: CategoryStatus.loading,
        ),
      );

      final DataResponseModel<List<CategoryModel>> response =
          await categoryRepository.getAllCategories();

      emit(
        state.copyWith(
          selectedCategoryId: -1,
          categoryModel: response.data,
          categoryStatus:
              (response.status) ? CategoryStatus.loaded : CategoryStatus.error,
        ),
      );
    }
  }

  FutureOr<void> _changeSelectedCategory(
      HomeChangeSelectedCategoryEvent event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        selectedCategoryId: (state.selectedCategoryId == event.categoryModel.id)
            ? -1
            : event.categoryModel.id,
      ),
    );

    /// Selected Category item o'zgarganda Category ga mos Restaurantlarni olib kelish kerak
    /// Shuning uchun HomeGetRestaurantsEvent Blocga add qildik
    add(HomeGetRestaurantsEvent());
  }

  FutureOr<void> _getRestaurants(
      HomeGetRestaurantsEvent event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        restaurantStatus: RestaurantStatus.loading,
      ),
    );

    final response = await restaurantRepository.getAllRestaurants();
    final databaseResponse = await restaurantRepository.getFavorites();
    if (response.status && response.data != null) {
      response.data?.asMap().forEach((index, element) {
        response.data?[index] =
            response.data![index].copyWith(isFavorite: false);

        for (var favoriteRestaurant in databaseResponse) {
          if (favoriteRestaurant.id == element.id) {
            response.data![index] =
                response.data![index].copyWith(isFavorite: true);
          }
        }
      });

      emit(
        state.copyWith(
          restaurantModel: response.data,
          restaurantStatus: RestaurantStatus.loaded,
        ),
      );
    } else {
      emit(
        state.copyWith(
          restaurantStatus: RestaurantStatus.error,
        ),
      );
    }
  }

  /// change favorite
  FutureOr<void> _changeFavorite(
      HomeChangeFavoriteEvent event, Emitter<HomeState> emit) async {
    await restaurantRepository.changeRestaurantFavoriteState(
        restaurantModel: event.restaurantModel);
  }

  FutureOr<void> _getUserName(
      HomeUserNameEvent event, Emitter<HomeState> emit) async {
    final userName = await homeRepository.getUserName();

    emit(
      state.copyWith(
        userName: userName,
      ),
    );
  }

  /// listen Surname
  FutureOr<void> _listenUserSurname(
      HomeListenUserSurnameEvent event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        userSurname: event.userSurname,
      ),
    );
  }

  /// get userSurname
  FutureOr<void> _getUserSurname(
      HomeUserSurnameEvent event, Emitter<HomeState> emit) async {
    final userSurname = await homeRepository.getUserSurname();
    emit(
      state.copyWith(
        userSurname: userSurname,
      ),
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
