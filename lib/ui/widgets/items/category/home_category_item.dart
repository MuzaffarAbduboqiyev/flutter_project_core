import 'package:delivery_service/controller/home_controller/home_bloc.dart';
import 'package:delivery_service/controller/home_controller/home_event.dart';
import 'package:delivery_service/model/category_model/category_model.dart';
import 'package:delivery_service/ui/widgets/clip_r_react/clip_widget.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCategoryItem extends StatefulWidget {
  final CategoryModel categoryModel;
  final int selectedCategoryItemId;

  const HomeCategoryItem({
    required this.categoryModel,
    required this.selectedCategoryItemId,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeCategoryItem> createState() => _HomeCategoryItemState();
}

class _HomeCategoryItemState extends State<HomeCategoryItem> {
  @override
  Widget build(BuildContext context) {
    /// HomeScreendagi Category ni biror itemini bosganda
    /// HomeBlocga shu bosilgan itemga kelgan categoryModel ni HomeChangeSelectedCategoryEvent  orqali  add  qilamiz,
    /// Agar HomeState dagi selectedCategoryId fieldni qiymati shu categoryModel id siga teng bo'lsa,
    /// demak bu itemga kelgan categoryModel avval tanlanga bo'ladi va biz uni tanlanmagan qilish uchun selectedCategoryId ni -1 ga tenglab qo'yamiz
    /// yoki bu itemga eklgan categoryModel id si selectedCategoryId ga teng bo'lmasa bu item tanlanmagan bo'ladi
    /// va biz buni shu categoryModel tanlangan qilish uchun selectedCategoryId ni itemga kelgan categoryModel id siga tenglab qo'yamiz va HomeBlocda yangi state ni emit qilamiz.
    ///
    ///
    /// Biz CategoryModelni tanlasak, Serverda shu Categoryga mos Restaurantlarni olib kelamiz
    /// yoki CategoryModelni tanlanmagan bo'lsa, barcha Restauranlarni olib kelamiz
    void _changeSelectedCategory() {
      context.read<HomeBloc>().add(
            HomeChangeSelectedCategoryEvent(
              categoryModel: widget.categoryModel,
            ),
          );
    }

    return InkWell(
      onTap: _changeSelectedCategory,
      child: Container(
        height: 90,
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: getContainerDecoration(
                context,
                fillColor:
                    (widget.selectedCategoryItemId != widget.categoryModel.id)
                        ? getCurrentTheme(context).backgroundColor
                        : getCurrentTheme(context).indicatorColor,
              ),
              child: Center(
                child: getClipRReact(
                  borderRadius: 4.0,
                  child: ImageLoading(
                    imageUrl: widget.categoryModel.image,
                    imageWidth: 24,
                    imageHeight: 24,
                    imageFitType: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.categoryModel.name,
              style: getCurrentTheme(context).textTheme.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
