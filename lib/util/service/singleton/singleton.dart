import 'package:delivery_service/controller/account_controller/account_repository.dart';
import 'package:delivery_service/controller/app_controller/app_repository.dart';
import 'package:delivery_service/controller/category_controller/category_repository.dart';
import 'package:delivery_service/controller/dashboard_controller/dashboard_repository.dart';
import 'package:delivery_service/controller/dialog_controller/dialog_repository.dart';
import 'package:delivery_service/controller/favorite_controller/favorite_repository.dart';
import 'package:delivery_service/controller/home_controller/home_repository.dart';
import 'package:delivery_service/controller/location_controller/location_repository.dart';
import 'package:delivery_service/controller/order_controller/order_repository.dart';
import 'package:delivery_service/controller/orders_controller/orders_repository.dart';
import 'package:delivery_service/controller/otp_controller/otp_repository.dart';
import 'package:delivery_service/controller/payment_controller/payment_repository.dart';
import 'package:delivery_service/controller/product_controller/product_repository.dart';
import 'package:delivery_service/controller/profile_controller/profile_repository.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_repository.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_search_controller/restaurant_search_repository.dart';
import 'package:delivery_service/controller/search_controller/search_repository.dart';
import 'package:delivery_service/controller/welcome_controller/welcome_repository.dart';
import 'package:delivery_service/model/category_model/category_network_service.dart';
import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/location_model/location_network_service.dart';
import 'package:delivery_service/model/location_model/map_location_network_service.dart';
import 'package:delivery_service/model/order_model/order_network_service.dart';
import 'package:delivery_service/model/orders_model/orders_network_service.dart';
import 'package:delivery_service/model/otp_model/otp_network_service.dart';
import 'package:delivery_service/model/payment_model/payment_network_service.dart';
import 'package:delivery_service/model/product_model/product_network_service.dart';
import 'package:delivery_service/model/profile_model/profile_network_service.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_network_service.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_search_network_service.dart';
import 'package:delivery_service/model/search_model/search_network_service.dart';
import 'package:delivery_service/model/welcome_model/welcome_network_service.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/*

  Singletonlik - classlarni faqat 1 marta objectini yaratish va application ishlash davomida foydalanish.
  lazy - biror bir class kerak bo'lib chaqirilgan vaqtda yaratib objecti hosil bo'lishi

 */

final singleton = GetIt.instance;

void init() {
  /// HiveDatabase classni singltonlik qilish.
  /// GetIt kutubxonasiga HiveDatabase classini qo'shdik
  /// Lazy funksiyasi orqali, Qachonki biz HiveDatabaseni chaqirsak keyin uni objecti yaratiladi
  singleton.registerLazySingleton<HiveDatabase>(
    () => HiveDatabaseImpl(),
  );

  /// Dio - network bilan ma'lumot almashinuvchi service(hizmat ko'rsatuvchi)
  /// Dio ni singltonlik qilish
  singleton.registerLazySingleton<Dio>(
    () => Dio(dioBaseOptions),
  );

  /// Network serviceni
  singleton.registerLazySingleton<NetworkService>(
    () => NetworkServiceImpl(
      dio: singleton(),
      hiveDatabase: singleton(),
    ),
  );

  /// App controller
  singleton.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(
      hiveDatabase: singleton(),
    ),
  );

  /// MoorDatabase
  singleton.registerLazySingleton<MoorDatabase>(
    () => MoorDatabase(),
  );

  /// Category category
  singleton.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      networkService: singleton(),
    ),
  );

  singleton.registerLazySingleton<CategoryNetworkService>(
    () => CategoryNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// Restaurant controller
  singleton.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      restaurantNetworkService: singleton(),
      categoryRepository: singleton(),
      productRepository: singleton(),
      hiveDatabase: singleton(),
      moorDatabase: singleton(),
    ),
  );

  singleton.registerLazySingleton<RestaurantNetworkService>(
    () => RestaurantNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// Search controller
  singleton.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      searchNetworkService: singleton(),
      categoryRepository: singleton(),
      moorDatabase: singleton(),
    ),
  );

  singleton.registerLazySingleton<SearchNetworkService>(
    () => SearchNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// Product controller
  singleton.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productNetworkService: singleton(),
      moorDatabase: singleton(),
      hiveDatabase: singleton(),
    ),
  );

  singleton.registerLazySingleton<ProductNetworkService>(
    () => ProductNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// quramiz location
  singleton.registerLazySingleton<LocationNetworkService>(
    () => LocationNetworkService.initial(),
  );

  singleton.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      mapLocationNetworkService: singleton(),
      locationNetworkService: singleton(),
      moorDatabase: singleton(),
      hiveDatabase: singleton(),
    ),
  );
  ///////////////////////////////////////////////////////////
  singleton.registerLazySingleton<MapLocationNetworkService>(
    () => MapLocationNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// Dialog controller
  singleton.registerLazySingleton<DialogRepository>(
    () => DialogRepositoryImpl(
      mapLocationNetworkService: singleton(),
      hiveDatabase: singleton(),
      moorDatabase: singleton(),
    ),
  );

  /// home controller
  singleton.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      hiveDatabase: singleton(),
    ),
  );

  /// Welcome controller
  singleton.registerLazySingleton<WelcomeRepository>(
    () => WelcomeRepositoryImpl(
      welcomeNetworkService: singleton(),
      hiveDatabase: singleton(),
    ),
  );

  singleton.registerLazySingleton<WelcomeNetworkService>(
    () => WelcomeNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// Otp controller
  singleton.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(
      otpNetworkService: singleton(),
      hiveDatabase: singleton(),
      welcomeRepository: singleton(),
    ),
  );

  singleton.registerLazySingleton<OtpNetworkService>(
    () => OtpNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// Account controller
  singleton.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(
      hiveDatabase: singleton(),
    ),
  );

  /// Profile controller
  singleton.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileNetworkService: singleton(),
      hiveDatabase: singleton(),
    ),
  );
  singleton.registerLazySingleton<ProfileNetworkService>(
    () => ProfileNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// Favorite controller
  singleton.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(
      moorDatabase: singleton(),
    ),
  );

  /// order controller
  singleton.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      orderNetworkService: singleton(),
      productRepository: singleton(),
      moorDatabase: singleton(),
      hiveDatabase: singleton(),
    ),
  );
  singleton.registerLazySingleton<OrderNetworkService>(
    () => OrderNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// payment controller
  singleton.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      paymentNetworkService: singleton(),
      moorDatabase: singleton(),
    ),
  );
  singleton.registerLazySingleton<PaymentNetworkService>(
    () => PaymentNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// orders controller
  singleton.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(
      ordersNetworkService: singleton(),
      hiveDatabase: singleton(),
    ),
  );
  singleton.registerLazySingleton<OrdersNetworkService>(
    () => OrdersNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  /// dashboard controller
  singleton.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      moorDatabase: singleton(),
      hiveDatabase: singleton(),
    ),
  );

  /// restaurant search controller
  singleton.registerLazySingleton<RestaurantSearchRepository>(
    () => RestaurantSearchRepositoryImpl(
      restaurantSearchNetworkService: singleton(),
      moorDatabase: singleton(),
    ),
  );
  singleton.registerLazySingleton<RestaurantSearchNetworkService>(
    () => RestaurantSearchNetworkServiceImpl(
      networkService: singleton(),
    ),
  );
}
