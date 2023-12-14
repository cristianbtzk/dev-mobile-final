class OrderProduct {
  late int id;
  late String title;
  late String description;
  late int price;
  late int quantity;
  late String category;
  late String image;

  OrderProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.image,
  });

  OrderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['quantity'] = quantity;
    data['category'] = category;
    data['image'] = image;
    return data;
  }
}
