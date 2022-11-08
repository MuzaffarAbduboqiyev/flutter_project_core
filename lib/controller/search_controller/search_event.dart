abstract class SearchEvent {}

class SearchCategoriesEvent extends SearchEvent {}

class SearchRefreshEvent extends SearchEvent {}

class SearchNameEvent extends SearchEvent {
  final String searchName;

  SearchNameEvent({required this.searchName});
}
