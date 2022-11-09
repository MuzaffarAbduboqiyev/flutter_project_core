import 'package:delivery_service/model/local_database/moor_database.dart';

abstract class SearchEvent {}

class SearchCategoriesEvent extends SearchEvent {}

class SearchRefreshEvent extends SearchEvent {}

class SearchHistoryEvent extends SearchEvent {
  final List<SearchData> searchHistories;
  SearchHistoryEvent({required this.searchHistories});
}

class SearchNameEvent extends SearchEvent {
  final String searchName;

  SearchNameEvent({required this.searchName});
}

class SearchRemoveHistoryEvent extends SearchEvent {
  final SearchData historyItem;

  SearchRemoveHistoryEvent({required this.historyItem});
}

class SearchClearHistoryEvent extends SearchEvent {}

class SearchSaveHistoryEvent extends SearchEvent {}


