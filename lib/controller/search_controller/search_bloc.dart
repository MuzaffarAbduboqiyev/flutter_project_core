import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/controller/search_controller/search_repository.dart';
import 'package:delivery_service/controller/search_controller/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;

  SearchBloc(super.initialState, {required this.repository}) {
    on<SearchCategoriesEvent>(
      _categories,
      transformer: concurrent(),
    );

    on<SearchRefreshEvent>(
      _refresh,
      transformer: restartable(),
    );

    on<SearchNameEvent>(
      _searchName,
      transformer: restartable(),
    );
  }

  FutureOr<void> _categories(
      SearchCategoriesEvent event, Emitter<SearchState> emit) async {
    if (state.searchHistory.isEmpty) {
      emit(
        state.copyWith(
          searchStatus: SearchStatus.loading,
        ),
      );
    }

    final response = await repository.searchCategories();

    emit(
      state.copyWith(
        searchStatus: (response.status || state.searchHistory.isNotEmpty)
            ? SearchStatus.loaded
            : SearchStatus.error,
        categories: response.data,
        error: response.message,
      ),
    );
  }

  FutureOr<void> _refresh(
      SearchRefreshEvent event, Emitter<SearchState> emit) async {
    if (state.searchName.isNotEmpty) {
      add(SearchNameEvent(searchName: state.searchName));
    } else {
      add(SearchCategoriesEvent());
    }
  }

  FutureOr<void> _searchName(
      SearchNameEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        searchStatus: SearchStatus.loading,
        searchName: event.searchName,
      ),
    );

    final response = await repository.search(searchName: event.searchName);

    emit(
      state.copyWith(
        searchStatus:
            (response.status) ? SearchStatus.loaded : SearchStatus.error,
        searchResponseModel: response.data,
        error: response.message,
      ),
    );
  }
}
