
// /// Parse to ProductCartData list from dynamic list
// List<ProductCartData> parseProductCartDataList(List<dynamic> list) {
//   return list.map((e) => parseProductCartData(e)).toList();
// }
//
// /// Parse to ProductCartData from dynamic
// ProductCartData parseProductCartData(dynamic element) => ProductCartData(
//       variationId: parseToInt(response: element, key: "id"),
//       price: parseToInt(response: element, key: "price"),
//       quantity: parseToInt(response: element, key: "quantity"),
//       productId: parseToInt(response: element["product"], key: "id"),
//       restaurantId:
//           parseToInt(response: element["product"], key: "restaurant_id"),
//       name: parseToString(response: element["product"], key: "name"),
//       excerpt: parseToString(response: element["product"], key: "excerpt"),
//       productPrice: parseToInt(response: element["product"], key: "price"),
//       productSelectedCount:
//           parseToInt(response: element["product"], key: "stock_count"),
//       hasStock: parseToBool(response: element["product"], key: "in_stock"),
//       image: parseToString(response: element["product"], key: "image"),
//       popular: parseToBool(response: element["product"], key: "is_popular"),
//       available: parseToBool(response: element["product"], key: "is_available"),
//       selectedCount: parseToInt(response: element, key: "quantity"),
//     );

/*
import 'package:delivery_service/util/service/network/parser_service.dart';
class ProductParseModel {
  final int id;
  final int price;
  final int quantity;
  final int selectedCount;
  final int productId;
  final int restaurantId;
  final String name;
  final String excerpt;
  final int productPrice;
  final int productCount;
  final bool hasStock;
  final String image;
  final bool popular;
  final bool available;

  ProductParseModel({
    required this.id,
    required this.price,
    required this.quantity,
    required this.selectedCount,
    required this.productId,
    required this.restaurantId,
    required this.name,
    required this.excerpt,
    required this.productCount,
    required this.productPrice,
    required this.hasStock,
    required this.image,
    required this.popular,
    required this.available,
  });

  factory ProductParseModel.example() => ProductParseModel(
        id: 0,
        price: 0,
        quantity: 0,
        selectedCount: 0,
        productId: 0,
        restaurantId: 0,
        name: "",
        excerpt: "",
        productCount: 0,
        productPrice: 0,
        hasStock: false,
        image: "",
        popular: false,
        available: false,
      );
}

/// Parse to ProductCartData list from dynamic list
List<ProductParseModel> parseProductParseModel(List<dynamic> list) {
  return list.map((e) => parseProductParseCartData(e)).toList();
}

/// Parse to ProductCartData from dynamic
ProductParseModel parseProductParseCartData(dynamic element) =>
    ProductParseModel(
      id: parseToInt(response: element, key: "id"),
      price: parseToInt(response: element, key: "price"),
      quantity: parseToInt(response: element, key: "quantity"),
      selectedCount: parseToInt(response: element, key: "stock_count"),
      productId: parseToInt(response: element["product"], key: "id"),
      restaurantId:
          parseToInt(response: element["product"], key: "restaurant_id"),
      name: parseToString(response: element["product"], key: "name"),
      excerpt: parseToString(response: element["product"], key: "excerpt"),
      productPrice: parseToInt(response: element["product"], key: "price"),
      productCount:
          parseToInt(response: element["product"], key: "stock_count"),
      hasStock: parseToBool(response: element["product"], key: "in_stock"),
      image: parseToString(response: element["product"], key: "image"),
      popular: parseToBool(response: element["product"], key: "is_popular"),
      available: parseToBool(response: element["product"], key: "is_available"),
    );

 */
