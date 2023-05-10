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
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  final Function goBack;

  const SearchScreen({Key? key, required this.goBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        SearchState.initial(),
        searchRepository: singleton(),
      ),
      child: SearchPage(goBack: goBack),
    );
  }
}

class SearchPage extends StatefulWidget {
  final Function goBack;

  const SearchPage({Key? key, required this.goBack}) : super(key: key);

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
      body: Column(
        children: [
          Container(
            decoration: getContainerDecoration(context,
                borderRadius: 0.0,
                borderColor: getCurrentTheme(context).canvasColor),
            child: TextFormField(
              controller: _searchController,
              cursorColor: textColor,
              showCursor: false,
              autofocus: false,
              textAlign: TextAlign.left,
              style: getCurrentTheme(context).textTheme.displayMedium,
              cursorRadius: const Radius.circular(16.0),
              textInputAction: TextInputAction.search,
              keyboardAppearance: Brightness.dark,
              strutStyle: const StrutStyle(),
              onChanged: (String productName) {
                _changeSearchName();
              },
              decoration: InputDecoration(
                disabledBorder:
                    const OutlineInputBorder(borderRadius: BorderRadius.zero),
                focusedBorder:
                    const OutlineInputBorder(borderRadius: BorderRadius.zero),
                enabledBorder:
                    const OutlineInputBorder(borderRadius: BorderRadius.zero),
                hintText: "Search...",

                hintStyle: getCustomStyle(
                  context: context,
                  color: hintColor,
                  weight: FontWeight.w500,
                  textSize: 16,
                ),
                fillColor: getCurrentTheme(context).backgroundColor,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                prefixIcon:
                    Icon(CupertinoIcons.search_circle, color: hintColor),
                suffixIcon: GestureDetector(
                  onTap: _clearSearch,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 16),
                    child: Icon(
                      CupertinoIcons.clear_circled,
                      color: hintColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocListener<SearchBloc, SearchState>(
              listener: (context, state) {
                if (state.searchName != _searchController.text) {
                  _searchController.text = state.searchName;
                  _searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _searchController.text.length));
                }
              },
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) => (state.searchStatus ==
                        SearchStatus.error)
                    ? ConnectionErrorWidget(refreshFunction: _refresh)
                    : (state.searchStatus == SearchStatus.loading)
                        ? const SearchLoadingWidget()
                        : (state.searchName.isEmpty)
                            ? (state.searchData.isNotEmpty)
                                ? const SearchHistory()
                                : const SearchCategory()
                            : (state.searchResponseModel.products.isNotEmpty ||
                                    state
                                        .searchResponseModel.vendors.isNotEmpty)
                                ? SearchProducts(goBack: widget.goBack)
                                : const NotFoundError(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
