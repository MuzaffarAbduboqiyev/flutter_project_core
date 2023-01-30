import 'package:delivery_service/controller/app_controller/app_bloc.dart';
import 'package:delivery_service/controller/app_controller/app_event.dart';
import 'package:delivery_service/controller/home_controller/home_bloc.dart';
import 'package:delivery_service/controller/home_controller/home_event.dart';
import 'package:delivery_service/ui/home/home_widgets/home_category.dart';
import 'package:delivery_service/ui/home/home_widgets/home_restaurant.dart';
import 'package:delivery_service/ui/home/home_widgets/home_user.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        categoryRepository: singleton(),
        restaurantRepository: singleton(),
        locationRepository: singleton(),
      ),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _loadHomeData() {
    /// [HomeScreen] ishga tushgan vaqtda category larni serverdan yuklash eventi(amali)
    /// Bu [HomeBloc]ga [HomeGetCategoriesEvent] add bo'lganda [HomeBloc] dagi on<HomeGetCategoriesEvent> eventTransformerini chaqiradi
    /// va on<HomeGetCategoriesEvent> eventTransformerdagi [_getAllCategories] methodini ishga tushiradi.
    /// Biz HomeBloc ga HomeGetCategoriesEvent qilishdan avval HomeBlocda shu event kelsa qaysi method chaqirilishini belgilab qo'yganmiz
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: getCurrentTheme(context).backgroundColor,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeUserWidget(),
              const SizedBox(height: 8.0),
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
              const Expanded(
                child: HomeRestaurant(),
              ),
            ]),
      ),
    );
  }
}
