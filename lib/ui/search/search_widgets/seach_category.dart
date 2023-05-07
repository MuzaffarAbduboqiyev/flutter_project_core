import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_state.dart';
import 'package:delivery_service/ui/widgets/items/category/search_category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCategory extends StatelessWidget {
  const SearchCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (prevState, currentState) {
        return currentState.searchData.isEmpty;
      },
      builder: (context, state) => ScrollConfiguration(
        behavior: const CupertinoScrollBehavior(),
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 12,
            mainAxisSpacing: 10,
            mainAxisExtent: 180,
            crossAxisCount: 2,
            childAspectRatio:
                (((MediaQuery.of(context).size.width - 48) / 2) / 180),
          ),
          itemBuilder: (_, index) => SearchCategoryItem(
            categoryModel: state.categoryModel[index],
          ),
          itemCount: state.categoryModel.length,
        ),
      ),
    );
  }
}
