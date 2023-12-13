import 'package:shopping_app/models/product.dart';

class ProductListModel {
  List<Product> productList = [];

  ProductListModel({required this.productList});

  ProductListModel.fromJson(List<dynamic> parsedJson) {
    productList = <Product>[];
    parsedJson.forEach((element) {
      productList.add(Product.fromJson(element));
    });
  }
}
