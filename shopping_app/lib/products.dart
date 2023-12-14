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

class ProductsScreenParams {
  String? category;

  ProductsScreenParams({this.category});
}

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State {
  Future<ProductListModel>? products;
  ProductsScreenParams? args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as ProductsScreenParams;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.blue.shade400,
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int count = state.cartItems.length;

              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    icon: const Icon(Icons.shopping_basket_outlined),
                  ),
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 15,
                        minWidth: 10,
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
      drawer: const CustomNavigationBar(),
      body: FutureBuilder(
        future: products,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loadingView();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  if (snapshot.data.productList.length > 0) {
                    return BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return Container(
                          child: Center(
                            child: ListView.builder(
                              padding: EdgeInsets.all(24),
                              itemCount: snapshot.data.productList.length,
                              itemBuilder: (context, index) {
                                return generateColum(
                                    snapshot.data.productList[index],
                                    state.cartItems.any((item) =>
                                        item.id ==
                                        snapshot.data.productList[index].id));
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              }
            case ConnectionState.none:
          }
          throw "Error";
        },
      ),
    );
  }

  @override
  void initState() {
    isConnected().then((internet) {
      if (internet) {
        setState(() {
          if (args?.category != null) {
            products = getProductsByCategory(args?.category ?? "");
          }
        });
      }
    });
    super.initState();
  }

  Widget generateColum(Product product, bool itemIsAlreadyInCart) => Card(
        child: ListTile(
          leading: Image.network(product.images![0]),
          title: Text(
            product.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(currencyFormat(product.price),
              style: const TextStyle(fontWeight: FontWeight.w600)),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: itemIsAlreadyInCart ? Colors.red : Colors.cyan,
            ),
            child: Icon(
              itemIsAlreadyInCart
                  ? Icons.remove_shopping_cart
                  : Icons.shopping_cart,
            ),
            onPressed: () {
              final cartBloc = context.read<CartBloc>();
              if (itemIsAlreadyInCart) {
                cartBloc.add(RemoveFromCart(product));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Item removed from cart'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              cartBloc.add(AddToCart(product));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item added to cart'),
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
