import 'package:delivery_service/controller/favorite_controller/favorite_bloc.dart';
import 'package:delivery_service/controller/favorite_controller/favorite_event.dart';
import 'package:delivery_service/controller/favorite_controller/favorite_state.dart';
import 'package:delivery_service/ui/favorites/favorite_null.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/ui/widgets/scrolling/custom_scroll_behavior.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  final Function goBack;

  const FavoriteScreen({
    Key? key,
    required this.goBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(
        FavoriteState.initial(),
        favoriteRepository: singleton(),
      ),
      child: FavoritePage(goBack: goBack),
    );
  }
}

class FavoritePage extends StatefulWidget {
  final Function goBack;

  const FavoritePage({
    Key? key,
    required this.goBack,
  }) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  /// restaurant favorite
  _pushButton(favoriteData, state, index) async {
    await pushNewScreen(
      context,
      restaurantScreen,
      arguments: {
        "restaurant_id": state.favoriteData[index].id,
        "product_id": 0,
        "category_id": 0,
        "go_back": widget.goBack,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            translate("favorites.appbar"),
            style: getCurrentTheme(context).textTheme.displayLarge,
          ),
          actions: [
            (state.favoriteData.isNotEmpty)
                ? InkWell(
                    onTap: () => clearFavorite(state.favoriteData),
                    child: const Icon(Icons.delete_outline),
                  )
                : Container(),
            const SizedBox(width: 8),
          ],
        ),
        backgroundColor: getCurrentTheme(context).backgroundColor,
        body: (state.favoriteData.isNotEmpty)
            ? ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ListView.builder(
                  itemCount: state.favoriteData.length,
                  itemBuilder: (context, index) => Container(
                    height: 246,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.2, color: hintColor),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => _pushButton(
                              state.favoriteData[index], state, index),
                          child: getClipRReact(
                            borderRadius: 12.0,
                            child: ImageLoading(
                              imageUrl: state.favoriteData[index].image,
                              imageWidth: double.maxFinite,
                              imageHeight: 170.0,
                              imageFitType: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.favoriteData[index].name,
                              style: getCurrentTheme(context)
                                  .textTheme
                                  .displayMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            InkWell(
                              onTap: () =>
                                  _deleteFavorite(state.favoriteData[index]),
                              child: Icon(
                                Icons.favorite,
                                color: errorTextColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, size: 15.0),
                            const SizedBox(width: 5.5),
                            Text(
                              state.favoriteData[index].rating.toString(),
                              style:
                                  getCurrentTheme(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(width: 5.5),
                            Icon(Icons.lens, size: 5.0, color: hintColor),
                            const SizedBox(width: 5.5),
                            Text(
                              "${state.favoriteData[index].deliveryTime.toString()} - ${translate("favorites.minute")}",
                              style:
                                  getCurrentTheme(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(width: 5.5),
                            Icon(Icons.lens, size: 5.0, color: hintColor),
                            const SizedBox(width: 5.5),
                            Text(
                              state.favoriteData[index].affordability
                                  .toString(),
                              style:
                                  getCurrentTheme(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const FavoriteNull(),
      ),
    );
  }

  /// delete favorite
  _deleteFavorite(favoriteData) {
    context
        .read<FavoriteBloc>()
        .add(FavoriteDeleteEvent(favoriteData: favoriteData));
  }

  /// clear favorite
  clearFavorite(favoriteData) {
    return showConfirmDialog(
      context: context,
      title: translate("favorites.clear"),
      content: "",
      confirm: _clearHistory,
    );
  }

  _clearHistory() {
    context.read<FavoriteBloc>().add(FavoriteClearEvent());
  }
}
