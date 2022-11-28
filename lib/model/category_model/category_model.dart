import 'package:delivery_service/util/service/network/parser_service.dart';

class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> response) => CategoryModel(
        id: parseToInt(response: response, key: "id"),
        name: parseToString(response: response, key: "name"),
        image: parseToString(response: response, key: "image"),
      );

  /// example = misol
  factory CategoryModel.example() => CategoryModel(
        id: 0,
        name: "",
        image: "",
      );
}

List<CategoryModel> parseCategoryModel(dynamic response) {
  final List<CategoryModel> categories = [];

  if (response is List) {
    for (var element in response) {
      final CategoryModel categoryModel = CategoryModel.fromMap(element);
      categories.add(categoryModel);
    }
  }

  return categories;
}
