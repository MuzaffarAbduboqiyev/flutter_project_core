import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchHistoryItem extends StatefulWidget {
  final SearchData searchHistory;
  final int categoryId;

  const SearchHistoryItem(
      {required this.searchHistory, required this.categoryId, Key? key})
      : super(key: key);

  @override
  State<SearchHistoryItem> createState() => _SearchHistoryItemState();
}

class _SearchHistoryItemState extends State<SearchHistoryItem> {
  _changeSearchName() {
    context.read<SearchBloc>().add(
          SearchNameEvent(
            searchName: widget.searchHistory.searchName,
            categoryId: widget.categoryId,
          ),
        );
  }
/// delete search name
  _deleteCurrentSearch() {
    context.read<SearchBloc>().add(
          SearchRemoveHistoryEvent(
            historyItem: widget.searchHistory,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _changeSearchName,
      leading: Icon(
        Icons.access_time_outlined,
        size: 20,
        color: getCurrentTheme(context).hintColor,
      ),
      title: Text(
        widget.searchHistory.searchName,
        style: getCurrentTheme(context).textTheme.labelLarge,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: InkWell(
        onTap: _deleteCurrentSearch,
        child: Icon(
          Icons.clear,
          size: 20,
          color: getCurrentTheme(context).hintColor,
        ),
      ),
    );
  }
}
