import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/controller/search_controller/search_state.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
import 'package:delivery_service/ui/widgets/items/search/history_item.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchHistory extends StatefulWidget {
  const SearchHistory({Key? key}) : super(key: key);

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  _clearHistory() {
    context.read<SearchBloc>().add(SearchClearHistoryEvent());
  }

  _showClearConfirm() async {
    await showConfirmDialog(
      context: context,
      title: translate("search.clear_title"),
      content: translate("search.clear_content"),
      confirm: _clearHistory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  translate("search.recent_searches"),
                  style: getCurrentTheme(context).textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: _showClearConfirm,
                child: Text(
                  translate("search.history_clear"),
                  style: getCurrentTheme(context).textTheme.labelMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) => ListView.builder(
              itemCount: state.searchHistory.length,
              itemBuilder: (context, index) => SearchHistoryItem(
                searchHistory: state.searchHistory[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
