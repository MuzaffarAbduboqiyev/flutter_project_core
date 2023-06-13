import 'package:delivery_service/controller/home_controller/home_bloc.dart';
import 'package:delivery_service/controller/home_controller/home_event.dart';
import 'package:delivery_service/controller/home_controller/home_state.dart';
import 'package:delivery_service/controller/restaurant_controller/restaurant_state.dart';
import 'package:delivery_service/ui/home/home_widgets/appbar_drawer.dart';
import 'package:delivery_service/ui/home/home_widgets/home_category.dart';
import 'package:delivery_service/ui/home/home_widgets/home_restaurant.dart';
import 'package:delivery_service/ui/home/home_widgets/home_user.dart';
import 'package:delivery_service/ui/widgets/refresh/refresh_header.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeScreen extends StatelessWidget {
  final Function goBack;

  const HomeScreen({Key? key, required this.goBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        categoryRepository: singleton(),
        restaurantRepository: singleton(),
        locationRepository: singleton(),
        homeRepository: singleton(),
      )..add(HomeGetTokenEvent()),
      child: HomePage(goBack: goBack),
    );
  }
}

class HomePage extends StatefulWidget {
  final Function goBack;

  const HomePage({Key? key, required this.goBack}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RefreshController refreshControllerTrue = RefreshController();
  late RefreshController refreshControllerFalse = RefreshController();

  void _loadHomeData() {
    /// [HomeScreen] ishga tushgan vaqtda category larni serverdan yuklash eventi(amali)
    /// Bu [HomeBloc]ga [HomeGetCategoriesEvent] add bo'lganda [HomeBloc] dagi on<HomeGetCategoriesEvent> eventTransformerini chaqiradi
    /// va on<HomeGetCategoriesEvent> eventTransformerdagi [_getAllCategories] methodini ishga tushiradi.
    /// Biz HomeBloc ga HomeGetCategoriesEvent qilishdan avval HomeBlocda shu event kelsa qaysi method chaqirilishini belgilab qo'yganmiz
    context.read<HomeBloc>().add(HomeGetCategoriesEvent());
    context.read<HomeBloc>().add(HomeGetRestaurantsEvent());
    context.read<HomeBloc>().add(HomeGetTokenEvent());
    context.read<HomeBloc>().add(HomeGetUserInfoEvent());
  }

  _refresh() {
    context.read<HomeBloc>().add(HomeGetCategoriesEvent());
    context.read<HomeBloc>().add(HomeGetRestaurantsEvent());
  }

  @override
  initState() {
    /// [_loadHomeData] HomeScreen ishga tushganda, HomeScreenda ko'rinadigan ma'lumotlarni
    /// Serverdan olib kelish methodi
    /// Bu mehtod hali UI yig'ilmasdan avval chaqiriladi
    _loadHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.restaurantStatus == RestaurantStatus.loaded &&
            refreshControllerTrue.isRefresh) {
          refreshControllerTrue.refreshCompleted();
        } else if (state.restaurantStatus == RestaurantStatus.loaded &&
            refreshControllerFalse.isRefresh) {
          refreshControllerFalse.refreshCompleted();
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.0,
            elevation: 1.0,
            title: const HomeUserWidget(),
          ),
          drawer: HomeUserDrawer(
            goBack: widget.goBack,
            userName: state.userName,
            userSurname: state.userSurname,
            state: state,
          ),
          backgroundColor: getCurrentTheme(context).backgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              const HomeCategory(),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  translate("restaurant.restaurants"),
                  style: getCurrentTheme(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: SmartRefresher(
                  controller: refreshControllerTrue,
                  enablePullUp: false,
                  enablePullDown: true,
                  onRefresh: _refresh,
                  header: getRefreshHeader(),
                  physics: const BouncingScrollPhysics(),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: HomeRestaurant(goBack: widget.goBack),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
