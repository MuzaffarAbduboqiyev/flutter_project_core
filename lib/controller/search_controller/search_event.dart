import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class SearchEvent {}

class SearchCategoriesEvent extends SearchEvent {}

/// category refresh
class SearchRefreshEvent extends SearchEvent {}

class SearchHistoryEvent extends SearchEvent {
  final List<SearchData> searchHistories;

  SearchHistoryEvent({required this.searchHistories});
}

/// search category
class SearchNameEvent extends SearchEvent {
  final String searchName;
  final int categoryId;

  SearchNameEvent({
    required this.searchName,
    required this.categoryId,
  });
}

class SearchRemoveHistoryEvent extends SearchEvent {
  final SearchData historyItem;

  SearchRemoveHistoryEvent({required this.historyItem});
}

/// search restaurant va product
class SearchSaveHistoryEvent extends SearchEvent {}

/// clear history
class SearchClearHistoryEvent extends SearchEvent {}
