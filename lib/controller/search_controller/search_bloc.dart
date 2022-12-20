import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/controller/search_controller/search_repository.dart';
import 'package:delivery_service/controller/search_controller/search_state.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/search_model/search_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;
  late StreamSubscription<List<SearchData>> historyListener;

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

    on<SearchRemoveHistoryEvent>(
      _removeHistory,
      transformer: restartable(),
    );

    on<SearchClearHistoryEvent>(
      _clearHistory,
      transformer: restartable(),
    );

    on<SearchSaveHistoryEvent>(
      _saveHistory,
      transformer: restartable(),
    );

    on<SearchHistoryEvent>(
      _searchHistory,
      transformer: restartable(),
    );

    historyListener =
        repository.listenSearchHistory().listen((searchHistories) {
      add(
        SearchHistoryEvent(searchHistories: searchHistories),
      );
    });
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
          searchStatus: (event.searchName.isNotEmpty)
              ? SearchStatus.loading
              : SearchStatus.loaded,
          searchName: event.searchName,
          searchResponseModel: SearchResponseModel.example()),
    );

    if (event.searchName.isNotEmpty) {
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

  FutureOr<void> _removeHistory(
      SearchRemoveHistoryEvent event, Emitter<SearchState> emit) async {
    await repository.removeSearchHistory(searchData: event.historyItem);
  }

  FutureOr<void> _clearHistory(
      SearchClearHistoryEvent event, Emitter<SearchState> emit) async {
    await repository.clearSearchHistory();
  }

  FutureOr<void> _saveHistory(
      SearchSaveHistoryEvent event, Emitter<SearchState> emit) async {
    await repository.saveSearchHistory(searchName: state.searchName);
  }

  FutureOr<void> _searchHistory(
      SearchHistoryEvent event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(
        searchHistory: event.searchHistories,
      ),
    );
  }

  @override
  Future<void> close() async {
    await historyListener.cancel();
    return super.close();
  }
}
