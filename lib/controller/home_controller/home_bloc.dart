import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/category_controller/category_repository.dart';
import 'package:delivery_service/controller/home_controller/home_event.dart';
import 'package:delivery_service/controller/home_controller/home_state.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoryRepository categoryRepository;

  HomeBloc({required this.categoryRepository}) : super(HomeState.initial()) {
    on<HomeGetCategoriesEvent>(
      _getAllCategories,
      transformer: sequential(),
    );

    on<HomeChangeSelectedCategoryEvent>(
      _changeSelectedCategory,
      transformer: sequential(),
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
          categories: response.data,
          categoryStatus:
              (response.status) ? CategoryStatus.loaded : CategoryStatus.error,
        ),
      );
    }
  }

  FutureOr<void> _changeSelectedCategory(HomeChangeSelectedCategoryEvent event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        selectedCategoryId: (state.selectedCategoryId == event.categoryModel.id) ? -1 : event.categoryModel.id,
      ),
    );
  }
}
