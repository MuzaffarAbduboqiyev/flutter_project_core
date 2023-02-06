import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/controller/search_controller/search_state.dart';
import 'package:delivery_service/ui/search/search_widgets/seach_category.dart';
import 'package:delivery_service/ui/search/search_widgets/search_history.dart';
import 'package:delivery_service/ui/search/search_widgets/search_loading.dart';
import 'package:delivery_service/ui/search/search_widgets/search_products.dart';
import 'package:delivery_service/ui/widgets/error/connection_error/connection_error.dart';
import 'package:delivery_service/ui/widgets/error/not_found/not_found_error.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        SearchState.initial(),
        searchRepository: singleton(),
      ),
      child: const SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  /// Biz search qilayapganimizda, har safar knopka bosilganda serverdan ma'lumot olib kelmasligimiz uchun,
  /// ma'lum vaqt belgilaymiz, agar shu vaqt ichida yana shu method chaqirilsa vaqtni yana qaytadan sanash boshlanadi
  /// va shu belgilangan vaqt tugagandan keyin, berilgan amal bajariladi
  _changeSearchName() {
    EasyDebounce.debounce(
      "change_search_name",
      const Duration(milliseconds: 1000),
      _submitChangedSearchName,
    );
  }

  _submitChangedSearchName() {
    if (_searchController.text != context.read<SearchBloc>().state.searchName) {
      context.read<SearchBloc>().add(
            SearchNameEvent(searchName: _searchController.text),
          );
    }
  }

  _refresh() {
    context.read<SearchBloc>().add(SearchRefreshEvent());
  }

  _clearSearch() {
    _searchController.clear();
    _submitChangedSearchName();
  }

  @override
  void didUpdateWidget(covariant SearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refresh();
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme(context).backgroundColor,
      appBar: AppBar(
        title: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: _searchController,
            style: getCurrentTheme(context).textTheme.bodyLarge,
            textAlignVertical: TextAlignVertical.center,
            decoration: getSearchDecoration(
              context: context,
              hint: translate("search.search"),
              clear: _clearSearch,
            ),
            onChanged: (String productName) {
              _changeSearchName();
            },
          ),
        ),
      ),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state.searchName != _searchController.text) {
            _searchController.text = state.searchName;
            _searchController.selection = TextSelection.fromPosition(
                TextPosition(offset: _searchController.text.length));
          }
        },
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) =>
              (state.searchStatus == SearchStatus.error)
                  ? ConnectionErrorWidget(
                      refreshFunction: _refresh,
                    )
                  : (state.searchStatus == SearchStatus.loading)
                      ? const SearchLoadingWidget()
                      : (state.searchName.isEmpty)
                          ? (state.searchData.isNotEmpty)
                              ? const SearchHistory()
                              : const SearchCategory()
                          : (state.searchResponseModel.products.isNotEmpty ||
                                  state.searchResponseModel.vendors.isNotEmpty)
                              ? const SearchProducts()
                              : const NotFoundError(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
