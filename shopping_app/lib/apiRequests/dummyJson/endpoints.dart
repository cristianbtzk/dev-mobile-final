import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/models/order.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/models/productList.dart';

String getCategoriesURL = "https://dummyjson.com/products/categories";
String getOrders = "http://10.0.2.2:3333/api/orders";
String getProductsByCategoryURL = "https://dummyjson.com/products/category";
String postOrder = "http://10.0.2.2:3333/api/orders";

Future<List<String>> getCategoriesList() async {
  final response = await http.get(
    Uri.parse(getCategoriesURL),
  );

  return (json.decode(response.body) as List)
      .map((item) => item as String)
      .toList();
}

Future<List<Order>> getOrdersList() async {
  final response = await http.get(
    Uri.parse(getOrders),
  );
  List<Order> orders = [];
  json.decode(response.body).forEach((element) {
    orders.add(Order.fromJson(element));
  });

  return orders;
}

Future<ProductListModel> getProductsByCategory(String category) async {
  final response = await http.get(
    Uri.parse('$getProductsByCategoryURL/$category'),
  );
  var r = ProductListModel.fromJson(json.decode(response.body)['products']);
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

Future<bool> createOrder(List<Product> products) async {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['products'] = products;
  data['date'] = DateTime.now().toString();
  data['total'] = products.fold({"total": 0.0},
      (preMap, map) => {"total": preMap["total"]! + map.price})["total"];

  final response = await http.post(Uri.parse(postOrder),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: jsonEncode(data));

  return response.statusCode < 400;
}
