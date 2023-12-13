import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

String getCategories = "https://dummyjson.com/products/categories";

Future<List<String>> getCategoriesList() async {
  final response = await http.get(
    Uri.parse(getCategories),
  );
  //json.decode usado para decodificar o response.body(string to map)
  return (json.decode(response.body) as List)
      .map((item) => item as String)
      .toList();
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
