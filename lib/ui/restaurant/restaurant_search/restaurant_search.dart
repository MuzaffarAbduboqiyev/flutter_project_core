import 'package:delivery_service/controller/restaurant_controller/restaurant_search_controller/restaurant_search_bloc.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_search_controller/restaurant_search_event.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_search_controller/restaurant_search_state.dart';
import 'package:delivery_service/ui/restaurant/restaurant_search/restaurant_search_widget.dart';
import 'package:delivery_service/ui/search/search_widgets/search_loading.dart';
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

class RestaurantSearchScreen extends StatelessWidget {
  final int restaurantId;
  final int categoryId;
  final Function goBack;

  const RestaurantSearchScreen({
    Key? key,
    required this.restaurantId,
    required this.categoryId,
    required this.goBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantSearchBloc(
        RestaurantSearchState.initial(),
        restaurantSearchRepository: singleton(),
      ),
      child: RestaurantSearchPage(
        restaurantId: restaurantId,
        categoryId: categoryId,
        goBack: goBack,
      ),
    );
  }
}

class RestaurantSearchPage extends StatefulWidget {
  final int restaurantId;
  final int categoryId;
  final Function goBack;

  const RestaurantSearchPage(
      {Key? key,
      required this.restaurantId,
      required this.categoryId,
      required this.goBack})
      : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  late TextEditingController _searchController;

  _changeSearchName() {
    EasyDebounce.debounce(
      "change_search_name",
      const Duration(milliseconds: 1000),
      _submitChangedSearchName,
    );
  }

  _clearSearch() {
    _searchController.clear();
    _submitChangedSearchName();
  }

  _submitChangedSearchName() {
    if (_searchController.text !=
        context.read<RestaurantSearchBloc>().state.searchName) {
      context.read<RestaurantSearchBloc>().add(
            RestaurantSearchGetProductEvent(
              searchName: _searchController.text,
              restaurantId: widget.restaurantId,
            ),
          );
    }
  }

  _refresh(state) {
    context.read<RestaurantSearchBloc>().add(RestaurantSearchGetProductEvent(
        restaurantId: widget.restaurantId, searchName: state.searchName));
    context.read<RestaurantSearchBloc>().add(RestaurantSearchListenProductEvent(
        productCartData: state.productCartData));
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                showCursor: true,
                autofocus: true,
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
                  prefixIcon: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,
                        color: getCurrentTheme(context).iconTheme.color),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: _clearSearch,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 16),
                      child: Icon(
                        CupertinoIcons.clear_circled,
                        color: getCurrentTheme(context).iconTheme.color,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocListener<RestaurantSearchBloc, RestaurantSearchState>(
                listener: (context, state) {
                  if (state.searchName != _searchController.text) {
                    _searchController.text = state.searchName;
                    _searchController.selection = TextSelection.collapsed(
                        offset: _searchController.text.length);
                  }
                },
                child: BlocBuilder<RestaurantSearchBloc, RestaurantSearchState>(
                  builder: (context, state) => (state.restaurantSearchStatus ==
                          RestaurantSearchStatus.error)
                      ? ConnectionErrorWidget(
                          refreshFunction: () => _refresh(state))
                      : (state.restaurantSearchStatus ==
                              RestaurantSearchStatus.loading)
                          ? const SearchLoadingWidget()
                          : (state.productModel.isEmpty)
                              ? (state.searchName.isNotEmpty)
                                  ? const NotFoundError()
                                  : Container()
                              : RestaurantSearchWidget(
                                  categoryId: widget.categoryId,
                                  goBack: widget.goBack,
                                ),
                ),
              ),
            ),
          ],
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
