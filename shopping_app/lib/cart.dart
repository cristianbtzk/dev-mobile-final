import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/apiRequests/dummyJson/endpoints.dart';
import 'package:shopping_app/bloc/addToCartBloc/addToCartBloc.dart';
import 'package:shopping_app/bloc/addToCartBloc/addToCartEvent.dart';
import 'package:shopping_app/bloc/addToCartBloc/cartState.dart';
import 'package:shopping_app/currencyFormat.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/models/productList.dart';
import 'package:shopping_app/navigationbar.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.blue.shade400,
      ),
      drawer: const CustomNavigationBar(),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return const Center(
              child: Text('Cart empty'),
            );
          }

          return Center(
            child: ListView.builder(
              padding: EdgeInsets.all(24),
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                return generateColum(state.cartItems[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.check),
      ),
    );
  }

  @override
  void initState() {
    isConnected().then((internet) {
      if (internet) {
        setState(() {
          /* if (args?.category != null) {
            products = getProductsByCategory(args?.category ?? "");
          } */
        });
      }
    });
    super.initState();
  }

  Widget generateColum(Product product) => Card(
        child: ListTile(
          leading: Image.network(product.images[0]),
          title: Text(
            product.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(currencyFormat(product.price),
              style: const TextStyle(fontWeight: FontWeight.w600)),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Icon(
              Icons.remove_shopping_cart_outlined,
            ),
            onPressed: () {
              final cartBloc = BlocProvider.of<CartBloc>(context);
              cartBloc.add(RemoveFromCart(product));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item removed from cart'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      );
}

Widget loadingView() {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.red,
    ),
  );
}
