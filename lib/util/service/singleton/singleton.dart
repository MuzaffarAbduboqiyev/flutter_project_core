import 'package:delivery_service/controller/app_controller/app_repository.dart';
import 'package:delivery_service/controller/category_controller/category_repository.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_repository.dart';
import 'package:delivery_service/model/category_model/category_network_service.dart';
import 'package:delivery_service/model/local_database/hive_database.dart';
import 'package:delivery_service/model/restaurant_model/restaurant_network_service.dart';
import 'package:delivery_service/util/service/network/network_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/*

  Singletonlik - classlarni faqat 1 marta objectini yaratish va application ishlash davomida foydalanish.
  lazy - biror bir class kerak bo'lib chaqirilgan vaqtda yaratib objecti hosil bo'lishi

 */

final singleton = GetIt.instance;

void init() {
  // HiveDatabase classni singltonlik qilish.
  // GetIt kutubxonasiga HiveDatabase classini qo'shdik
  // Lazy funksiyasi orqali, Qachonki biz HiveDatabaseni chaqirsak keyin uni objecti yaratiladi
  singleton.registerLazySingleton<HiveDatabase>(
    () => HiveDatabaseImpl(),
  );

  // Dio - network bilan ma'lumot almashinuvchi service(hizmat ko'rsatuvchi)
  // Dio ni singltonlik qilish
  singleton.registerLazySingleton<Dio>(
    () => Dio(dioBaseOptions),
  );

  // Network serviceni singleton qilish
  singleton.registerLazySingleton<NetworkService>(
    () => NetworkServiceImpl(
      dio: singleton(),
      hiveDatabase: singleton(),
    ),
  );

  // App repositoryni singleton qilish
  singleton.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(
      hiveDatabase: singleton(),
    ),
  );

  // Category repositoryni singleton qilish
  singleton.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      networkService: singleton(),
    ),
  );

  // Category network service singleton qilish
  singleton.registerLazySingleton<CategoryNetworkService>(
    () => CategoryNetworkServiceImpl(
      networkService: singleton(),
    ),
  );

  // Restaurant repositoryni singleton qilish
  singleton.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      networkService: singleton(),
    ),
  );

  // Restaurant network service singleton qilish
  singleton.registerLazySingleton<RestaurantNetworkService>(
    () => RestaurantNetworkServiceImpl(
      networkService: singleton(),
    ),
  );
}
