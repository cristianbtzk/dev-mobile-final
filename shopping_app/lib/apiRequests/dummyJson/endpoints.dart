import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/models/productList.dart';

String getCategoriesURL = "https://dummyjson.com/products/categories";
String getProductsByCategoryURL = "https://dummyjson.com/products/category";

Future<List<String>> getCategoriesList() async {
  final response = await http.get(
    Uri.parse(getCategoriesURL),
  );

  return (json.decode(response.body) as List)
      .map((item) => item as String)
      .toList();
}

Future<ProductListModel> getProductsByCategory(String category) async {
  final response = await http.get(
    Uri.parse('$getProductsByCategoryURL/$category'),
  );
  print('json.decode(response.body)');
  print(json.decode(response.body));
  var r = ProductListModel.fromJson(json.decode(response.body)['products']);
  print(r);
  return r;
}

Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}
