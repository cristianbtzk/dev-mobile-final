import 'package:equatable/equatable.dart';
import 'package:shopping_app/models/product.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;

  AddToCart(this.product);

  @override
  List<Object> get props => [product];
}
