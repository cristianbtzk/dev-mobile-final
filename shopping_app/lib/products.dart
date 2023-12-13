import 'package:flutter/material.dart';
import 'package:shopping_app/apiRequests/dummyJson/endpoints.dart';
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
                print('snapshot');
                print(snapshot);

                if (snapshot.hasData) {
                  if (snapshot.data.productList.length > 0) {
                    return Container(
                      child: Center(
                        child: ListView.builder(
                          padding: EdgeInsets.all(24),
                          itemCount: snapshot.data.productList.length,
                          itemBuilder: (context, index) {
                            return generateColum(
                                snapshot.data.productList[index]);
                          },
                        ),
                      ),
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

  Widget generateColum(Product product) => Card(
        child: ListTile(
          leading: Image.network(product.images![0]),
          title: Text(
            product.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(currencyFormat(product.price),
              style: const TextStyle(fontWeight: FontWeight.w600)),
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
