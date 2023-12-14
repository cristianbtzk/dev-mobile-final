import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/addToCartBloc/addToCartEvent.dart';
import 'package:shopping_app/bloc/addToCartBloc/cartState.dart';
import 'package:shopping_app/models/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<CartEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      CartEvent event, Emitter<CartState> emit) async {
    if (event is AddToCart) {
      final updatedCart = List<Product>.from(state.cartItems)
        ..add(event.product);
      emit(CartState(updatedCart));
    } else if (event is RemoveFromCart) {
      final updatedCart = List<Product>.from(state.cartItems)
          .where((item) => item.id != event.product.id)
          .toList();
      emit(CartState(updatedCart));
    } else if (event is ClearCart) {
      emit(CartState([]));
    }
  }
}
