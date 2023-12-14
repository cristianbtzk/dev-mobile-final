import 'package:shopping_app/models/product.dart';

class Order {
  late int total;
  late DateTime date;
  late List<Product> products;

  Order({
    required this.total,
    required this.date,
    required this.products,
  });

  Order.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    date = DateTime.parse(json['date']);
    List<dynamic> list = json['products'];
    List<Product> productsTmp = [];
    for (Map<String, dynamic> i in list) {
      productsTmp.add(Product.fromJson(i));
    }
    products = productsTmp;
  }

  /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['quantity'] = quantity;
    data['category'] = category;
    data['image'] = image;
    return data;
  } */
}
